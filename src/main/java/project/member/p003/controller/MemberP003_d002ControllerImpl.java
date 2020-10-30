package project.member.p003.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import common.service.CommonService;
import project.member.p002.vo.MemberP002VO;
import project.member.p003.service.MemberP003_d002Service;
import project.member.p003.vo.MemberP003VO;

/*
 * @Title	신고하기 - 어드민
 * @Author	김세영
 * @Date 	2020.10.30.
 * 
 * */

@Controller
@RequestMapping("/admin")
public class MemberP003_d002ControllerImpl implements MemberP003_d002Controller{

	@Autowired
	MemberP003_d002Service memberP003_d002Service;
	
	@Autowired
	CommonService commonService;
	
	//신규문의
	@RequestMapping(value="/searchAllReport.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView esearchNewReport(@RequestParam Map<String,String> param, @RequestParam(defaultValue="1") int curPage, HttpServletRequest request){
		
//		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		List<HashMap<String, String>> rStateList = commonService.searchCommonCodeList("003");	// 003 - 신고내역_처리상태
		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("AdminP003_d002_search", request));
//		mav.addObject("title", "신규신고");
//		mav.addObject("qTypeList",qTypeList);
		mav.addObject("rStateList",rStateList);
		List<MemberP003VO> articleList = null;
		
		// 파라미터 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		// 글번호, 작성자 기준값 입력
		if("1".equals(param.get("searchOptionIdOrUser"))) {	//글번호기준
			searchParam.put("r_id",param.get("searchValue"));
		}else {	//작성자 기준
			searchParam.put("m_id",param.get("searchValue"));
		}
		// 카테고리, 유형, 상태구분 
		if(!"0".equals(param.get("searchOptionType"))) {
			searchParam.put("r_type", param.get("searchOptionType"));
		}
		if(!"0".equals(param.get("searchCategoryType"))) {
			searchParam.put("r_category", param.get("searchCategoryType"));
		}
		if(!"0".equals(param.get("searchOptionState"))) {
			searchParam.put("r_state", param.get("searchOptionState"));
		}
		// 전체 / 신규 구분
		if(param.get("newList")!=null) {
			searchParam.put("newList", param.get("newList"));
			mav.addObject("newList", param.get("newList"));
		}
		int listCnt = memberP003_d002Service.selectAllReportListCnt(searchParam);
		Pagination pagination = new Pagination(listCnt, curPage);
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		
		articleList = memberP003_d002Service.selectAllReportList(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList", articleList);	// 전체리스트
		return mav;
	}
	
	// 카테고리 조회시 ajax
	@RequestMapping(value="/searchFormCategorySelected.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String searchFormCategorySelected(@RequestParam String g_id) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		List<HashMap<String, String>> rTypeList = commonService.searchCommonCodeList(g_id);
		String result = mapper.writeValueAsString(rTypeList);
		System.out.println("==========" + result);
		return result;
	}
	
	// 전체문의
//	@RequestMapping(value="/searchAllReport.do", method= {RequestMethod.GET, RequestMethod.POST})
//	public ModelAndView searchAllQnA(@RequestParam Map<String,String> param, @RequestParam(defaultValue="1") int curPage, HttpServletRequest request){
//		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("AdminP003_d002_search", request));
//		List<HashMap<String, String>> rStateList = commonService.searchCommonCodeList("003");	// 003 - 신고내역_처리상태
//		mav.addObject("title", "전체신고");
////		mav.addObject("qTypeList",qTypeList);
//		mav.addObject("rStateList",rStateList);
//		List<MemberP003VO> articleList = null;
//		
//		// 파라미터 생성
//		Map<String, String> searchParam = new HashMap<String, String>();
//		int listCnt = memberP003_d002Service.selectAllReportListCnt(searchParam);
//		Pagination pagination = new Pagination(listCnt, curPage);
//		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
//		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
//		
//		articleList = memberP003_d002Service.selectAllReportList(searchParam);
//		mav.addObject("pagination", pagination);	//페이지네이션
//		mav.addObject("articleList", articleList);	// 전체리스트
//		return mav;
//	}
	
	// 팝업
	@RequestMapping(value="/popupReportDetail.do", method= {RequestMethod.GET, RequestMethod.POST}, produces = "application/text;charset=UTF-8" )
	@ResponseBody
	public String popupQnADetail(@RequestParam String r_id) throws Exception {
		MemberP003VO vo = memberP003_d002Service.selectReportDetailByRID(r_id);
		ObjectMapper mapper = new ObjectMapper();	// vo to json mapper
		String result = mapper.writeValueAsString(vo);	// mapping
		System.out.println("==========> " + result);
		return result;
	}
	
	
	// 상태변경
	@RequestMapping(value="/saveReportState.do")
	@ResponseBody
	public void sendReplyQnA(@RequestParam Map<String,String> param) throws Exception {
//		Map<String, String> searchParam = new HashMap<String, String>();
//		searchParam.put("r_id", param.get("r_id"));
//		searchParam.put("r_reply", param.get("r_reply"));
//		searchParam.put("r_state", param.get("r_state"));
		memberP003_d002Service.saveReportState(param);
	}
}
