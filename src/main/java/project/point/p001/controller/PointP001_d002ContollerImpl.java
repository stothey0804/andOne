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
import org.springframework.web.bind.annotation.ResponseBody;
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
		ModelAndView mav = new ModelAndView("point/p001_success");
		KakaoPayApprovalVO info = pointP001_d002Service.kakaoPayInfo(pg_token);
		try {
			// 충전포인트 값
			String chargeAmount = (info.getAmount().getTotal()).toString();
			// Session 얻기
			HttpSession session = request.getSession(false);
			String m_id = (String) session.getAttribute("m_id");
			
			// Point VO 값 set
			PointP001VO pointVO = new PointP001VO();
			pointVO.setM_id(m_id);
			pointVO.setP_changepoint(chargeAmount);
			pointVO.setP_detail("포인트 충전");
			String nowPoint = pointP001_d001Service.selectNowPointById(m_id);	// 현재 포인트 조회
			pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint);	// 적용		
			// 포인트 입력
			pointP001_d002Service.insertPoint(pointVO);	
			// 충전 결과 view에 전달할 정보
			mav.addObject("chargeAmount", chargeAmount);
			mav.addObject("nowPoint", pointP001_d001Service.selectNowPointById(m_id));
			
		} catch (NullPointerException e) {
			e.printStackTrace();
		}	
		return mav;
		
	}

	@Override
	@RequestMapping("/charge.do")
	public String chargeInit(HttpServletRequest request) {
		return Common.checkLoginDestinationView("PointP001_d001_init", request);
	}
	
	@RequestMapping("/exchange.do")
	public String exchangeInit(HttpServletRequest request) {
		return Common.checkLoginDestinationView("PointP001_d002_exhange", request);
	}

	@Override
	public void setChargePoint() {
		// TODO Auto-generated method stub
		// Point VO 값 set
					
	}
	
	@RequestMapping("/insertPointFromAdmin.do")
	@ResponseBody
	public void insertPointFromAdmin(@RequestParam Map<String,String> param) {
		PointP001VO pointVO = new PointP001VO();
		pointVO.setM_id(param.get("target"));
		pointVO.setP_changepoint(param.get("amount"));
		pointVO.setP_detail("관리자 지급");
		String nowPoint = pointP001_d001Service.selectNowPointById(param.get("target"));	// 현재 포인트 조회
		pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint);	// 적용		
		// 포인트 입력
		pointP001_d002Service.insertPoint(pointVO);	
	}
	
	@RequestMapping("/exchangeSend.do")
	public String sendExchageAmount(@RequestParam Map<String,String> param) {
		PointP001VO pointVO = new PointP001VO();
		pointVO.setM_id(param.get("target"));
		int exchangePoint = Integer.parseInt(param.get("amount")) * -1;	// 차감변경
		pointVO.setP_changepoint(String.valueOf(exchangePoint));
		pointVO.setP_detail("환전 신청");
		String nowPoint = pointP001_d001Service.selectNowPointById(param.get("target"));	// 현재 포인트 조회
		pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint);	// 적용		
		// 포인트 입력
		pointP001_d002Service.insertPoint(pointVO);	
		return "redirect:/point/pointDetail.do";
	}

}
