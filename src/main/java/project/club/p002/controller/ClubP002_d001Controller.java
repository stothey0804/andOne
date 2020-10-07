package project.club.p002.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubVO;

public interface ClubP002_d001Controller {
	public ModelAndView createClubForm() throws Exception;
 	public String createClub(ClubVO vo, HttpSession session) throws Exception;
}
