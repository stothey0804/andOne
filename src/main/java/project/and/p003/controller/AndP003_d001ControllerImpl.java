package project.and.p003.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import project.and.p003.service.AndP003_d001Service;

@Controller
public class AndP003_d001ControllerImpl implements AndP003_d001Controller{

	@Autowired 
	AndP003_d001Service andP003_d001Service;
	
	
	//메세지 이동
	@Override
	@RequestMapping(value="/and*/Message.do")
	public ModelAndView Message(){
		ModelAndView mav = new ModelAndView("message");
		System.out.println(">>>>>>> 메세지 <<<<<<<<");
		
//		mav.addObject("readChatList",AndP003_d001Service.chatRoom());
		return mav;
	}

}
