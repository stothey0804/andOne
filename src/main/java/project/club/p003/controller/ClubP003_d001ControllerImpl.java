package project.club.p003.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.service.ClubP001_d001Service;
import project.club.p003.dao.ClubP003_d001DAO;
import project.club.p003.service.ClubP003_d001Service;
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
	@RequestMapping(value="/deleteClubArticle.do",method= {RequestMethod.GET})
	public String deleteClubArticle(@RequestParam(value="ca_id",required = false) String ca_id,@RequestParam(value="c_id",required = true) String c_id) throws Exception {
		System.out.println(ca_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		clubP003_d001Service.deleteClubArticle(searchMap);
		return "redirect:/detailClub.do?c_id="+c_id;
	}

	@Override		//게시글 작성폼
	@RequestMapping(value="/club/writeArticleForm.do",method= {RequestMethod.GET})
	public ModelAndView writeArticleForm(@RequestParam(value="c_id",required = true) String c_id) throws Exception {
		System.out.println(c_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		ClubVO vo = clubP001_d001Service.detailClub(searchMap);
		ModelAndView mav = new ModelAndView("writeArticleForm");
		mav.addObject("clubInfo", vo);
		return mav;
	}
	
	@Override		//게시글 작성
	@RequestMapping(value="/writeArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public String writeArticle(ClubArticleVO vo, HttpServletRequest request) throws Exception{
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("ca_img", vo.getCa_img().getBytes());
		insertMap.put("ca_content", vo.getCa_content());
		insertMap.put("m_id", vo.getM_id());
		insertMap.put("c_id", vo.getC_id());
		clubP003_d001Service.writeArticle(insertMap);
		return "redirect:/detailClub.do?c_id="+vo.getC_id();
	}
	
	@Override		//게시글 수정
	@RequestMapping(value="/editClubArticle.do", method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView editArticle(@RequestParam(value="ca_id", required=true) String ca_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("ca_id", ca_id);
		ClubArticleVO articleVO = clubP003_d001Service.editArticle(searchMap);
		ModelAndView mav = new ModelAndView("editArticle");
		mav.addObject("articleInfo", articleVO);
		return mav;
	}

}
