package common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.service.CommonService;

@Controller
public class CommonController {
	
	@Autowired
	CommonService commonService;
	

	
	@RequestMapping("/selectCommonCodeName.do")
	@ResponseBody
	public String selectCommonCodeName() {
		
		return "";
	}
	
}
