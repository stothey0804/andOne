package project.member.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MemberP001_d001Controller {
	public String joinMember(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void confirmSMSCode(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void searchOverlapEmail(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void searchOverlapPhone(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView addMember(Map<String, String> param, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
