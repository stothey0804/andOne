package project.club.p003.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import project.club.p003.dao.ClubP003_d003DAO;
import project.club.p003.service.ClubP003_d003Service;

@Controller
public class ClubP003_d003ControllerImpl implements ClubP003_d003Controller{
	@Autowired
	ClubP003_d003Service clubP003_d003Service;
	@Autowired
	ClubP003_d003DAO clubp003_d003DAO;
	
	@Override
	@ResponseBody	//댓글 쓰기
	@RequestMapping(value="/club/insertReply.do",method= {RequestMethod.GET})
	public void insertReply(@RequestParam(value = "ca_id",required = true) String ca_id,@RequestParam(value="car_content",required=true) String car_content,@RequestParam(value="p_car_id",required = false) String p_car_id,
			HttpSession session,HttpServletResponse response) throws IOException {
		PrintWriter writer = response.getWriter();
		String m_id = (String)session.getAttribute("m_id");
		Map<String, Object> insertMap = new HashMap<String, Object>();
		System.out.println("++++++++++++"+p_car_id);
		insertMap.put("ca_id",ca_id);
		insertMap.put("m_id",m_id);
		insertMap.put("car_content",car_content);
		insertMap.put("p_car_id",p_car_id);
		clubP003_d003Service.insertReply(insertMap);
		
		String next_car_id = clubp003_d003DAO.next_car_id();
		JSONObject totalObject = new JSONObject();
		totalObject.put("car_id", next_car_id);
		String jsonInfo = totalObject.toString();
		writer.print(jsonInfo);
		
	}
	
	@Override
	@ResponseBody	//댓글 삭제
	@RequestMapping(value="/club/deleteReply.do",method= {RequestMethod.GET})
	public void deleteReply(@RequestParam(value = "car_id",required = true) String car_id) {
		System.out.println("+++++++++++++++");
		Map<String, Object> deleteMap = new HashMap<String, Object>();
		deleteMap.put("car_id",car_id);
		clubP003_d003Service.deleteReply(deleteMap);
	}

	@Override
	@ResponseBody
	@RequestMapping(value="/club/editReply.do",method = {RequestMethod.GET})
	public void editReply(@RequestParam(value="car_id",required = true)String car_id,@RequestParam(value="car_content",required = true) String car_content) {
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("car_id", car_id);
		updateMap.put("car_content", car_content);
		clubP003_d003Service.updateReply(updateMap);
	}
	
		
}
