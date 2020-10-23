package project.club.p001.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface ClubP001_d001Controller {
	public ModelAndView searchClubList(String searchWord) throws Exception;
	public ModelAndView clubMain(HttpSession session) throws Exception;
	public ModelAndView detailClub(String c_id, HttpSession session) throws Exception;
	public ModelAndView searchClubCategory(String c_category) throws Exception;
}
