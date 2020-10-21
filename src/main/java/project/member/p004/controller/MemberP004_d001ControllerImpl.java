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
import common.Pagination;
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
	
	// 평가쓰기 수정화면
	@RequestMapping(value = "/editReview.do", method = RequestMethod.GET)
	public ModelAndView memberReviewEdit(@RequestParam String mr_id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		// 리뷰조회해서 넘기기
		mav.setViewName("member/p004_d001_insert_popup");
		MemberP004VO content = memberP004_d001Service.searchReviewContent(mr_id);
		mav.addObject("mr_id", mr_id);
		mav.addObject("mr_target", content.getMr_target());
		mav.addObject("content", content);
		return mav;
	}
	
	// 평가 입력,수정
	@RequestMapping(value="/insertMemberReview.do", method = RequestMethod.POST)
	public String insertMemberReview(@RequestParam Map<String, String> param) throws Exception{
		System.out.println("======================>>>>>  "+param);
		if(memberP004_d001Service.insertMemberReview(param) == 1) {
			memberP004_d001Service.updateMemberScore(param.get("mr_target"));	// 평점업뎃
			return "member/p004_d001_insert_success";	// 결과창
		}else {
			return null;	// 입력실패
		}
	}
	
	// 받은 평가 조회
	@RequestMapping("/receivedReview.do")
	public ModelAndView searchReceivedMemberReview(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(required = false) String target, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("MemberP004_d001_search");
		Map<String, String> searchParam = new HashMap<String, String>();
		String flag = "recieve";	// 플래그 설정
		searchParam.put("flag", flag);
		if(target!=null) {	// 남의 평가 조회시
			mav.setViewName("member/p004_d001_search_popup");
			searchParam.put("m_id", target );
			mav.addObject("target", target);
		}else {		// 내 평가 조회시
			searchParam.put("m_id", (String)request.getSession(false).getAttribute("m_id"));
		}
		int listCnt = memberP004_d001Service.selectMemberReviewCnt(searchParam);	// 카운트 조회
		Pagination pagination = new Pagination(listCnt, curPage);
		searchParam.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		searchParam.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index
		List<MemberP004VO> list = memberP004_d001Service.searchReceivedMemberReview(searchParam);		// 평가 조회
		// 뷰 설정
		mav.addObject("articleList", list);
		mav.addObject("pagination", pagination);
		mav.addObject("flag", flag);
		return mav;
	}
	
	// 내가 남긴 평가
	@RequestMapping("/wroteReview.do")
	public ModelAndView searchWroteMemberReview(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("MemberP004_d001_search");
		String flag = "write";	// 플래그 설정
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("m_id", (String)request.getSession(false).getAttribute("m_id"));
		searchParam.put("flag", flag);
		int listCnt = memberP004_d001Service.selectMemberReviewCnt(searchParam);	// 카운트 조회
		Pagination pagination = new Pagination(listCnt, curPage);
		searchParam.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		searchParam.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index
		List<MemberP004VO> list = memberP004_d001Service.searchWroteMemberReview(searchParam);		// 평가 조회
		// 뷰 설정
		mav.addObject("articleList", list);
		mav.addObject("pagination", pagination);
		mav.addObject("flag", flag);
		return mav;
	}
	
	// 삭제 
	@RequestMapping(value="/deleteReview.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteReview(@RequestParam String mr_id, HttpServletRequest request) throws Exception {
		if(mr_id != null) {
			System.out.println("==========> mr_id : " + mr_id);
			memberP004_d001Service.deleteMemberReview(mr_id);
		}
		// 팝업에서 접근시
		return "redirect:"+ request.getHeader("Referer");	
	}
	
}
