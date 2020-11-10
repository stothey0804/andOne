package project.member.p001.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import project.member.p001.service.MemberP001_d003Service;

@Controller
@RequestMapping("/member")
public class MemberP001_d003ControllerImpl implements MemberP001_d003Controller{
	
	@Autowired
	private MemberP001_d003Service memberP001_d003Service;
	
	@Override
	@RequestMapping(value="/searchMemberPwd.do")
	public String searchMemberPwd() {
		return "p001_d003_init";
	}
	
	// ajax 이메일 체크 -> p001 searchOverlapEmail 이용
	
	@Override
	@RequestMapping(value="/searchMemberPwdComplete.do", method=RequestMethod.POST)
	public String searchMemberPwdComplete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String to = request.getParameter("m_email");
		String subject = "[&분의일]비밀번호 변경 이메일입니다.";
		// 변경 url 생성
		String url = "/andOne/member/emailCheck.do";
		Map<String, String> member = memberP001_d003Service.searchIdPwdByEmail(to);
		System.out.println(member.toString());
		url += "?id="	+ member.get("M_ID")
				+ "&key="	+ member.get("M_PWD");
		// 변경 메일 양식
		String body = "<div style=\"width:600px;padding: 10px 20px;border:1px solid gray;background:white\">\r\n" + 
				"<h3>비밀번호 변경 안내</h3>\r\n" + 
				"<hr>\r\n" + 
				"<p>안녕하세요, &분의일 입니다.</p>\r\n" + 
				"<p>비밀번호를 변경하시려면 아래 링크를 클릭해주세요.</p>\r\n" + 
				"<a href='" + url +"'>비밀번호 변경하기</a>\r\n" + 
				"<br><br>\r\n" + 
				"<h2 align=\"right\">&분의일</h2>\r\n" + 
				"</div>";
		memberP001_d003Service.sendMail(to, subject, body);
		return "p001_d003_search";
	}
	
	//비밀번호 체크
	@Override
	@RequestMapping(value="/emailCheck.do", method=RequestMethod.GET)
	public ModelAndView emailCheck(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("");
		String paramId = request.getParameter("id");
		String paramPwd = request.getParameter("key");
		String oriPwd = memberP001_d003Service.selectPwdById(paramId);
		if(paramPwd.equals(oriPwd)) {
			mav.setViewName("member/p001_d003_update");
			mav.addObject("m_id", paramId);
		}
		return mav;
	}
	//비밀번호 변경
	@Override
	@RequestMapping(value="/updatePwd.do", method=RequestMethod.POST)
	public String updatePwd(HttpServletRequest request) {
		String returnView = "";
		Map<String, String> member = new HashMap<String, String>();
		member.put("m_id",request.getParameter("m_id"));
		String encodedPwd = BCrypt.hashpw(request.getParameter("m_pwd"), BCrypt.gensalt());	// 패스워드 암호화
		member.put("m_pwd",encodedPwd);
		int result = memberP001_d003Service.updateMemberPwd(member);
		if(result==1) {
			returnView = "member/p001_d003_update_sub01";
		}
		return returnView;
	}

}
