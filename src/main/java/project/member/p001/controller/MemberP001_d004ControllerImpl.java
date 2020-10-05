package project.member.p001.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import common.Common;
import project.member.p001.service.MemberP001_d004Service;

@Controller
@RequestMapping("/member")
public class MemberP001_d004ControllerImpl implements MemberP001_d004Controller{

	@Autowired
	MemberP001_d004Service memberP001_d004Service;
	
	@Override
	@RequestMapping(value="/deleteMember.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteMember(HttpServletRequest request) {
		return Common.checkLoginDestinationView("p001_d004_init", request);	// 로그인상태 체크
	}

	@Override
	@RequestMapping(value="/deleteMemberComplete.do", method = RequestMethod.POST)
	public String deleteMemberComplete(HttpServletRequest request) throws Exception{
		String resultView = "";
		// 삭제 처리
		String m_id = request.getParameter("m_id");	// ID get
		int result = memberP001_d004Service.deleteMember(m_id);	//삭제 수행
		if(result==1) {	// 성공일경우
			// 세션삭제
			HttpSession session = request.getSession(false);
			session.invalidate();
			// 뷰 설정
			resultView = "member/p001_d004_delete";
		}else {
			// 오류페이지 설정
			resultView = "";
		}
		return resultView;
	}
	
	

}
