package project.member.p003.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import project.member.p003.service.MemberP003_d001Service;
import project.member.p003.vo.MemberP003VO;

/*
 * @Title	신고하기
 * @Author	김세영
 * @Date	2020.10.27.
 * 
 * */

@Controller
@RequestMapping("/member")
public class MemberP003_d001ControllerImpl implements MemberP003_d001Controller{
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	MemberP003_d001Service memberP003_d001Service;
	
	// 회원신고
	@RequestMapping("/reportInit.do")
	public ModelAndView reportInit(@RequestParam String target, @RequestParam String flag) {
		ModelAndView mav = new ModelAndView("member/p003_d001_insert_popup");
		String sendFlag = "";
		if("member".equals(flag)) {
			sendFlag = "013";
		}else if("club".equals(flag)) {
			sendFlag = "014";
		}else if("one".equals(flag)) {
			sendFlag = "015";
		}
		// 신고건유형 조회
		List<HashMap<String, String>> rTypeList = commonService.searchCommonCodeList(sendFlag);	// 그룹ID별 조회
		// 바인딩
		mav.addObject("r_target", target);
		mav.addObject("flag", sendFlag);
		mav.addObject("rTypeList", rTypeList);
		return mav;
	}	
	
	// 신고 전송
	@RequestMapping(value="/saveReport.do", method=RequestMethod.POST)
	public String saveReport(@ModelAttribute MemberP003VO param) {
		System.out.println("param==========>" + param.toString());
		try {
			memberP003_d001Service.saveReport(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/p003_d001_success";
	}
	
	// 내가 쓴 신고 조회
	@RequestMapping("/searchReport.do")
	public ModelAndView searchReport() {
		ModelAndView mav = new ModelAndView("");
		
		return mav;
	} 
	//
	
}
