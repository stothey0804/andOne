package project.member.p002.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import common.service.CommonService;
import project.member.p002.service.MemberP002_d002Service;
import project.member.p002.vo.MemberP002VO;

/*
 * ADMIN - 문의사항 조회 
 * 작성자 : 김세영
 * */

@Controller
@RequestMapping("/admin")
public class MemberP002_d002ControllerImpl implements MemberP002_d002Controller{

	@Autowired
	MemberP002_d002Service memberP002_d002Service;
	
	@Autowired
	CommonService commonService;
	
	//신규문의
	@Override
	@RequestMapping(value="/searchNewQnA.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView searchNewQnA(@RequestParam Map<String,String> param, @RequestParam(defaultValue="1") int curPage, HttpServletRequest request){
		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		List<HashMap<String, String>> qStateList = commonService.searchCommonCodeList("004");	// 004 - 문의내역_처리상태
		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("p002_d002_search", request));
		mav.addObject("title", "신규문의");
		mav.addObject("qTypeList",qTypeList);
		mav.addObject("qStateList",qStateList);
		List<MemberP002VO> articleList = null;
		
		// 파라미터 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		// 글번호, 작성자 기준값 입력
		if("1".equals(param.get("searchOptionIdOrUser"))) {	//글번호기준
			searchParam.put("q_id",param.get("searchValue"));
		}else {	//작성자 기준
			searchParam.put("m_id",param.get("searchValue"));
		}
		// 유형구분 
		if(!"0".equals(param.get("searchOptionType"))) {
			searchParam.put("q_type", param.get("searchOptionType"));
		}
		
		int listCnt = memberP002_d002Service.selectNewQnAListCnt(searchParam);
		Pagination pagination = new Pagination(listCnt, curPage);
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		
		articleList = memberP002_d002Service.searchNewQnAList(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList", articleList);	// 전체리스트
		return mav;
	}
	
	// 전체문의
	@Override
	@RequestMapping(value="/searchAllQnA.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView searchAllQnA(@RequestParam Map<String,String> param, @RequestParam(defaultValue="1") int curPage, HttpServletRequest request){
		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		List<HashMap<String, String>> qStateList = commonService.searchCommonCodeList("004");	// 004 - 문의내역_처리상태
		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("p002_d002_search", request));
		mav.addObject("title", "전체문의");
		mav.addObject("qTypeList",qTypeList);
		mav.addObject("qStateList",qStateList);
		List<MemberP002VO> articleList = null;
		
		// 파라미터 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		// 글번호, 작성자 기준값 입력
		if("1".equals(param.get("searchOptionIdOrUser"))) {	//글번호기준
			searchParam.put("q_id",param.get("searchValue"));
		}else {	//작성자 기준
			searchParam.put("m_id",param.get("searchValue"));
		}
		// 유형구분 
		if(!"0".equals(param.get("searchOptionType"))) {
			searchParam.put("q_type", param.get("searchOptionType"));
		}
		// 처리상태 구분 
		if(!"0".equals(param.get("searchOptionState"))) {
			searchParam.put("q_state", param.get("searchOptionState"));
		}
		
		int listCnt = memberP002_d002Service.selectAllQnAListCnt(searchParam);
		Pagination pagination = new Pagination(listCnt, curPage);
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		// 총 게시글 수 구하기
		articleList = memberP002_d002Service.searchAllQnAList(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList", articleList);	// 전체리스트
		return mav;
	}
	
	// 팝업
	@Override
	@RequestMapping(value="/popupQnADetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public void popupQnADetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String q_id = request.getParameter("q_id");
		MemberP002VO vo = memberP002_d002Service.searchQnADetail(q_id);
		ObjectMapper mapper = new ObjectMapper();	// vo to json mapper
		String result = mapper.writeValueAsString(vo);	// mapping
		System.out.println("==========> " + result);
		out.print(result);	// vo print
		out.close();
	}
	
	// 상태변경
	@Override
	@RequestMapping(value="/saveQnAState.do", method= {RequestMethod.GET, RequestMethod.POST})
	public void saveQnAState(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String q_id = request.getParameter("q_id");
		String q_state = request.getParameter("q_state");
		Map<String, String> param = new HashMap<String, String>();
		param.put("q_id", q_id);
		param.put("q_state", q_state);
		memberP002_d002Service.saveQnAState(param);	// save state
		return;
	}
	
	// 답변작성 
	@Override
	@RequestMapping(value="/sendReplyQnA.do")
	public void sendReplyQnA(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String q_id = request.getParameter("q_id");
		String q_reply = request.getParameter("q_reply");
		Map<String, String> param = new HashMap<String, String>();
		param.put("q_id", q_id);
		param.put("q_reply", q_reply);
		int result = memberP002_d002Service.saveReplyQnA(param);
		if(result == 1) {
			out.print("작성완료");
		}else {
			out.print("작성실패");
		}
		out.close();
	}
}
