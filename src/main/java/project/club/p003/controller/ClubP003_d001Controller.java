package project.club.p003.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import project.club.vo.ClubArticleImgVO;
import project.club.vo.ClubArticleVO;

public interface ClubP003_d001Controller {
	public ModelAndView writeArticleForm(String c_id) throws Exception;
	public void deleteClubArticle(String ca_id, String c_id) throws Exception;
	public String writeArticle(ClubArticleVO vo, HttpServletRequest request, HttpSession session,
			MultipartHttpServletRequest mtfRequest) throws Exception;
	public ModelAndView editArticle(String ca_id, String c_id) throws Exception;
	public void deleteClubArticleImg(ClubArticleImgVO vo) throws Exception;
	public String editArticle(ClubArticleVO vo, HttpServletRequest request, HttpSession session,
			MultipartHttpServletRequest mtfRequest) throws Exception;
}
