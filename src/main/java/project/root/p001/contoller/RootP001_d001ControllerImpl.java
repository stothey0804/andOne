package project.root.p001.contoller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.root.p001.service.RootP001_d001Service;



@Controller
public class RootP001_d001ControllerImpl implements RootP001_d001Controller {
	@Autowired
	RootP001_d001Service rootP001_d001Service;
	
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
	
	// locate 저장
	@RequestMapping(value="/member/saveLocation.do", method= {RequestMethod.POST})
	public void saveMemberLocation(HttpServletRequest request) throws Exception {
		String m_id = request.getParameter("id");
		String m_locate = request.getParameter("locate");
		if(m_id!=null && m_locate!=null) {	// 
			Map<String, String> map = new HashMap<String, String>();
			map.put("m_id", m_id);
			map.put("m_locate", m_locate);
			rootP001_d001Service.updateMemberLocate(map);
		}
	}
	
	// locate 조회
	@RequestMapping(value="/member/selectLocate.do", method= {RequestMethod.POST, RequestMethod.GET})
	public void selectMemberLocate(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String m_id = request.getParameter("id");
		if(m_id!=null && m_id!="") {
			String m_locate = rootP001_d001Service.selectMemberLocate(m_id);
			out.write(m_locate);
		}
	}
	
	// 어드민 연결
	@RequestMapping(value="/admin")
	public String adminMain(HttpServletRequest request) {
		return Common.checkAdminDestinationView("adminMain", request);
	}









	
}
