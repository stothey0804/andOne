package project.club.p003.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import project.club.p003.dao.ClubP003_d002DAO;
import project.club.p003.service.ClubP003_d002Service;
import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

@Controller
public class ClubP003_d002ControllerImpl implements ClubP003_d002Controller{
	@Autowired
	ClubP003_d002Service clubP003_d002Service;
	@Autowired
	ClubP003_d002DAO clubp003_d002DAO;
	
	@Override
	@RequestMapping(value="/club/joinClub.do",method= {RequestMethod.POST})
	public String joinClub(@RequestParam(value="c_id",required = true)String c_id,ClubMemberVO vo, HttpSession session) {
		String m_id = (String) session.getAttribute("m_id");
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("cm_intro",vo.getCm_intro());
		insertMap.put("m_id", m_id);
		insertMap.put("c_id", c_id);
		clubP003_d002Service.joinClub(insertMap);
		return "redirect:/detailClub.do?c_id="+c_id;
	}
	
	@Override
	@RequestMapping(value="/club/leaveClub.do",method= {RequestMethod.GET,RequestMethod.POST})
	public String leaveClub(@RequestParam(value="c_id",required = true) String c_id,HttpSession session) {
		String m_id = (String) session.getAttribute("m_id");
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		deleteMap.put("c_id", c_id);
		deleteMap.put("m_id", m_id);
		clubP003_d002Service.leaveClub(deleteMap);
		return "redirect:/club/clubMain.do";
	}

	@Override
	@RequestMapping(value="/club/reportClub.do",method= {RequestMethod.GET,RequestMethod.POST})
	public String reportClub(@RequestParam(value="c_id",required = true) String c_id,ClubVO vo) {
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("c_id", c_id);
		insertMap.put("rc_type",vo.getRc_type());
		clubP003_d002Service.reportClub(insertMap);
		return "redirect:/club/detailClub.do?c_id="+c_id;
	}
		
}
