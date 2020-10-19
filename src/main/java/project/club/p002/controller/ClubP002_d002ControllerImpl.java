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

import common.Common;
import project.club.p001.service.ClubP001_d001Service;
import project.club.p002.service.ClubP002_d002Service;
import project.club.vo.ClubMemberVO;

@Controller
public class ClubP002_d002ControllerImpl implements ClubP002_d002Controller{
	@Autowired
	ClubP002_d002Service clubP002_d002Service;
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	
	@Override
	@RequestMapping(value="/club/waitMemberList.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView waitMemberList(@RequestParam(value="c_id",required = true) String c_id) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id", c_id);
		List<ClubMemberVO> waitMember = clubP002_d002Service.waitMemberList(searchMap);
		Common.getEncodedUser(waitMember);
		ModelAndView mav = new ModelAndView("p002_d002_approve");
		mav.addObject("waitMember", waitMember);
		mav.addObject("c_id", c_id);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/permitMember.do",method= {RequestMethod.GET})
	public String permitMember(@RequestParam(value="c_id",required = true) String c_id,@RequestParam(value="m_id",required = true) String m_id) {
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("c_id", c_id);
		updateMap.put("m_id", m_id);
		clubP002_d002Service.permitMember(updateMap);
		return "redirect:/club/waitMemberList.do?c_id="+c_id;
	}
	
	@Override
	@RequestMapping(value="/club/denyMember.do",method= {RequestMethod.GET})
	public String denyMember(@RequestParam(value="c_id",required = true) String c_id,@RequestParam(value="m_id",required = true) String m_id) {
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		deleteMap.put("c_id", c_id);
		deleteMap.put("m_id", m_id);
		clubP002_d002Service.denyMember(deleteMap);
		return "redirect:/club/waitMemberList.do?c_id="+c_id;
	}
	
	@Override
	@RequestMapping(value="/club/clubMemberList.do",method= {RequestMethod.GET})
	public ModelAndView clubMemberList(@RequestParam(value="c_id",required = true) String c_id,HttpSession session) throws Exception{
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id",c_id);
		searchMap.put("m_id", m_id);
		List<ClubMemberVO> members = clubP002_d002Service.getClubMemberList(searchMap);
		String rank = clubP001_d001Service.memberCheck(searchMap);
		//회원 이미지 encoding
		Common.getEncodedUser(members);
		ModelAndView mav = new ModelAndView("clubMemberList");
		mav.addObject("members", members);
		mav.addObject("rank",rank);
		mav.addObject("c_id", c_id);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/club/qualifyMember.do",method= {RequestMethod.GET})
	public String qualifyMember(@RequestParam(value="c_id",required = true) String c_id,@RequestParam(value="m_id",required = true) String m_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id",c_id);
		searchMap.put("m_id", m_id);
		clubP002_d002Service.qualifyMember(searchMap);
		return "redirect:/club/clubMemberList.do?c_id="+c_id;
	}
	
	@Override
	@RequestMapping(value="/club/kickMember.do",method= {RequestMethod.GET})
	public String kickMember(@RequestParam(value="c_id",required = true) String c_id,@RequestParam(value="m_id",required = true) String m_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id",c_id);
		searchMap.put("m_id", m_id);
		clubP002_d002Service.kickMember(searchMap);
		return "redirect:/club/clubMemberList.do?c_id="+c_id;
	}

	@Override	//관리자 권한 회수
	@RequestMapping(value="/club/usurpMember.do",method= {RequestMethod.GET})
	public String usurpMember(@RequestParam(value="c_id",required = true) String c_id,@RequestParam(value="m_id",required = true) String m_id) throws Exception{
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("c_id",c_id);
		searchMap.put("m_id", m_id);
		clubP002_d002Service.usurpMember(searchMap);
		return "redirect:/club/clubMemberList.do?c_id="+c_id;
	}
}
