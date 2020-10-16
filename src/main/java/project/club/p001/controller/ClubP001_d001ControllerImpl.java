package project.club.p001.controller;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.service.ClubP001_d001Service;
import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

@Controller
public class ClubP001_d001ControllerImpl implements ClubP001_d001Controller{
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubVO p001_d001;
	
	@Override      //소모임 메인페이지
	@RequestMapping(value="/club/clubMain.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView clubMain(HttpSession session) throws Exception{
		String m_id = (String) session.getAttribute("m_id");
		//상위 멤버수 소모임 리스트
		List<ClubVO> clubList = clubP001_d001Service.clubList();
		//나의 소모임 리스트
		List<ClubVO> myClubList = clubP001_d001Service.myClubList(m_id);
		//소모임 대표이미지 encoding
		getEncoded(clubList);
		getEncoded(myClubList);
		
		ModelAndView mav = new ModelAndView("clubMain");
		mav.addObject("clubList",clubList);
		mav.addObject("myClubList",myClubList);
		mav.addObject("myClubCnt", myClubList.size());
		return mav;
	}
	
	@Override		//소모임 검색결과 페이지
	@RequestMapping(value="/searchClub.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView searchClubList(@RequestParam(value="searchWord", required=false) String searchWord) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchWord", "%"+searchWord+"%");
		List<ClubVO> list = clubP001_d001Service.searchClubList(searchMap);
		
		//소모임 대표이미지 encoding
		getEncoded(list);
		ModelAndView mav = new ModelAndView("searchList");
		mav.addObject("resultList",list);
		mav.addObject("cnt", list.size());
		mav.addObject("searchWord",searchWord); 
		return mav;
	}
	
	@Override		//소모임 상세페이지
	@RequestMapping(value="/detailClub.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView detailClub(@RequestParam(value="c_id",required = true) String c_id, HttpSession session) throws Exception{
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		searchMap.put("m_id",m_id);
		ClubVO vo = clubP001_d001Service.detailClub(searchMap);
		//회원 등급 확인
		String rank = clubP001_d001Service.memberCheck(searchMap);
		
		byte[] encoded = null;
		String clubImg = "";
		//소모임 대표 이미지 encoding
		if(vo.getC_imgByte() != null) {
			encoded = Base64.getEncoder().encode(vo.getC_imgByte());
			clubImg = new String(encoded);	
		}
		
		//소모임 게시글 이미지 encoding
		for(int i=0; i<vo.getArticleList().size();i++) {
			if(vo.getArticleList().get(i).getArticleImgList()!=null) {
				System.out.println("낫널");
				for(int j=0; j < vo.getArticleList().get(i).getArticleImgList().size();j++) {
					if(vo.getArticleList().get(i).getArticleImgList().get(j) != null) {
						System.out.println("낫널");
						encoded = Base64.getEncoder().encode((byte[]) vo.getArticleList().get(i).getArticleImgList().get(j).getArticleImg());
						vo.getArticleList().get(i).getArticleImgList().get(j).setResultArticleImg(new String(encoded));
						System.out.println(encoded);
					}
				}
			}
			if(vo.getArticleList().get(i).getUserImg()!=null) {
				encoded = Base64.getEncoder().encode(vo.getArticleList().get(i).getUserImg());
				vo.getArticleList().get(i).setResultUserImg(new String(encoded));
			}
		}
	
		//운영진 목록
		List<ClubMemberVO> leader = clubP001_d001Service.getLeaderMember(searchMap);
		//일반 회원 목록
		List<ClubMemberVO> members = clubP001_d001Service.getClubMember(searchMap);
		//회원 목록 이미지 encoding
		getEncodedUser(members);
		getEncodedUser(leader);
		
		ModelAndView mav = new ModelAndView("detailClub");
		mav.addObject("clubInfo", vo);
		mav.addObject("rank", rank);
		mav.addObject("clubImg",clubImg);
		mav.addObject("members", members);
		mav.addObject("leader", leader);
		return mav;
	}
	
	//article encoding method
	public void getEncoded(List<ClubVO> list) {
		byte[] encoded = null;
		for(int i=0; i < list.size();i++) {
			if(list.get(i).getC_imgByte() != null) {
				encoded = Base64.getEncoder().encode(list.get(i).getC_imgByte());
				list.get(i).setResultImg(new String(encoded));	
			}
		}
	}
	//UserImg encoding method
	public void getEncodedUser(List<ClubMemberVO> list) {
		byte[] encoded = null;
		for(int i=0; i < list.size();i++) {
			if(list.get(i).getUserImg() != null) {
				encoded = Base64.getEncoder().encode(list.get(i).getUserImg());
				list.get(i).setResultUserImg(new String(encoded));	
			}
		}
	}
}
