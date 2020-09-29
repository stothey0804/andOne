package project.member.p001.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.member.p001.service.MemberP001_d005Service;
import project.member.p001.vo.MemberP001_MemberVO;


@Controller
@RequestMapping("/member")
public class MemberP001_d005ControllerImpl implements MemberP001_d005Controller{

	@Autowired
	MemberP001_d005Service memberP001_d005Service;
	
	@Override
	@RequestMapping(value="/mypage.do")
	public String searchMypageMain(HttpServletRequest request) {
		// 마이페이지로
		return Common.checkLoginDestinationView("mypage", request);
	}

	@Override
	@RequestMapping(value="/updateMember.do")
	public String updateMemberInfo(HttpServletRequest request) {
		// 정보수정 페이지로
		return Common.checkLoginDestinationView("p001_d005_update", request);
	}

	@Override
	@RequestMapping(value="/getByteImage", method = { RequestMethod.GET, RequestMethod.POST })
	public void getByteImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String m_id = request.getParameter("id");
		out.print(Common.encodeBlobImage(m_id, memberP001_d005Service));
	}
	
	@RequestMapping(value="/deleteUserImage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void deleteUserImage(HttpServletRequest request) throws Exception {
//		response.setContentType("text/html;charset=utf-8");
//		PrintWriter out = response.getWriter();
		String m_id = request.getParameter("id");
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("m_img", "");	// img컬럼에 null 저장
		hmap.put("m_id", m_id);
		memberP001_d005Service.saveImage(hmap);
		// 세션 프로필 이미지 set
		String profileImg = Common.encodeBlobImage(m_id, memberP001_d005Service);
		HttpSession session = request.getSession(false);
		session.setAttribute("profileImg", profileImg);
	}
	
	// 실제 저장 클릭시
	@Override
	@RequestMapping(value="/saveMember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveMemberInfo(MemberP001_MemberVO member, HttpServletRequest request) {
		String resultView = "p001_d005_update";
		System.out.println("========================>>" + member.toString());
		// 패스워드 암호화 세팅
		if(!"".equals(member.getM_pwd())) {
			System.out.println("========================>>" + member.getM_pwd());
			String parsePwd = BCrypt.hashpw(member.getM_pwd(), BCrypt.gensalt());
			member.setM_pwd(parsePwd);
		}else {
			String oriPwd = memberP001_d005Service.selectPwdById(member.getM_id());
			member.setM_pwd(oriPwd);
		}
		// 이미지 수정시
		if(!member.getM_img().isEmpty()){
			try {
				Map<String, Object> hmap = new HashMap<String, Object>();
				hmap.put("m_img", member.getM_img().getBytes());
				hmap.put("m_id", member.getM_id());
				memberP001_d005Service.saveImage(hmap);
//			dao.saveImage(hmap);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 멤버추가
		int result = memberP001_d005Service.updateMember(member);
		if(result==1) {	// 추가 성공시
			// 세션 정보업데이트
			HttpSession session = request.getSession(false);
			session.setAttribute("member", member);
			// 세션 프로필 이미지 set
			String profileImg = Common.encodeBlobImage(member.getM_id(), memberP001_d005Service);
			session.setAttribute("profileImg", profileImg);
		}
		return resultView;
	}
	
	
	
}
