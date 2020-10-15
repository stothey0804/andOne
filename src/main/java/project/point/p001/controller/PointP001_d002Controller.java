package project.point.p001.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface PointP001_d002Controller{
	public String chargeInit(HttpServletRequest request);	// 충전 초기화면
	public void setChargePoint(); // 포인트 값 전달
	public String kakaoPay(String amount); // 결제창 연결
	public ModelAndView kakaoPaySuccess(String pg_token, HttpServletRequest request);// 성공페이지 연결
}
