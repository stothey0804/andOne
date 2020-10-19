package project.club.p002.controller;

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
	public ModelAndView createClubForm() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
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
		clubP002_d001Service.createClub(insertMap);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("==========="+m_id);
		insertMap.put("m_id", m_id);
		clubP002_d001Service.insertLeader(insertMap);
		ModelAndView mav = new ModelAndView("createClubResult");
		mav.addObject("c_id", c_id);
		return "forward:/detailClub.do?c_id="+c_id;
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
}
