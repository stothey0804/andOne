package project.and.p003.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AndP003_d001ControllerImpl implements AndP003_d001Controller{

	//메세지 이동
	@Override
	@RequestMapping(value="/and*/Message.do")
	public String Message(){
		System.out.println(">>>>>>> 메세지 <<<<<<<<");
		return "message";
	}
	
	
}
