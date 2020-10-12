package project.member.p002.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import common.Common;
import common.Pagination;
import common.dao.CommonDAO;
import common.service.CommonService;
import project.member.p002.service.MemberP002_d001Service;
import project.member.p002.service.MemberP002_d002Service;
import project.member.p002.vo.MemberP002VO;

@Controller
@RequestMapping("/member")
public class MemberP002_d001ControllerImpl implements MemberP002_d001Controller{
	
	@Autowired
	MemberP002_d001Service memberP002_d001Service;
	
	@Autowired
	MemberP002_d002Service memberP002_d002Service; 	// detail 조회용
	
	@Autowired
	CommonService commonService;
	
	
	@Override
	@RequestMapping(value="/qna.do")
	public ModelAndView initMemberQnA(HttpServletRequest request) {
		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("p002_d001_insert", request));
		String q_id = request.getParameter("q_id");
		if(q_id!=null && !"".equals(q_id)) {
			// 내용 전달
			MemberP002VO vo = memberP002_d002Service.searchQnADetail(q_id);
			System.out.println("==============> "+vo.getQ_type_id());
//			vo.setQ_content(vo.getQ_content());
			mav.addObject("article", vo);
			mav.addObject("flag",1);	// 수정
		}else {
			mav.addObject("flag",0);	// 신규작성
		}
		mav.addObject("qTypeList",qTypeList);
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/insertQnA.do", method = RequestMethod.POST)
	public String insertMemberQnA(@RequestParam Map<String, String> param, HttpServletRequest request) {
		MemberP002VO vo = new MemberP002VO(param.get("q_type"), param.get("m_id"), param.get("q_subject"), param.get("q_content"));
		int result = memberP002_d001Service.insertQnA(vo);
		if(result==1) {	// 성공
			return "redirect:/member/searchQnA.do";
		}else {
			// 오류 처리
			return null;
		}
	}
	
	@RequestMapping(value="/updateQnA.do", method = RequestMethod.POST)	// 수정
	public String updateMemberQnA(@RequestParam Map<String, String> param, HttpServletRequest request) {
		MemberP002VO vo = new MemberP002VO(param.get("q_type"), param.get("m_id"), param.get("q_subject"), param.get("q_content"));
		vo.setQ_id(param.get("q_id"));	// q_id set
		int result = memberP002_d001Service.saveQnA(vo);
		if(result==1) {	// 성공
			return "redirect:/member/searchQnA.do";
		}else {
			// 오류 처리
			return null;
		}
	}
	
	@Override
	@RequestMapping(value="/deleteMemberQnA.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteMemberQnA(HttpServletRequest request) {
		String q_id = request.getParameter("q_id");
		if(q_id != null) {
			memberP002_d001Service.deleteQnA(q_id);	// 삭제 쿼리 실행
		}
		return "redirect:/member/searchQnA.do";
	}
	
//	@RequestMapping(value="/updateQnAContent.do")
//	public ModelAndView updateQnAContent(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("", request));
//		String q_id = request.getParameter("q_id");
//		
//		
//	}
	
	@Override
	@RequestMapping(value="/searchQnA.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView searchMemberQnA(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("p002_d001_search", request));
		// 세션에서 id 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		int listCnt = memberP002_d001Service.selectQnAListCnt(m_id);
		Pagination pagination = new Pagination(listCnt, curPage);
		
		// 파라미터 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		searchParam.put("m_id", m_id);
		
		List<MemberP002VO> list = memberP002_d001Service.searchQnAListbyMemberID(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList",list);
		return mav;
	}



	
	
}
