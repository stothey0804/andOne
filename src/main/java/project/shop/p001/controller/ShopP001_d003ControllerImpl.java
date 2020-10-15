package project.shop.p001.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p001.service.ShopP001_d003Service;
import project.shop.p001.vo.ShopP001BmemberVO;

@Controller
@RequestMapping(value="/biz/*")
public class ShopP001_d003ControllerImpl implements ShopP001_d003Controller {
	@Autowired
	private ShopP001_d003Service shopP001_d003Service;
	
	//아이디 비밀번호 찾기 페이지 이동
	@Override
	@RequestMapping(value="findInfo.do")
	public String findInfo() {
		return "shop/p001_d003_findInfo";
	}
	
	@Override
	@ResponseBody
	@RequestMapping(value="findId.do")
	public String findId(@ModelAttribute ShopP001BmemberVO vo ) throws Exception {
		String result = shopP001_d003Service.get_findId(vo);
		System.out.println(result);
		return result;
	}
	
}
