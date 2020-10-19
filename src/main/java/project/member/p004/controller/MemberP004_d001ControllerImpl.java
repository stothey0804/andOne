package project.member.p004.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.member.p001.service.MemberP001_d005Service;
import project.member.p004.service.MemberP004_d001Service;
import project.member.p004.vo.MemberP004VO;

/*
 * 회원 평가
 * 작성자 : 김세영
 * */


@Controller
@RequestMapping("/member")
public class MemberP004_d001ControllerImpl implements MemberP004_d001Controller{

	@Autowired
	MemberP004_d001Service memberP004_d001Service;
	
	@Autowired
	MemberP001_d005Service memberP001_d005Service;	// 프로필 조회용
	
	@Override
	@RequestMapping("/searchMemberInfoPopup.do")	// 팝업 연결
	public ModelAndView searchMemberInfoPopup(HttpServletRequest request, @RequestParam String m_id) {
		ModelAndView mav = new ModelAndView("member/member_popup");
		Map<String, String> result = memberP004_d001Service.searchMemberInfo(m_id);	// 조회
		String encodedProfileImg = Common.encodeBlobImage(m_id, memberP001_d005Service);
		result.put("m_img", encodedProfileImg);	// 프로필 이미지
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex", "1");	searchParam.put("endIndex", "5"); searchParam.put("m_id", m_id);
		List<MemberP004VO> receivedList = memberP004_d001Service.searchReceivedMemberReview(searchParam);	// 최근 받은 평가
		// 전달 값
		mav.addObject("info", result);
		mav.addObject("receivedList", receivedList);
		System.out.println("============>info " + result);
		// 평가조회도 넘겨야함.
		return mav;
	}
	
	// 회원등급 메인
	@RequestMapping("/score.do")
	public ModelAndView searchMemberScore(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("MemberP004_d001_init", request));
		HttpSession session = request.getSession(false);
		String m_id = (String)session.getAttribute("m_id");
		// 평점 set
		mav.addObject("m_score", 
						memberP004_d001Service.selectMemberScore(m_id));
		// 최근 평가 조회 - 5건
		// 검색조건 set
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex", "1");
		searchParam.put("endIndex", "3");
		searchParam.put("m_id", m_id);
		List<MemberP004VO> wroteList = memberP004_d001Service.searchWroteMemberReview(searchParam); 		// 최근 쓴 평가
		List<MemberP004VO> receivedList = memberP004_d001Service.searchReceivedMemberReview(searchParam);	// 최근 받은 평가
		// 목록 set
		mav.addObject("wroteList", wroteList);
		mav.addObject("receivedList", receivedList);
		return mav;
	}
	
	// 평가쓰기 화면
	@RequestMapping(value = "/writeReview.do", method = RequestMethod.GET)
	public ModelAndView memberReviewInit(@RequestParam String target, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		if(target.equals((String)request.getSession(false).getAttribute("m_id"))) {
			// 자기자신 평가 금지
			request.setAttribute("warning", "자기자신은 평가할 수 없습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("/member/searchMemberInfoPopup.do?m_id="+target);
			dis.forward(request, response);
			return null;
		}else {
			mav.setViewName("member/p004_d001_insert_popup");
			mav.addObject("mr_target", target);
		}
		return mav;
	}
	
	// 평가 입력
	@RequestMapping(value="/insertMemberReview.do", method = RequestMethod.POST)
	public String insertMemberReview(@RequestParam Map<String, String> param) throws Exception{
		if(memberP004_d001Service.insertMemberReview(param) == 1) {
			memberP004_d001Service.updateMemberScore(param.get("m_id"));	// 평점업뎃
			return "member/p004_d001_insert_success";	// 결과창
		}else {
			return null;	// 입력실패
		}
	}
	
	// 내가 받은 평가
		
	
	// 내가 남긴 평가
	
	
}
