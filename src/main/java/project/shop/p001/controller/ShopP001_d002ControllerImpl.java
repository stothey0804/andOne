package project.shop.p001.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p001.service.ShopP001_d002Service;
import project.shop.p001.vo.ShopP001BmemberVO;

@Controller
@RequestMapping("/biz/*")
public class ShopP001_d002ControllerImpl implements ShopP001_d002Controller {
	@Autowired
	private ShopP001_d002Service shopP001_d002Service;
	
	//로그인페이지 이동
	@Override
	@RequestMapping(value="loginPage.do")
	public String loginPage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		//중복 로그인 체크
		if(session != null && session.getAttribute("bMember") != null) {
			return "shop/p001_d004_shopAdminMain"; //업체 메인페이지로 이동
			}
		return "shop/p001_d002_login";
		}
	
	//로그인
	@Override
	@RequestMapping(value="login.do")
	@ResponseBody
	public int login(@ModelAttribute ShopP001BmemberVO vo, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		String id = vo.getBm_id();
		String pwd = vo.getBm_pwd();
		String id_check = request.getParameter("saveId");
		System.out.println(id_check);
		
		//로그인 체크
		ShopP001BmemberVO bmemberVO = shopP001_d002Service.loginCheck(id);
		//로그인성공ㅣ
		if(bmemberVO == null) {
			//로그인 실패, 아이디 틀림
			System.out.println(">>>>>>>>로그인실패");
			result = 0;
		}else if(!BCrypt.checkpw(pwd, bmemberVO.getBm_pwd())) {
			//로그인 실패, 비밀번호 틀림
			System.out.println(">>>>>>>>로그인실패");
			result = 0;
		}else{
			System.out.println(">>>>>>>>로그인성공");
			//아이디 기억 위한 쿠키생성 및 설정
			Cookie cookie = new Cookie("id_check", id); //jsp에서 id_check로 쿠키 사용가능
			if(id_check.equals("true")) {
				response.addCookie(cookie);
				cookie.setMaxAge(60*60*24*7);//일주일간 쿠키저장
				System.out.println(">>>>>>>>쿠키저장");
			}else {
				System.out.println(">>>>>>>>쿠키 저장안함");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			//세션에 vo객체 저장
			session.setAttribute("bMember", bmemberVO);
			session.setAttribute("isLogOn", true);
			result = 1; 
		}
		return result;
	}
	
	//로그인성공
	@Override
	@RequestMapping(value="loginOk.do")
	public String loginOk() {
		return "shopAdminMain"; //업체 관리자 페이지이동
	}
	
	//로그아웃
	@Override
	@RequestMapping(value="logout.do")
	public String logout(HttpSession session) {
		System.out.println(">>>>>>>>logout!!!!!!!!!");
		session.removeAttribute("bMember");
		session.removeAttribute("isLogOn");
		session.invalidate();
		return "main"; //로그아웃후 메인으로 이동
	}
	
}
