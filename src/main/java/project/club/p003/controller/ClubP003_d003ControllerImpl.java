package project.club.p003.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.club.p003.dao.ClubP003_d003DAO;
import project.club.p003.service.ClubP003_d003Service;

@Controller
public class ClubP003_d003ControllerImpl implements ClubP003_d003Controller{
	@Autowired
	ClubP003_d003Service clubP003_d003Service;
	@Autowired
	ClubP003_d003DAO clubp003_d003DAO;
	
	@Override
	@ResponseBody
	@RequestMapping(value="/club/insertReply.do",method= {RequestMethod.GET})
	public void insertReply(@RequestParam(value = "ca_id",required = true) String ca_id,@RequestParam(value="car_content",required=true) String car_content,HttpSession session) {
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("ca_id",ca_id);
		insertMap.put("m_id",m_id);
		insertMap.put("car_content",car_content);
		clubP003_d003Service.insertReply(insertMap);
	}
	
	@Override
	@ResponseBody
	@RequestMapping(value="/club/deleteReply.do",method= {RequestMethod.GET})
	public void deleteReply(@RequestParam(value = "car_id",required = true) String car_id) {
		System.out.println("+++++++++++++++");
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		deleteMap.put("car_id",car_id);
		clubP003_d003Service.deleteReply(deleteMap);
	}
	
		
}
