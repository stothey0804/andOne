package project.member.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/member")
public class MemberP001_d001ControllerImpl {
	
	@RequestMapping(value="/login.do")	// 로그인 화면
	public String login(@RequestParam Map<String, String> param, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		String returnView;
		String email = param.get("email");
		String inputPwd = param.get("pwd");
		
		// 세션 멤버정보 존재시 메인으로 보내기
		if(session.getAttribute("member")!=null) {
			// 로그인중이다.
			return "main";
		}
		// 입력값 존재시
		if(email!=null && inputPwd!=null) {
			// user 데이터 조회
			
//			P008_d001VO memberVO = p008_d001Service.selectMemberByEmail(email);
			
			// 관리자경우 관리자페이지로 넘겨주기
			
			// user 정보가 있고 비밀번호가 일치하는 경우
//			if(memberVO!=null && BCrypt.checkpw(inputPwd,memberVO.getM_pwd())) {
//				// 로그인 성공~!
//				session.setAttribute("member", memberVO);
//				session.setAttribute("isLogOn", true);
//				returnView = "main"; // 메인화면으로 이동
//			}else{	// 정보불일치
//				request.setAttribute("warning", "이메일과 비밀번호를 확인해주세요.");
//				returnView = "project/p006_d001/login";
//			}
			
		}else {
			// 입력값 없을시 로그인 화면으로 
			returnView = "member/p001_d002";
		}
		return "member/p001_d002";
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		session.invalidate();
		return "main";
	}
}
