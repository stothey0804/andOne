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

import project.club.p001.dao.ClubP001_d001DAO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.vo.ClubP001_d001VO;

@Controller
public class ClubP001_d001ControllerImpl implements ClubP001_d001Controller{
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubP001_d001VO p001_d001;
	@Autowired
	ClubP001_d001DAO dao;
	
	@Override
	@RequestMapping(value="/club/clubMain.do",method= {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView clubMain(@RequestParam(value="m_id", required=false) String m_id, HttpSession session) throws Exception{
		List<ClubP001_d001VO> clubList = clubP001_d001Service.clubList();
		List<ClubP001_d001VO> myClubList = clubP001_d001Service.myClubList(m_id);
		session.setAttribute("m_id", m_id);
		ModelAndView mav = new ModelAndView("clubMain");
		mav.addObject("clubList",clubList);
		mav.addObject("myClubList",myClubList);
		mav.addObject("myClubCnt", myClubList.size());
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/p001/searchClub.do",method= {RequestMethod.POST})
	public ModelAndView searchClubList(@RequestParam(value="searchWord", required=false) String searchWord) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("searchWord", "%"+searchWord+"%");
		List<ClubP001_d001VO> list = clubP001_d001Service.searchClubList(searchMap);
		ModelAndView mav = new ModelAndView("searchList");
		mav.addObject("resultList",list);
		mav.addObject("cnt", list.size());
		mav.addObject("searchWord",searchWord); 
		return mav;
	}
	
	@Override
	@RequestMapping(value="/detailClub.do",method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView detailClub(@RequestParam(value="c_id",required = true) String c_id, HttpSession session) throws Exception{
		String m_id = (String)session.getAttribute("m_id");
		System.out.println("===========yasyayayyay"+m_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		searchMap.put("m_id",m_id);
		ClubP001_d001VO vo = clubP001_d001Service.detailClub(searchMap);
		System.out.println("**************"+m_id);
		
		byte[] encoded = null;
		String clubImg = "";
		
//		소모임 대표 이미지 encoding
		if(vo.getC_imgByte() != null) {
			encoded = Base64.getEncoder().encode(vo.getC_imgByte());
			clubImg = new String(encoded);	
		}
		
//		회원 등급 확인
		String rank = clubP001_d001Service.memberCheck(searchMap);
		
//		소모임 게시글 이미지 encoding
		for(int i=0; i<vo.getArticleList().size();i++) {
			if(vo.getArticleList().get(i).getImgList()!=null) {
				encoded = Base64.getEncoder().encode(vo.getArticleList().get(i).getImgList());
				String encodedString = new String(encoded);
				vo.getArticleList().get(i).setResultImgList(encodedString);
			} 
		}
		ModelAndView mav = new ModelAndView("detailClub");
		mav.addObject("clubInfo", vo);
		mav.addObject("rank", rank);
		mav.addObject("clubImg", clubImg);
		return mav;
	}
	
}
