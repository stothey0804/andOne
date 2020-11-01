package project.shop.p001.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.shop.p001.service.ShopP001_d002Service;
import project.shop.p001.service.ShopP001_d003Service;
import project.shop.p001.vo.ShopP001BmemberVO;

@Controller
@RequestMapping(value="/biz/*")
public class ShopP001_d003ControllerImpl implements ShopP001_d003Controller {
	@Autowired
	private ShopP001_d003Service shopP001_d003Service;
	@Autowired
	private ShopP001_d002Service shopP001_d002Service;
	
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
	
	//비밀번호 찾기 시작
	
	//프로세스 1 : 입력받은 아이디와 이메일로 아작스 서칭
	@ResponseBody
	@RequestMapping("checkIdAndEmail.do")
	public String checkIdAndEmail(@RequestParam String bm_id, @RequestParam String bm_email) {
		String result = "";
		ShopP001BmemberVO vo = shopP001_d002Service.loginCheck(bm_id);
		String resultEmail = shopP001_d003Service.selectOverlapEmail(bm_email);
		if(vo != null && resultEmail != null && !resultEmail.equals("")) {
			if(vo.getBm_email().equals(resultEmail)) {
				result = "true";
			}else {
				result = "false";
			}
		}else {
			result = "false";
		}
		return result;
	}
	
	//프로세스 2 : 이메일 보내기, 이후 발송완료 페이지로 리턴
		//toDo - 발송완료 페이지 제작
	//프로세스 3 : 이메일 링크를 눌렀을때 들어오는 컨트롤러. 비밀번호 확인 후 수정 페이지로 보내준다.
		//toDo - 수정 페이지 제작
	//프로세스 4 : 수정 페이지에서 수정 버튼 눌렀을 때 들어오는 컨트롤러. 변경작업 완료 후 완료알림 페이지로 리턴
		//toDo - 완료알림 페이지 제작
}
