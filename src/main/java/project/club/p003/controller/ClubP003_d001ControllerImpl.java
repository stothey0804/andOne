package project.club.p003.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.service.ClubP001_d001Service;
import project.club.p003.dao.ClubP003_d001DAO;
import project.club.p003.service.ClubP003_d001Service;
import project.club.vo.ClubArticleImgVO;
import project.club.vo.ClubArticleVO;
import project.club.vo.ClubVO;

@Controller
public class ClubP003_d001ControllerImpl implements ClubP003_d001Controller{
	@Autowired
	ClubP003_d001Service clubP003_d001Service;
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubArticleVO p001_d001;
	@Autowired
	ClubP003_d001DAO clubp003_d001DAO;
	
	@Override		//게시글 삭제
	@RequestMapping(value="/club/deleteClubArticle.do",method= {RequestMethod.GET})
	public void deleteClubArticle(@RequestParam(value="ca_id",required = false) String ca_id,@RequestParam(value="c_id",required = true) String c_id) throws Exception {
		System.out.println(ca_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		clubP003_d001Service.deleteClubArticle(searchMap);
	}
	
	@Override
	@ResponseBody //게시글 이미지 삭제
	@RequestMapping(value="/club/deleteClubArticleImg.do",method= {RequestMethod.POST})
	public void deleteClubArticleImg(ClubArticleImgVO vo) throws Exception {
		System.out.println("들어와?");
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		deleteMap.put("cai_id", vo.getCai_id());
		clubP003_d001Service.deleteClubArticleImg(deleteMap);
	}

	@Override		//게시글 작성폼
	@RequestMapping(value="/club/writeArticleForm.do",method= {RequestMethod.GET})
	public ModelAndView writeArticleForm(@RequestParam(value="c_id",required = true) String c_id) throws Exception {
		System.out.println(c_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		ClubVO vo = clubP001_d001Service.detailClubCard(searchMap);

		//소모임 대표 이미지 encoding
		byte[] encoded = null;
		String clubImg = "";
		if(vo.getC_imgByte() != null) {
			encoded = Base64.getEncoder().encode(vo.getC_imgByte());
			clubImg = new String(encoded);	
		}
		ModelAndView mav = new ModelAndView("writeArticleForm");
		mav.addObject("clubInfo", vo);
		mav.addObject("clubImg", clubImg);
		return mav;
	}
	
	@Override		//게시글 작성
	@RequestMapping(value="/club/writeArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String writeArticle(ClubArticleVO vo, HttpServletRequest request, HttpSession session, MultipartHttpServletRequest mtfRequest) throws Exception{
		String m_id = (String) session.getAttribute("m_id");
		System.out.println(vo.getC_id());
		List<MultipartFile> mf = mtfRequest.getFiles("ca_img");
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("ca_content", vo.getCa_content());
		insertMap.put("m_id", m_id);
		insertMap.put("c_id", vo.getC_id());
		String ca_id = clubP003_d001Service.writeArticle(insertMap);
		insertMap.put("ca_id", ca_id);
		if(!mf.get(0).isEmpty()) {
			System.out.println("이미지 갯수!!!!!!!!!!!"+vo.getCa_img().size());
			for(int i=0; i<vo.getCa_img().size();i++) {
				System.out.println(i);
				insertMap.put("ca_img", mf.get(i).getBytes());
				clubp003_d001DAO.insertClubArticleImg(insertMap);
			}
		}
		return "redirect:/club/detailClub.do?c_id="+vo.getC_id();
	}
	
	@Override		//게시글 수정
	@RequestMapping(value="/club/editArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String editArticle(ClubArticleVO vo, HttpServletRequest request, HttpSession session, MultipartHttpServletRequest mtfRequest) throws Exception{
		List<MultipartFile> mf = mtfRequest.getFiles("ca_img");
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("ca_content", vo.getCa_content());
		updateMap.put("ca_id", vo.getCa_id());
		clubP003_d001Service.updateArticle(updateMap);
		if(!mf.get(0).isEmpty()) {
			System.out.println("이미지 갯수ㅜㅜㅜㅜㅜㅜㅜ"+vo.getCa_img().size());
			for(int i=0; i<vo.getCa_img().size();i++) {
				System.out.println(i);
				updateMap.put("ca_img", mf.get(i).getBytes());
				clubp003_d001DAO.updateClubArticleImg(updateMap);
			}
		}
		return "redirect:/club/detailClub.do?c_id="+vo.getC_id();
	}
	
	@Override		//게시글 수정폼
	@RequestMapping(value="/club/editClubArticleForm.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView editArticle(@RequestParam(value="ca_id", required=true) String ca_id,@RequestParam(value="c_id", required=true) String c_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		searchMap.put("c_id", c_id);
		ClubArticleVO articleVO = clubP003_d001Service.editArticle(searchMap);
		List<ClubArticleImgVO> imgVO = clubP003_d001Service.editArticleImg(searchMap);
		ClubVO vo = clubP001_d001Service.detailClubCard(searchMap);

		byte[] encoded = null;
		//소모임 게시글 이미지 encoding
			for(int i=0;i<imgVO.size();i++) {
				if(imgVO.get(i).getArticleImg() != null) {
					encoded = Base64.getEncoder().encode(imgVO.get(i).getArticleImg());
					imgVO.get(i).setResultArticleImg(new String(encoded));
				}
			}
		String clubImg="";
		if(vo.getC_imgByte() != null) {
			clubImg = encodedClubImg(vo);
		}
		ModelAndView mav = new ModelAndView("editArticle");
		mav.addObject("articleInfo", articleVO);
		mav.addObject("clubInfo", vo);
		mav.addObject("articleImg", imgVO);
		mav.addObject("clubImg", clubImg);
		return mav;
	}
	
	public String encodedClubImg(ClubVO vo) {
		byte[] encoded = Base64.getEncoder().encode(vo.getC_imgByte());
		String clubImg = new String(encoded);
		return clubImg;
	}
}
