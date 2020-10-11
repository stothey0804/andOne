package project.member.p002.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface MemberP002_d001Controller {
	public ModelAndView initMemberQnA(HttpServletRequest request);	// 문의하기 작성 view 연결
	public String insertMemberQnA(Map<String, String> param, HttpServletRequest request);	// 문의하기 전송 
	public ModelAndView searchMemberQnA(int curPage, HttpServletRequest request);	// 리스트 조회
	public String deleteMemberQnA(HttpServletRequest request);
}
