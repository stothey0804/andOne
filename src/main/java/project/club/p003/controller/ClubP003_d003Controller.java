package project.club.p003.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface ClubP003_d003Controller {
//	public void insertReply(String ca_id, String car_content, HttpSession session);
	public void deleteReply(String car_id);
//	public void insertReply(String ca_id, String car_content, String p_car_id, HttpSession session);
	public void editReply(String car_id, String car_content);
	public void insertReply(String ca_id, String car_content, String p_car_id, HttpSession session,
			HttpServletResponse response) throws IOException;
}
