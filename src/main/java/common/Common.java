package common;

import java.util.Base64;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.member.p001.vo.MemberP001_MemberVO;

public class Common {
	
	// 로그인 체크 메서드, dest = 목적지 view
	public static String checkLoginDestinationView(String dest, HttpServletRequest request) {
		// 세션체크
		String returnView = "member/p001_d002";	// 로그인 페이지
		HttpSession session = request.getSession(false);
		// 세션 멤버정보, 로그인상태 체크
		if(session!=null) {
			if(session.getAttribute("member")!=null && session.getAttribute("isLogOn")!=null)
			{
				returnView = dest;				// 목적지 view로
			}
		}
		return returnView;
	}
	
}
