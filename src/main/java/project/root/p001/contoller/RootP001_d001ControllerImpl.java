package project.root.p001.contoller;

import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.and.p001.service.AndP001_d001Service;
import project.and.vo.AndP001AndOneVO;
import project.club.p001.service.ClubP001_d001Service;
import project.club.vo.ClubVO;
import project.root.p001.service.RootP001_d001Service;



@Controller
public class RootP001_d001ControllerImpl implements RootP001_d001Controller {
	@Autowired
	RootP001_d001Service rootP001_d001Service;
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	AndP001_d001Service p001_d001Service;
	
	// 메인영역
	@RequestMapping(value="/")
	@Override
	public ModelAndView searchInit(@CookieValue(value="locate_lat", required = false) Cookie latCookie, 
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie, HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		// 초기값 set
		String m_locate_Lat = "37.570371";
		String m_locate_Lng = "126.985308";
		try {
			if(latCookie!=null && lngCookie!=null) {
				m_locate_Lat = latCookie.getValue();
				m_locate_Lng = lngCookie.getValue();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// &분의일 - 같이먹기
		Map<String,Object> andeat = new HashMap<String,Object>(); 
		andeat.put("m_locate_Lat", m_locate_Lat);
		andeat.put("m_locate_Lng", m_locate_Lng);
		andeat.put("g_id", "010");
		List<AndP001AndOneVO> andEatList = p001_d001Service.recentAndOneList(andeat);
		
		
		// &분의일 - 같이사기
		Map<String,Object> andbuy = new HashMap<String,Object>(); 
		andbuy.put("m_locate_Lat", m_locate_Lat);
		andbuy.put("m_locate_Lng", m_locate_Lng);
		andbuy.put("g_id", "011");
		List<AndP001AndOneVO> andBuyList = p001_d001Service.recentAndOneList(andbuy);
		
		// &분의일 - 같이하기
		Map<String,Object> anddo= new HashMap<String,Object>(); 
		anddo.put("m_locate_Lat", m_locate_Lat);
		anddo.put("m_locate_Lng", m_locate_Lng);
		anddo.put("g_id", "012");
		List<AndP001AndOneVO> andDoList = p001_d001Service.recentAndOneList(anddo);
		// 소모임설정
		List<ClubVO> clubList = clubP001_d001Service.clubList();
		//소모임 대표이미지 encoding
		getEncoded(clubList);
		
		// 업체정보와 후기 출력
		
		//
		mav.addObject("clubList", clubList);
		mav.addObject("andEatList", andEatList);
		mav.addObject("andBuyList", andBuyList);
		mav.addObject("andDoList", andDoList);
		
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
	public void selectMemberLocate(@CookieValue(value="locate_lat", required = false) Cookie latCookie,
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
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
		out.print(jsonStr);
		out.close();
	}
	
	// 어드민 연결
	@RequestMapping(value="/admin")
	public ModelAndView adminMain(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("adminMain", request));
		// 어드민 메인 조회 데이터
		mav.addObject("newDataSet", rootP001_d001Service.selectTodayAdminMain());
		// 신규멤버 데이터
		mav.addObject("newMemberSet", separateChartList(rootP001_d001Service.selectWeeklyNewMember()));
		// 매출액 데이터
		mav.addObject("newSalesSet", separateChartList(rootP001_d001Service.selectWeeklySales()));
		return mav;
	}
	
	// 라벨, 값 분리 저장
	private Map<String, Object> separateChartList(List<Map<String, String>> list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<String> labels = new ArrayList<String>();
		List<String> data = new ArrayList<String>(Arrays.asList("0","0","0","0","0","0","0"));
		// 7일범위 만들기
		LocalDate today = LocalDate.now();
		for(int i = -6; i <= 0; i++) {
			labels.add(today.plusDays(i).toString());
		}
		// 날짜별로 값 조회 저장
		for(int i = 0; i < labels.size(); i++) {
			for(Map iter: list) {
				if((labels.get(i)).equals(String.valueOf(iter.get("date")))) {	
					data.set(i, String.valueOf(iter.get("result")));
					break;
				}
			}
		}
		// 라벨 값 조정(small quote추가)
		for(int i = 0; i < labels.size(); i++) {
			labels.set(i, "'"+labels.get(i)+"'");
		}
		resultMap.put("labels",labels);
		resultMap.put("data",data);
		return resultMap;
	}

	//article encoding method
	public void getEncoded(List<ClubVO> list) {
		byte[] encoded = null;
		if(list!=null) {
			for(int i=0; i < list.size();i++) {
				if(list.get(i).getC_imgByte() != null) {
					encoded = Base64.getEncoder().encode(list.get(i).getC_imgByte());
					list.get(i).setResultImg(new String(encoded));	
				}
			}
		}
	}
}
