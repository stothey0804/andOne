package project.club.p002.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubP001_d001VO;

public interface ClubP002_d001Controller {
	public ModelAndView createClubForm() throws Exception;
 	public String createClub(ClubP001_d001VO vo, HttpSession session) throws Exception;
}
