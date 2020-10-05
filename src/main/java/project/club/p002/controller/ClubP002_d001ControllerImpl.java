package project.club.p002.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import project.club.p002.service.ClubP002_d001Service;
import project.club.vo.ClubP001_d001VO;

@Controller
public class ClubP002_d001ControllerImpl implements ClubP002_d001Controller{
	@Autowired
	ClubP002_d001Service clubP002_d001Service;
	
	@Override
	@RequestMapping(value="/createClubForm.do",method= {RequestMethod.GET})
	public ModelAndView createClubForm() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/createClub.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView createClub(ClubP001_d001VO vo, HttpSession session) throws Exception {
		System.out.println("컨트롤러 들어옴?????????????????");
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("c_name", vo.getC_name());
		System.out.println();
		insertMap.put("c_category", vo.getC_category());
		insertMap.put("c_hashtag", vo.getC_hashtag());
		insertMap.put("c_membermax", vo.getC_membermax());
		insertMap.put("c_content", vo.getC_content());
		insertMap.put("c_img",vo.getC_img().getBytes());
		String c_id = clubP002_d001Service.nextC_id();
		insertMap.put("c_id", c_id);
		clubP002_d001Service.createClub(insertMap);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("==========="+m_id);
		insertMap.put("m_id", m_id);
		clubP002_d001Service.insertLeader(insertMap);
		ModelAndView mav = new ModelAndView("createClubResult");
		mav.addObject("c_id", c_id);
		return mav;
	}
}
