package project.shop.p001.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p001.service.ShopP001_d002Service;
import project.shop.p001.service.ShopP001_d005Service;
import project.shop.p001.vo.ShopP001BmemberVO;

@Controller
public class ShopP001_d005ControllerImpl implements ShopP001_d005Controller{

	@Autowired
	ShopP001_d005Service shopP001_d005Service;
	@Autowired
	ShopP001_d002Service shopP001_d002Service;
	
	
	@RequestMapping("biz/updateForm.do")
	public String updateForm(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		String bm_id = (String)session.getAttribute("bm_id");
		ShopP001BmemberVO vo = shopP001_d002Service.loginCheck(bm_id);
		model.addAttribute("bMember",vo);
		return "modifyBmember";
	}
	
	// 이메일체크
	@RequestMapping(value="biz/searchOverlapEmail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapEmail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		// 이메일 중복 체크 조회 쿼리
		String result = shopP001_d005Service.searchOverlapEmail(email);
		if(result!=null) {
			out.print("true"); 	// 중복
		}else {
			out.print("false");
		}
		out.close();
	}

	@RequestMapping(value="biz/searchOverlapPhone.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void searchOverlapPhone(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String phone = request.getParameter("phone");
		// 이메일 중복 체크 조회 쿼리
		String result = shopP001_d005Service.searchOverlapPhone(phone);
		if(result!=null) {
			out.print("true"); 	// 중복
		}else {
			out.print("false");
		}
		out.close();
	}
	
	@RequestMapping(value="biz/saveMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveMemberInfo(ShopP001BmemberVO bMember, HttpServletRequest request) {
		System.out.println("==========>"+bMember.toString());
		// 패스워드 암호화 세팅
		if(!"".equals(bMember.getBm_pwd())) {
			String parsePwd = BCrypt.hashpw(bMember.getBm_pwd(), BCrypt.gensalt());
			bMember.setBm_pwd(parsePwd);
		}else {
			String oriPwd = shopP001_d005Service.selectPwdById(bMember.getBm_id());
			bMember.setBm_pwd(oriPwd);
		}
		
		
		// 멤버추가
		shopP001_d005Service.updateBmember(bMember);
		return "redirect:loginOk.do";
	}
	
	@RequestMapping("biz/deleteMember.do")
	public String deleteMember(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		String bm_id = (String)session.getAttribute("bm_id");
		model.addAttribute("bm_id",bm_id);
		return "bMemberDelete";
	}
	
	@RequestMapping("biz/deleteMemberComplete.do")
	public String deleteMemberComplete(@RequestParam String bm_id,HttpServletRequest request) {
		String s_id = shopP001_d005Service.getShopIdByBmemberId(bm_id);
		if(s_id!=null&&!s_id.equals("")) {
			shopP001_d005Service.deleteShop(s_id);
		}
		shopP001_d005Service.deleteBmember(bm_id);
		HttpSession session = request.getSession(false);
		session.invalidate();
		return "shop/p001_d005_deleteComplete";
	}
	
	@ResponseBody
	@RequestMapping("biz/pwdCheck.do")
	public String pwdCheck(@RequestParam String bm_id,@RequestParam String bm_pwd) {
		String result = "";
		String oriPwd = shopP001_d005Service.selectPwdById(bm_id);
		if(BCrypt.checkpw(bm_pwd, oriPwd)) {
			result = "true";
		}else {
			result = "false";
		}
		return result;
	}
}
