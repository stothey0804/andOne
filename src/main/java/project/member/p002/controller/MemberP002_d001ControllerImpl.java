package project.member.p002.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import common.Common;
import common.dao.CommonDAO;
import common.service.CommonService;
import project.member.p002.service.MemberP002_d001Service;

@Controller
@RequestMapping("/member")
public class MemberP002_d001ControllerImpl implements MemberP002_d001Controller{
	
//	@Autowired
//	MemberP002_d001Service memberP002_d001Service;
	
	@Autowired
	CommonService commonService;
	
	@RequestMapping(value="/qna.do")
	public ModelAndView insertMemberQnA(HttpServletRequest request) {
		List<HashMap<String, String>> qTypeList = commonService.searchCommonCodeList("016");	// 016 - 문의유형
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("p002_d001_insert", request));
		mav.addObject("qTypeList",qTypeList);
		return mav;
	}
	

	
	
}
