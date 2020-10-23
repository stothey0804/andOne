package project.root.p001.contoller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
		

//		HttpSession session = request.getSession(false);
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
	@RequestMapping(value="/member/saveLocate.do", method= {RequestMethod.POST, RequestMethod.GET})
	public void saveMemberLocation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String m_id = request.getParameter("id");
		String locate_lat = request.getParameter("locate_lat");
		String locate_lng = request.getParameter("locate_lng");
		// locate 값 존재시
		if(locate_lat!=null && locate_lng!=null) {
			// locate 쿠키 저장
			Cookie latCookie = new Cookie("locate_lat", locate_lat);
			Cookie lngCookie = new Cookie("locate_lng", locate_lng);
			latCookie.setMaxAge(60*60*24*7);	// 일주일
			lngCookie.setMaxAge(60*60*24*7);
			response.addCookie(latCookie);
			response.addCookie(lngCookie);
			// 로그인 중일 경우 DB저장
			if(m_id!=null && m_id!="") {	
				Map<String, String> map = new HashMap<String, String>();
				map.put("m_id", m_id);
				map.put("m_locate_lat", locate_lat);
				map.put("m_locate_lng", locate_lng);
				rootP001_d001Service.updateMemberLocate(map);
			}
		}
		
	}
	
	// locate 조회
	@RequestMapping(value="/member/selectLocate.do", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String selectMemberLocate(@CookieValue(value="locate_lat", required = false) Cookie latCookie,
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
//		response.setContentType("text/html;charset=utf-8");
		String jsonStr = "";
		Map<String, String> locate = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();
		String m_id = request.getParameter("id");
		if(m_id!=null && m_id!="") {	// 로그인시 DB조회
			locate = rootP001_d001Service.selectMemberLocate(m_id);
			// 쿠키갱신
			latCookie = new Cookie("locate_lat", locate.get("M_LOCATE_LAT"));
			lngCookie = new Cookie("locate_lng", locate.get("M_LOCATE_LNG"));
			response.addCookie(latCookie);
			response.addCookie(lngCookie);
		}else {	// 비로그인 시 쿠키에서 조회
			if(latCookie == null || lngCookie == null) {
				locate.put("M_LOCATE_LAT","0");
				locate.put("M_LOCATE_LNG","0");
			}else {
				locate.put("M_LOCATE_LAT",latCookie.getValue());
				locate.put("M_LOCATE_LNG",lngCookie.getValue());

			}
		}
		System.out.println("==========> locate" + locate);
		jsonStr = mapper.writeValueAsString(locate);
		return jsonStr;
	}
	
	// 어드민 연결
	@RequestMapping(value="/admin")
	public String adminMain(HttpServletRequest request) {
		return Common.checkAdminDestinationView("adminMain", request);
	}
	

	
}
