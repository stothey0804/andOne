package project.and.p002.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import project.and.p002.service.AndP002_d003Service;

@Controller
@RequestMapping(value="/and*/*")
public class AndP002_d003ControllerImpl implements AndP002_d003Controller {
	@Autowired
	private AndP002_d003Service p002_d003Service;
	
	@Override
	@RequestMapping(value="MyAndOnePage.do")
	public String MyAndOnePage() {
		System.out.println(">>>>>>>>>>>내 엔분의일 페이지 이동");
		return "MyAndOne";
	}

}
