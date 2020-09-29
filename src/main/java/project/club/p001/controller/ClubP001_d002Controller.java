package project.club.p001.controller;

import java.util.HashMap;

import org.springframework.web.servlet.ModelAndView;

public interface ClubP001_d002Controller {
	public ModelAndView createClub() throws Exception;
	public void deleteClubArticle(String ca_id) throws Exception;
	public ModelAndView writeArticleForm(String c_id) throws Exception;
	public ModelAndView writeArticle(HashMap<String, Object> paramMap) throws Exception;
}
