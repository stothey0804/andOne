package project.point.p001.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface PointP001_d001Controller {
	// 마이페이지 - 포인트내역 조회
	public ModelAndView pointDetailSearch(int curPage, HttpServletRequest request) throws Exception;
	// 현재포인트 조회 (ajax)
	public String selectNowPoint(String m_id);

		
}
