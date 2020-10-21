package project.club.p002.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubVO;

public interface ClubP002_d001Controller {
	public ModelAndView createClubForm() throws Exception;
 	public String createClub(ClubVO vo, HttpSession session) throws Exception;
 	public String deleteClub(String c_id, HttpSession session);
 	public ModelAndView updateClubForm(String c_id);
 	public String updateClub(String c_id, ClubVO vo) throws IOException;
}
