package project.root.p001.contoller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class RootP001_d001ControllerImpl implements RootP001_d001Controller {

	// 메인영역
	@RequestMapping(value="/")
	@Override
	public ModelAndView searchInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		
		HttpSession session = request.getSession(false);
//		System.out.println("세션값? >> " + session.getAttribute("member"));
		
		// &분의일 - 같이먹기
		
		// &분의일 - 같이사기
		
		// &분의일 - 같이하기
		
		// 소모임설정
		
		// 업체정보와 후기 출력
		
		//
		return mav;
	}
	
	
	
	// 테스트용, 추후삭제
	//--------------------
	@RequestMapping(value="/admin")
	public String adminMain() {
		return "adminMain";
	}
	//-------------------- 추후삭제









	
}
