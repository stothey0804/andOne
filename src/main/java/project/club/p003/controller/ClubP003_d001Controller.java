package project.club.p003.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubArticleVO;

public interface ClubP003_d001Controller {
	public ModelAndView writeArticleForm(String c_id) throws Exception;
	public String writeArticle(ClubArticleVO vo, HttpServletRequest request) throws Exception;
	public ModelAndView editArticle(String ca_id) throws Exception;
	public String deleteClubArticle(String ca_id, String c_id) throws Exception;
}
