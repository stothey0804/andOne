package project.club.p002.controller;

import org.springframework.web.servlet.ModelAndView;

public interface ClubP002_d002Controller {
	public ModelAndView waitMemberList(String c_id);
	public String permitMember(String c_id, String m_id);
	public String denyMember(String c_id, String m_id);
}
