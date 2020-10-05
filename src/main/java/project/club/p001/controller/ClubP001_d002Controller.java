package project.club.p001.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubP001_d001articleVO;

public interface ClubP001_d002Controller {
	public void deleteClubArticle(String ca_id) throws Exception;
	public ModelAndView writeArticleForm(String c_id) throws Exception;
	public void writeArticle(ClubP001_d001articleVO vo, HttpServletRequest request) throws Exception;
	public ModelAndView editArticle(String ca_id) throws Exception;
}
