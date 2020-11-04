package project.club.p002.controller;

import java.io.IOException;
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
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.dao.CommonDAO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.p002.service.ClubP002_d001Service;
import project.club.vo.ClubVO;

@Controller
public class ClubP002_d001ControllerImpl implements ClubP002_d001Controller{
	@Autowired
	ClubP002_d001Service clubP002_d001Service;
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	CommonDAO commonDAO;
	
	@Override
	@RequestMapping(value="/club/createClubForm.do",method= {RequestMethod.GET})
	public ModelAndView createClubForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName(Common.checkLoginDestinationView("createClub", request));
		List<HashMap<String, String>> category = commonDAO.searchCommonCodeList("019");
		mav.addObject("category", category);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/createClub.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String createClub(ClubVO vo, HttpSession session) throws Exception {
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("c_name", vo.getC_name());
		System.out.println();
		insertMap.put("c_category", vo.getC_category());
		insertMap.put("c_hashtag", vo.getC_hashtag());
		insertMap.put("c_membermax", vo.getC_membermax());
		insertMap.put("c_content", vo.getC_content());
		insertMap.put("c_img",vo.getC_img().getBytes());
		insertMap.put("c_ask",vo.getC_ask());
		String c_id = clubP002_d001Service.nextC_id();
		insertMap.put("c_id", c_id);
		clubP002_d001Service.insertClub(insertMap);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("==========="+m_id);
		insertMap.put("m_id", m_id);
		clubP002_d001Service.insertLeader(insertMap);
		return "forward:/club/detailClub.do?c_id="+c_id;
	}
	
	@Override
	@RequestMapping(value="/club/deleteClub.do",method= {RequestMethod.GET})
	public String deleteClub(@RequestParam(value="c_id",required = true) String c_id, HttpSession session) {
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		searchMap.put("m_id", m_id);
		String rank = clubP001_d001Service.memberCheck(searchMap);
		System.out.println(rank+"================");
		if(rank.equals("10")) {
			clubP002_d001Service.deleteClub(searchMap);
		} else {
			System.out.println("nono");
		}
		return "redirect:/club/clubMain.do";
	}
	
	@Override
	@RequestMapping(value="/club/updateClubForm.do",method= {RequestMethod.GET})
	public ModelAndView updateClubForm(@RequestParam(value="c_id",required = true)String c_id) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		//카테고리 목록 가져오기
		List<HashMap<String, String>> category = commonDAO.searchCommonCodeList("019");
		ClubVO vo = clubP002_d001Service.detailClub_forUpdate(searchMap);
		//소모임 대표 이미지 encoding
		byte[] encoded = null;
		String clubImg = "";
		if(vo.getC_imgByte() != null) {
			encoded = Base64.getEncoder().encode(vo.getC_imgByte());
			clubImg = new String(encoded);	
		}
		ModelAndView mav = new ModelAndView("updateClubForm");
		mav.addObject("category", category);
		mav.addObject("clubInfo", vo);
		mav.addObject("clubImg", clubImg);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/updateClub.do",method= {RequestMethod.GET,RequestMethod.POST})
	public String updateClub(@RequestParam(value="c_id",required = true)String c_id, ClubVO vo) throws IOException {
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("c_name", vo.getC_name());
		insertMap.put("c_category", vo.getC_category());
		insertMap.put("c_hashtag", vo.getC_hashtag());
		insertMap.put("c_membermax", vo.getC_membermax());
		insertMap.put("c_content", vo.getC_content());
		insertMap.put("c_img",vo.getC_img().getBytes());
		insertMap.put("c_ask",vo.getC_ask());
		insertMap.put("c_id", c_id);
		clubP002_d001Service.updateClub(insertMap);
		return "redirect:/club/detailClub.do?c_id="+c_id;
	}
}
