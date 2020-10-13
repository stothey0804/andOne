package project.point.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.point.p001.service.PointP001_d001Service;
import project.point.p001.service.PointP001_d002Service;
import project.point.p001.vo.KakaoPayApprovalVO;
import project.point.p001.vo.PointP001VO;

@Controller
@RequestMapping("/point")
public class PointP001_d002ContollerImpl implements PointP001_d002Controller{

	@Autowired
	PointP001_d002Service pointP001_d002Service;
	
	@Autowired
	PointP001_d001Service pointP001_d001Service;	// 포인트조회용
	
	@Override
	@RequestMapping(value="/kakaoPay.do", method = RequestMethod.POST)
	public String kakaoPay(@RequestParam String amount) {
		return "redirect:" + pointP001_d002Service.kakaoPayReady(amount);
	}

	@Override
	@RequestMapping("/kakaoPaySuccess.do")	// 결제성공 연결
	public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, HttpServletRequest request) {
//		System.out.println("======pg_token : "+pg_token);
		KakaoPayApprovalVO info = pointP001_d002Service.kakaoPayInfo(pg_token);
		// 충전포인트 값
		String chargeAmount = (info.getAmount().getTotal()).toString();
		
		// db에 포인트 입력
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		PointP001VO pointVO = new PointP001VO();
		pointVO.setM_id(m_id);
		pointVO.setP_changepoint(chargeAmount);
		pointVO.setP_detail("포인트 충전");
		
		pointP001_d002Service.insertPoint(pointVO);
		
		try {
			
		} catch (NullPointerException e) {
			e.printStackTrace();
		}	
		
		// 현재 포인트 조회
		String nowPoint = pointP001_d001Service.selectNowPointById(m_id);
		
		ModelAndView mav = new ModelAndView("point/p001_success");
		mav.addObject("chargeAmount", chargeAmount);
		mav.addObject("nowPoint", nowPoint);
		
//		mav.addObject("info", kakaoPayAprrovalVO);
		return mav;
		
	}

	@Override
	@RequestMapping("/charge.do")
	public String chargeInit(HttpServletRequest request) {
		return Common.checkLoginDestinationView("PointP001_d001_init", request);
	}

	@Override
	public void setChargePoint() {
		// TODO Auto-generated method stub
		
	}

}
