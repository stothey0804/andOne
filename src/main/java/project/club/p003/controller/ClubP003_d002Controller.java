package project.club.p003.controller;

import javax.servlet.http.HttpSession;

import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

public interface ClubP003_d002Controller {
	public String joinClub(String c_id, ClubMemberVO vo, HttpSession session);
	public String leaveClub(String c_id, HttpSession session);
	public String reportClub(String c_id, ClubVO vo);
}
