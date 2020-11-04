package project.and.p003.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface AndP003_d001Controller {

	//채팅방 불러오기
	public ModelAndView Message(HttpSession session, HttpServletRequest request) throws Exception;


}
