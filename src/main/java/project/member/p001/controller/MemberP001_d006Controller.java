package project.member.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import project.member.p001.vo.MemberP001_d006VO;


public interface MemberP001_d006Controller {
//	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public MemberP001_d006VO memberDetail(String m_id, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
	public String searchMemberList(int curPage, Map<String, String> param, Model model);
//	public String searchMemberList(int curPage, MemberP001_d006VO vo, Model model);
}
