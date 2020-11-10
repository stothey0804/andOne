package project.shop.p001.controller;

import java.util.HashMap;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.member.p001.service.MemberP001_d003Service;
import project.shop.p001.service.ShopP001_d002Service;
import project.shop.p001.service.ShopP001_d003Service;
import project.shop.p001.service.ShopP001_d005Service;
import project.shop.p001.vo.ShopP001BmemberVO;

@Controller
@RequestMapping(value="/biz/*")
public class ShopP001_d003ControllerImpl implements ShopP001_d003Controller {
	@Autowired
	private ShopP001_d003Service shopP001_d003Service;
	@Autowired
	private ShopP001_d002Service shopP001_d002Service;
	@Autowired
	private ShopP001_d005Service shopP001_d005Service;
	@Autowired
	private MemberP001_d003Service memberP001_d003Service;
	
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
	@RequestMapping("sendEmail.do")
	public String sendEmail(@RequestParam String bm_email) {
		String to = bm_email;
		String subject = "[&분의일]비밀번호 변경 이메일입니다.";
		String url = "/andOne/biz/emailCheck.do";
		Map<String,String> resultMap = shopP001_d003Service.selectIdPwdByEmail(bm_email);
		url += "?id=" + resultMap.get("BM_ID");
		url += "&key=" + resultMap.get("BM_PWD");
		String body = "<div style=\"width:600px;padding: 10px 20px;border:1px solid gray;background:white\">\r\n" + 
				"<h3>비밀번호 변경 안내</h3>\r\n" + 
				"<hr>\r\n" + 
				"<p>안녕하세요, &분의일 입니다.</p>\r\n" + 
				"<p>비밀번호를 변경하시려면 아래 링크를 클릭해주세요.</p>\r\n" + 
				"<a href='" + url +"'>비밀번호 변경하기</a>\r\n" + 
				"<br><br>\r\n" + 
				"<h2 align=\"right\">&분의일</h2>\r\n" + 
				"</div>";
		memberP001_d003Service.sendMail(to, subject, body);
		return "p001_d003_search";
	}
	//프로세스 3 : 이메일 링크를 눌렀을때 들어오는 컨트롤러. 비밀번호 확인 후 수정 페이지로 보내준다.
	@RequestMapping("emailCheck.do")
	public String emailCheck(@RequestParam String id, @RequestParam String key, Model model) {
		String view = "errorPage"; // 에러페이지 만들어서 보내주면 좋겠음
		String oriPwd = shopP001_d005Service.selectPwdById(id);
		if(oriPwd != null && oriPwd.equals(key)) {
			model.addAttribute("bm_id", id);
			view = "shop/p001_d003_changeBmemberPwd";
		}
		return view;
	}
	//프로세스 4 : 수정 페이지에서 수정 버튼 눌렀을 때 들어오는 컨트롤러. 변경작업 완료 후 완료알림 페이지로 리턴
	@RequestMapping("updatePwd.do")
	public String updatePwd(@RequestParam String bm_id, @RequestParam String bm_pwd) {
		Map<String,String> paramMap = new HashMap<>();
		String encodedPwd = BCrypt.hashpw(bm_pwd, BCrypt.gensalt());
		paramMap.put("bm_id", bm_id);
		paramMap.put("bm_pwd", encodedPwd);
		shopP001_d003Service.updatePwd(paramMap);
		return "shop/p001_d003_changeBmemberPwdSub_0";
	}
}
