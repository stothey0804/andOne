package project.member.p004.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.member.p001.service.MemberP001_d005Service;
import project.member.p004.service.MemberP004_d001Service;

/*
 * 회원 평가
 * 작성자 : 김세영
 * */


@Controller
@RequestMapping("/member")
public class MemberP004_d001ControllerImpl implements MemberP004_d001Controller{

	@Autowired
	MemberP004_d001Service memberP004_d001Service;
	
	@Autowired
	MemberP001_d005Service memberP001_d005Service;	// 프로필 조회용
	
	@Override
	@RequestMapping("/searchMemberInfoPopup.do")
	public ModelAndView searchMemberInfoPopup(HttpServletRequest request, @RequestParam String m_id) {
		ModelAndView mav = new ModelAndView("member/member_popup");
		Map<String, String> result = memberP004_d001Service.searchMemberInfo(m_id);	// 조회
		String encodedProfileImg = Common.encodeBlobImage(m_id, memberP001_d005Service);
		result.put("m_img", encodedProfileImg);
		mav.addObject("info", result);
		System.out.println("============>info " + result);
		// 평가조회도 넘겨야함.
		return mav;
	}
	
	// 회원등급 메인
	
	
	// 내가 받은 평가
	
	// 내가 남긴 평가
	
	
}
