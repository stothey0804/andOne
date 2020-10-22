package project.and.p001.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;

import common.Common;
import net.sf.json.JSONArray;
import project.and.p001.service.AndP001_d001Service;
import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;
import project.member.p001.vo.MemberP001_MemberVO;
import project.point.p001.service.PointP001_d001Service;


@Controller
public class AndP001_d001ControllerImpl implements AndP001_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	@Autowired
	PointP001_d001Service pointP001_d001Service; //포인트조회
	
	//&분의일 먹기 사기 하기 메인
	@Override
	@RequestMapping(value="/and*")
	public ModelAndView andOneMain(@RequestParam("g_id") String g_id, 
			@CookieValue(value="locate_lat", required = false) Cookie locate_lat, 
			@CookieValue(value="locate_lng", required = false) Cookie locate_lng, HttpSession session) throws Exception {
		System.out.println("111111g_id: "+g_id);
		
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_IDM_IDM_ID :"+m_id);
		
		String m_locate_Lat ="";
		String m_locate_Lng ="";
		
		//회원 위치 가져오기
		if(m_id != null && m_id !="" ) {
			Map<String, Object> memLocate = p001_d001Service.selectMemLocate(m_id);
			m_locate_Lat = (String) memLocate.get("m_locate_Lat");
			m_locate_Lng = (String) memLocate.get("m_locate_Lng");
			System.out.println("m_locate_Lat: " +m_locate_Lat);
			System.out.println("m_locate_Lng: " +m_locate_Lng);
			
		}else if(m_id == null) {//쿠키에 저장된 비회원 위치 가져오기
			System.out.println("쿠키 fkfdslhsfdgkldfj받아먹어ㅓㅓㅓㅓㅓ");
			m_locate_Lat = locate_lat.getValue();
			m_locate_Lng = locate_lng.getValue();
			
			System.out.println("123123: "+m_locate_Lat);
			System.out.println("123123: "+m_locate_Lng);
		}
		
		Map<String,Object> param = new HashMap<String,Object>(); 
		param.put("m_id", m_id);
		param.put("m_locate_Lat", m_locate_Lat);
		param.put("m_locate_Lng", m_locate_Lng);
		param.put("g_id", g_id);
		
		//최근 등록된 같이먹기 + 해쉬태그
		List<AndP001AndOneVO> recentAndOneList = p001_d001Service.recentAndOneList(param); //최근등록된 같이먹기
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리설정
		
		
		//AndOne 글 위치 가져오기
//		List<Map<String,Object>> andOneLocate = p001_d001Service.selectAndOneLocate(g_id);
//		System.out.println("11"+andOneLocate.get(6));
//		System.out.println("22"+andOneLocate.get(9));	
//		JSONArray jsonArray = new JSONArray();
		
		ModelAndView mav = new ModelAndView("andOneMain");
		mav.addObject("g_id",g_id);
		mav.addObject("ctg_eat",ctg_eat);//카테고리
		mav.addObject("recentAndOneList", recentAndOneList);//최근 엔분의일
		//mav.addObject("memLocate",memLocate); //멤버위치
		
		//mav.addObject("andOneLocate",jsonArray.fromObject(andOneLocate)); //엔분의일 글 위치
		
		return mav;
	}
	
	//&분의 일 같이먹기 List
	//1.전체검색 O
	//2.카테고리검색 O
	//3.해쉬태그검색 
	//4.거리순정렬
	//5.마감순정렬
	@Override
	@RequestMapping(value="/and*/searchAndOne.do")
	public ModelAndView searchAndOneList(@RequestParam Map<String, Object> searchMap , HttpSession session) throws Exception {
		//1.전체검색
		String one_category = (String)searchMap.get("one_category");
		String g_id = (String)searchMap.get("g_id");
		String totalSearch = (String)searchMap.get("totalSearch");
		System.out.println(">>>>>>>>>>one_category:" +one_category);
		System.out.println(">>>>>>>>>>g_id:" +g_id);
		System.out.println(">>>>>>>>TS :" +totalSearch);
		
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리 설정
		
		//회원 위치 가져오기
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_IDM_IDM_ID :"+m_id);
		Map<String, Object> memLocate = p001_d001Service.selectMemLocate(m_id);
		String m_locate_Lat = (String) memLocate.get("m_locate_Lat");
		String m_locate_Lng = (String) memLocate.get("m_locate_Lng");
		System.out.println("m_locate_Lat22: " +m_locate_Lat);
		System.out.println("m_locate_Lng22: " +m_locate_Lng);
		
		searchMap.put("m_id", m_id);
		searchMap.put("m_locate_Lat", m_locate_Lat);
		searchMap.put("m_locate_Lng", m_locate_Lng);
		searchMap.put("g_id", g_id);
		
		
		List<AndP001AndOneVO> SearchAndOneList =null;
		if(totalSearch != null) {
			System.out.println(">>>>>>>>>>>>>>>전체검색 실행");
			SearchAndOneList = p001_d001Service.totalSearchList(searchMap);//전체 검색
		}else {
			System.out.println(">>>>>>>>>>>>>>>카테고리검색 실행");
			SearchAndOneList = p001_d001Service.ctgSearchList(searchMap);//카테고리별 검색
		}
		
		ModelAndView mav = new ModelAndView("andOneSearch");
		mav.addObject("SearchAndOneList", SearchAndOneList);
		mav.addObject("size",SearchAndOneList.size()); //검색 결과 건수
		mav.addObject("g_id",g_id);
		mav.addObject("ctg_eat",ctg_eat);
		
		return mav;
	}
	//엔분의일 상세조회
	@Override
	@RequestMapping(value="/and*/detailAndOne.do")
	public ModelAndView andOneDetail(@RequestParam Map<String, Object> detailMap, HttpSession session) throws Exception {
		String one_id = (String) detailMap.get("one_id");
		System.out.println("상세조회용  one_id: "+one_id);
		System.out.println(">>>>oneType:"+detailMap.get("g_id"));
		
		String m_id = (String) session.getAttribute("m_id");
		String m_nickname = (String) session.getAttribute("m_nickname");
		
		System.out.println("참가자신청용 m_id :"+m_id);
		
		List<AndP001AndOneVO> andOneDetailList = p001_d001Service.andOneDetailList(detailMap);//글 상세조회
		List<AndOneMemberVO> oneMemList = p001_d001Service.oneMemList(one_id); //작성자 참가자 사진 닉네임
		Common.getEncodedAndUser(oneMemList);//작성자 사진 인코딩
		
		Map<String, Object> omCheckMap = new HashMap<String, Object>();
		omCheckMap.put("one_id", one_id);
		omCheckMap.put("m_id", m_id);
		String omLeaderCheck = p001_d001Service.omLeaderCheck(omCheckMap);//작성자 참가자 확인
		System.out.println("힘들다ㅏㅏㅏㅏㅏㅏ"+omLeaderCheck);
		
		ModelAndView mav = new ModelAndView("andOneDetail");
		mav.addObject("andOneDetailList",andOneDetailList);
		mav.addObject("oneMemList",oneMemList);
		mav.addObject("omLeaderCheck",omLeaderCheck);
		mav.addObject("m_nickname",m_nickname);
		return mav;
	}
	//oneMember update
	@Override
	@ResponseBody
	@RequestMapping(value="/and*/addOneMember.do")
	public String addOneMember(@RequestParam Map<String, Object> addMemMap, HttpSession session) throws Exception {

		System.out.println(addMemMap.get("one_type")); 
		System.out.println(addMemMap.get("one_id"));
		String one_price = (String) addMemMap.get("one_price"); // 글에 있는 가격
		
		
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("참가자신청용 m_id :"+m_id);
		
		addMemMap.put("m_id", m_id);
		
		//포인트 확인
		String point = pointP001_d001Service.selectNowPointById(m_id);
		point = point==null? "0": point;
		System.out.println("포인트나와"+point);
		
		if(one_price.compareTo(point)>0) { //포인트부족(1) 
			return point;
		}else { //결제가능(0)
			//p001_d001Service.addOneMember(addMemMap);
			return "true";
		}
	}
}

