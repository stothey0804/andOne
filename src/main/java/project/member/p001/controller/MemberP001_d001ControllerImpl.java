package project.member.p001.controller;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.SendSMSTwilio;
import project.member.p001.service.MemberP001_d001Service;
import project.member.p001.vo.MemberP001_MemberVO;

@Controller
@RequestMapping("/member")
public class MemberP001_d001ControllerImpl implements MemberP001_d001Controller{
	
	@Autowired
	MemberP001_d001Service memberP001_d001Service;

	@Override
	@RequestMapping(value="/join.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinMember(HttpServletRequest request) throws Exception {
		String agree = request.getParameter("agree")!=null? request.getParameter("agree"): "";
		if(agree.equals("true")) {
			return "p001_d001_insert";
		}else {
			return "p001_d001_init";
		}
	}

	//SMS발송
	@Override
	@RequestMapping(value="/confirmSMSCode.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void confirmSMSCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String targetPhoneNum = request.getParameter("phone");
		String twilioPhoneNum = targetPhoneNum.replaceAll("-", "");
		SendSMSTwilio twilio = new SendSMSTwilio();		// 문자 인증
//		int authNum = twilio.sendSMS(twilioPhoneNum);
		int authNum = 999999;	// 인증번호 임시
		out.print(""+authNum);
		out.close();
	}
	// 이메일체크
	@Override
	@RequestMapping(value="/searchOverlapEmail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapEmail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		// 이메일 중복 체크 조회 쿼리
		String result = memberP001_d001Service.searchOverlapEmail(email);
		if(result!=null) {
			out.print("true"); 	// 중복
		}else {
			out.print("false");
		}
		out.close();
	}

	@Override
	@RequestMapping(value="/searchOverlapPhone.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapPhone(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String phone = request.getParameter("phone");
		// 이메일 중복 체크 조회 쿼리
		String result = memberP001_d001Service.searchOverlapPhone(phone);
		if(result!=null) {
			out.print("true"); 	// 중복
		}else {
			out.print("false");
		}
		out.close();
	}

	@Override
	@RequestMapping(value="/addMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String addMember(@RequestParam Map<String, String> param) throws Exception {
		String resultView="";
		// 폼에서 값 얻어오기
		String email = param.get("email"); 
		String phoneNum = param.get("phonenumber");
		String pwd = BCrypt.hashpw(param.get("pwd"), BCrypt.gensalt());	// 패스워드 암호화
		// 선택정보
		String gender = param.get("gender")==null? "": param.get("gender");
		String age = param.get("age");
		String nickName = "익명#"+ (int)(Math.random()* 900000 + 100000);
		// 멤버추가
		MemberP001_MemberVO memberVO = new MemberP001_MemberVO(email, pwd, phoneNum, nickName, gender, age);
		int result = memberP001_d001Service.addMember(memberVO);
		if(result==1) {	// 추가 성공시
			resultView = "p001_d001_insert_sub01";	// 완료화면
		}
		return resultView;
	}
}
