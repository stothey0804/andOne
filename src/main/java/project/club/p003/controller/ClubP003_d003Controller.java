package project.club.p003.controller;

import javax.servlet.http.HttpSession;

public interface ClubP003_d003Controller {
	public void insertReply(String ca_id, String car_content, HttpSession session);
	public void deleteReply(String car_id);
}
