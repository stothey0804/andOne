package project.member.p005.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface MemberP005_d001Controller {
	// 알림조회 (전체)
	ModelAndView notifyInit(int curPage, HttpServletRequest request) throws Exception;
	// 더보기 요청 (ajax)
	String searchMoreNotify(Map<String, String> param) throws Exception;
	// 읽음상태 변경 
	void readNotify(String n_id, HttpServletRequest request);
	// 새 알림 cnt 조회
	String selectNewNoticeCnt(String m_id);
	// notify DB저장
	void saveNotify(Map<String, String> param) throws Exception;

}
