package project.shop.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import project.shop.p001.service.ShopP001_d001Service;
import project.shop.p001.vo.ShopP001_d001VO;


@Controller
public class ShopP001_d001ControllerImpl implements ShopP001_d001Controller {
	@Autowired
	private ShopP001_d001Service shopP001_d001Service;
	@Autowired
	private ShopP001_d001VO shopP001_d001VO;
	
	//약관동의 페이지
	@Override
	@RequestMapping(value="/biz/join.do")
	public ModelAndView init() throws Exception {
		System.out.println(">>>>>>>>>>>>약관동의페이지");
		ModelAndView mav = new ModelAndView("shop/p001_d001_join_step1");
		return mav;
	}
	//회원가입 페이지
	@Override
	@RequestMapping(value="/biz/joinform.do")
	public ModelAndView joinform() throws Exception {
		System.out.println(">>>>>>>>>>>>회원가입페이지");
		ModelAndView mav = new ModelAndView("shop/p001_d001_join_step2");
		return mav;
	}
	//id중복체크
	@RequestMapping(value="/biz/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("bm_id") String bm_id) throws Exception{
		System.out.println(">>>>>>>>아이디중복체크");
		System.out.println(bm_id);
		int result = shopP001_d001Service.IdCheck(bm_id);
		System.out.println(result);
		return result;
	}
	//이메일 중복체크
	@RequestMapping(value="/biz/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("bm_email") String bm_email) throws Exception{
		System.out.println(">>>>>>>>이메일중복체크");
		int result = shopP001_d001Service.EmailCheck(bm_email);
		return result;
	}
	//회원가입신청
	@RequestMapping(value="/biz/addMember")
	public ModelAndView addMember(@RequestParam Map<String, String> bMemberMap) throws Exception{
		System.out.println(">>>>>>>>>회원가입신청");
		//암호화 -> DB넣어주기
		String bm_id = bMemberMap.get("bm_id");
		String bm_name = bMemberMap.get("bm_name");
		String bm_email = bMemberMap.get("bm_email");
		String bm_phonenumber = bMemberMap.get("bm_phonenumber");
		String bm_pwd = bMemberMap.get("bm_pwd");
		System.out.println(bm_pwd);
		bm_pwd = BCrypt.hashpw(bMemberMap.get("bm_pwd"), BCrypt.gensalt()); //패스워드 암호화
		System.out.println(bm_pwd);
		System.out.println(bm_id);
		System.out.println(bm_name);
		System.out.println(bm_email);
		System.out.println(bm_phonenumber);
		
		int result = shopP001_d001Service.addBmember(bMemberMap);
		if(result == 1) {
			ModelAndView mav =  new ModelAndView("shop/p001_d001_join_step3");
			return mav;
		}else {
			ModelAndView mav =  new ModelAndView("shop/p001_d001_join_step2");
			return mav;
		}
	}
	 
	
	

}

