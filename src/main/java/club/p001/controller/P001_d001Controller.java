package club.p001.controller;

import org.springframework.web.servlet.ModelAndView;

public interface P001_d001Controller {
	public ModelAndView clubMain() throws Exception;
	public ModelAndView searchClubList(String searchWord) throws Exception;
	public ModelAndView detailClub(String p_c_id) throws Exception;
}
