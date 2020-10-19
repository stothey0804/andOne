package project.club.p002.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface ClubP002_d002Controller {
	public ModelAndView waitMemberList(String c_id);
	public String permitMember(String c_id, String m_id);
	public String denyMember(String c_id, String m_id);
	public ModelAndView clubMemberList(String c_id, HttpSession session) throws Exception;
	public String qualifyMember(String c_id, String m_id) throws Exception;
	public String kickMember(String c_id, String m_id) throws Exception;
	public String usurpMember(String c_id, String m_id) throws Exception;
}
