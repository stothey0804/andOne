package project.root.p003.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface RootP003_d001Controller {
	// 작성,수정 초기화면
	public ModelAndView initNoticeForm(HttpServletRequest request) throws Exception;
	// 작성 수행
	public String insertNotice(Map<String, String> param, HttpServletRequest request) throws Exception;
	// 수정 수행
	public String updateNotice(Map<String, String> param, HttpServletRequest request) throws Exception;
	// 삭제 수행
	public String deleteNotice(HttpServletRequest request) throws Exception;
	// 조회 연결
	public ModelAndView searchNotice(int curPage, HttpServletRequest request) throws Exception;
	
}
