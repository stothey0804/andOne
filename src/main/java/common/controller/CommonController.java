package common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.service.CommonService;

@Controller
public class CommonController {
	
	@Autowired
	CommonService commonService;
	
	// 소모임명 조회
	@RequestMapping(value = "/selectClubName.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectClubName(@RequestParam String c_id) {
		return commonService.selectClubName(c_id);
	}
	
	// 소모임장 아이디 조회
	@RequestMapping("/selectClubManager.do")
	@ResponseBody
	public String selectClubManager(@RequestParam String c_id) {
		return commonService.selectClubManager(c_id);
	}
	
	@RequestMapping("/selectCommonCodeName.do")
	@ResponseBody
	public String selectCommonCodeName() {
		
		return "";
	}
	
}
