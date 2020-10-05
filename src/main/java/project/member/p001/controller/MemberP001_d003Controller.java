package project.member.p001.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface MemberP001_d003Controller {
	//비밀번호찾기
	public String searchMemberPwd();
	//메일전송
	public String searchMemberPwdComplete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//비밀번호 체크
	public ModelAndView emailCheck(HttpServletRequest request);
	//비밀번호 변경
	public String updatePwd(HttpServletRequest request);
}
