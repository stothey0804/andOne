package project.member.p004.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface MemberP004_d001Controller {

	ModelAndView searchMemberInfoPopup(HttpServletRequest request, String m_id);	// 멤버조회

}
