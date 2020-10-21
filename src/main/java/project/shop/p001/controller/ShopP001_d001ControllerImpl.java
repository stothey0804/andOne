package project.shop.p001.controller;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p001.service.ShopP001_d001Service;
import project.shop.p001.vo.ShopP001BmemberVO;


@Controller
@RequestMapping("/biz/*")
public class ShopP001_d001ControllerImpl implements ShopP001_d001Controller {
	@Autowired
	private ShopP001_d001Service shopP001_d001Service;

	//약관동의 페이지
	@Override
	@RequestMapping(value="join.do")
	public String init() {
		System.out.println(">>>>>>>>>>>>약관동의페이지");
		return "shop/p001_d001_init";
	}
	//회원가입 페이지
	@Override
	@RequestMapping(value="joinform.do")
	public String joinform() {
		System.out.println(">>>>>>>>>>>>회원가입페이지");
		return "shop/p001_d001_inserBmember";
	}
	//id중복체크
	@Override
	@RequestMapping(value="idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("bm_id") String bm_id) throws Exception{
		System.out.println(">>>>>>>>아이디중복체크");
		System.out.println(bm_id);
		int result = shopP001_d001Service.IdCheck(bm_id);
		System.out.println(result);
		return result;
	}
	//이메일 중복체크
	@Override
	@RequestMapping(value="emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("bm_email") String bm_email) throws Exception{
		System.out.println(">>>>>>>>이메일중복체크");
		int result = shopP001_d001Service.EmailCheck(bm_email);
		return result;
	}
	//회원가입신청
	@Override
	@RequestMapping(value="addMember")
	public String addMember(@ModelAttribute("bMember") ShopP001BmemberVO shopP001_d001VO) throws Exception{
		System.out.println(">>>>>>>>>회원가입신청");
		//암호화 -> DB넣어주기
		String bm_pwd = BCrypt.hashpw(shopP001_d001VO.getBm_pwd(), BCrypt.gensalt()); //패스워드 암호화
		shopP001_d001VO.setBm_pwd(bm_pwd);
		
		int result = shopP001_d001Service.addBmember(shopP001_d001VO);
		if(result == 1) {
			return "shop/p001_d001_insertBmember_sub01";
		}else {
			return "shop/p001_d001_insertBmember";
		}
	}
	 
	
	

}

