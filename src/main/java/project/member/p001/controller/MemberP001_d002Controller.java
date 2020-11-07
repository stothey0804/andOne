package project.member.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface MemberP001_d002Controller {
	// 로그인
	public String login(Map<String, String> param, HttpServletRequest request, HttpServletResponse response, HttpSession session)	throws Exception;
	// 로그아웃
	String logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
