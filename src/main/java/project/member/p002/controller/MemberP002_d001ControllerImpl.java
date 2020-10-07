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
import common.dao.CommonDAO;
import common.service.CommonService;
import project.member.p002.service.MemberP002_d001Service;
import project.member.p002.vo.MemberP002VO;

@Controller
@RequestMapping("/member")
public class MemberP002_d001ControllerImpl implements MemberP002_d001Controller{
	
	@Autowired
	MemberP002_d001Service memberP002_d001Service;
	
	@Autowired
	CommonService commonService;
	
	
	@RequestMapping(value="/qna.do")
	public ModelAndView initMemberQnA(HttpServletRequest request) {
		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("p002_d001_insert", request));
		mav.addObject("qTypeList",qTypeList);
		return mav;
	}
	
	
	@RequestMapping(value="/sendQnA.do", method = RequestMethod.POST)
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
	
	@RequestMapping(value="/searchQnA.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView searchMemberQnA(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("p002_d001_search", request));
		// 세션에서 id 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		List<MemberP002VO> list = memberP002_d001Service.searchQnAListbyMemberID(m_id);
		mav.addObject("articleList",list);
		return mav;
	}

	
	
}
