package project.member.p002.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MemberP002_d002Controller {
	//신규문의
	public ModelAndView searchNewQnA(@RequestParam Map<String,String> param, HttpServletRequest request);
	//전체문의
	public ModelAndView searchAllQnA(@RequestParam Map<String,String> param, HttpServletRequest request);
	//디테일 조회
	public void popupQnADetail(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//상태변경
	public void saveQnAState(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//답변작성
	public void sendReplyQnA(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
