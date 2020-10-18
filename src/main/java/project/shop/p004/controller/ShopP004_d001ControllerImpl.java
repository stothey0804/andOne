package project.shop.p004.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShopP004_d001ControllerImpl implements ShopP004_d001Controller{

	// 테스트용이므로 추후 자유롭게 삭제,수정하세요.
	@Override
	@RequestMapping("/shop/admin.do")
	public String shopAdminInit(HttpServletRequest request) {
		// 지역멤버 로그인 체크 필요함 (추후 Common에 추가 생성해주시면 될듯합니다.)
		String result = "shopAdminMain";
		return result;
	}

}
