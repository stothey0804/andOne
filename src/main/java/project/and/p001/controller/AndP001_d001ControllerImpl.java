package project.and.p001.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import org.aspectj.org.eclipse.jdt.core.dom.ParenthesizedExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
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
import project.and.p002.service.AndP002_d002Service;
import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;
import project.member.p001.vo.MemberP001_MemberVO;
import project.point.p001.service.PointP001_d001Service;


@Controller
@Component
public class AndP001_d001ControllerImpl implements AndP001_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	@Autowired
	private PointP001_d001Service pointP001_d001Service; //포인트조회
	@Autowired
	private AndP002_d002Service p002_d002Service; //인원수 체크용
	
	//&분의일 먹기 사기 하기 메인
	@Override
	@RequestMapping(value="/and*")
	public ModelAndView andOneMain(@RequestParam("g_id") String g_id, 
			@CookieValue(value="locate_lat", required = false) Cookie latCookie, 
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie, HttpServletRequest request) throws Exception {
		
		System.out.println("111111g_id: "+g_id);
		//세션가져오기
//		HttpSession session = request.getSession(false);
		String m_id ="";
		String m_locate_Lat ="";
		String m_locate_Lng ="";
		
		//회원 위치 가져오기
//		if(session.getAttribute("isLogOn") != null) {
//			m_id = (String) session.getAttribute("m_id");
//			Map<String, Object> memLocate = p001_d001Service.selectMemLocate(m_id);
//			m_locate_Lat = (String) memLocate.get("m_locate_Lat");
//			m_locate_Lng = (String) memLocate.get("m_locate_Lng");
//			System.out.println("m_locate_Lat: " +m_locate_Lat);
//			System.out.println("m_locate_Lng: " +m_locate_Lng);
//		}
//		else {//쿠키에 저장된 비회원 위치 가져오기(수정해야함)
			System.out.println("쿠키 받아먹어ㅓㅓㅓㅓㅓ");
			m_locate_Lat = latCookie.getValue();
			m_locate_Lng = lngCookie.getValue();
			System.out.println("123123: "+m_locate_Lat);
			System.out.println("123123: "+m_locate_Lng);
//		}
		
		Map<String,Object> param = new HashMap<String,Object>(); 
		param.put("m_id", m_id);
		param.put("m_locate_Lat", m_locate_Lat);
		param.put("m_locate_Lng", m_locate_Lng);
		param.put("g_id", g_id);
		
		//최근 등록된 같이먹기 + 해쉬태그
		List<AndP001AndOneVO> recentAndOneList = p001_d001Service.recentAndOneList(param); //최근등록된 같이먹기
		List<AndP001AndOneVO> ctg = p001_d001Service.searchCtg(g_id); //카테고리설정
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("andOneMain");
//		mav.setViewName(Common.checkLoginDestinationView("andOneMain", request));
		mav.addObject("g_id",g_id);
		mav.addObject("ctg",ctg);//카테고리
		mav.addObject("recentAndOneList", recentAndOneList);//최근 엔분의일
		
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
	public ModelAndView searchAndOneList(@RequestParam Map<String, Object> searchMap , 
			@CookieValue(value="locate_lat", required = false) Cookie latCookie, 
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie, 
			HttpServletRequest request) throws Exception {
		//1.전체검색
		String one_category = (String)searchMap.get("one_category");
		String g_id = (String)searchMap.get("g_id");
		String totalSearch = (String)searchMap.get("totalSearch");
		System.out.println(">>>>>>>>>>one_category:" +one_category);
		System.out.println(">>>>>>>>>>g_id:" +g_id);
		System.out.println(">>>>>>>>TS :" +totalSearch);
		
		List<AndP001AndOneVO> ctg = p001_d001Service.searchCtg(g_id); //카테고리 설정
		
		//회원 위치 가져오기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_IDM_IDM_ID :"+m_id);
//		Map<String, Object> memLocate = p001_d001Service.selectMemLocate(m_id);
//		String m_locate_Lat = (String) memLocate.get("m_locate_Lat");
//		String m_locate_Lng = (String) memLocate.get("m_locate_Lng");
		String m_locate_Lat = latCookie.getValue();
		String m_locate_Lng = lngCookie.getValue();
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
		mav.addObject("ctg",ctg);
		
		return mav;
	}
	//엔분의일 상세조회
	@Override
	@RequestMapping(value="/and*/detailAndOne.do")
	public ModelAndView andOneDetail(@RequestParam Map<String, Object> detailMap, HttpServletRequest request) throws Exception {
		String one_id = (String) detailMap.get("one_id");
		String g_id = (String) detailMap.get("g_id");
		System.out.println("상세조회용  one_id: "+one_id);
		System.out.println(">>>>oneType:"+detailMap.get("g_id"));
		
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");//아이디조회
		String m_nickname = (String) session.getAttribute("m_nickname");//닉네임조회
		System.out.println("참가자신청용 m_id :"+m_id);
		
		AndP001AndOneVO vo = p001_d001Service.andOneDetail(detailMap);//글 상세조회
		List<AndOneMemberVO> oneMemList = p001_d001Service.oneMemList(one_id); //작성자 참가자 사진 닉네임
		Common.getEncodedAndUser(oneMemList);//작성자 사진 인코딩
		
		Map<String, Object> omCheckMap = new HashMap<String, Object>();
		omCheckMap.put("one_id", one_id);
		omCheckMap.put("m_id", m_id);
		
		AndOneMemberVO omLeaderCheck = p001_d001Service.omLeaderCheck(omCheckMap);//작성자 참가자 확인
		System.out.println("힘들다ㅏㅏㅏㅏㅏㅏ"+omLeaderCheck);

		ModelAndView mav = new ModelAndView();
		mav.setViewName(Common.checkLoginDestinationView("andOneDetail", request));
		mav.addObject("andoneDetail", vo);
		mav.addObject("oneMemList",oneMemList);//닉네임 사진
		mav.addObject("omLeaderCheck",omLeaderCheck);//om_state + om_leader
		mav.addObject("m_nickname",m_nickname);
		mav.addObject("g_id",g_id);
		return mav;
	}
	//신청하기 ->포인트충전
	@Override
	@ResponseBody
	@RequestMapping(value="/and*/addOneMember.do")
	public String addOneMember(@RequestParam Map<String,Object> addMap, HttpServletRequest request) throws Exception {
		String one_price = (String) addMap.get("one_price");
		String one_id = (String) addMap.get("one_id");
		
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("참가자신청용 m_id :"+m_id);
		//인원확인
		int andOneCnt = p002_d002Service.andOneCnt(one_id); //글작성시 선택한 참가자 수
		Map<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("one_id", one_id);
		cntMap.put("flag", "pay");
		int oneMemCnt = p002_d002Service.oneMemCnt(cntMap); //신청 수락완료된 참가자 수(om_state 20->참여확정상태)
		
		String beforePoint = pointP001_d001Service.selectNowPointById(m_id);//보유 포인트 확인
		beforePoint = beforePoint==null? "0": beforePoint;
		int afterPoint = Integer.parseInt(beforePoint);//보유포인트
		int price = Integer.parseInt(one_price);//가격
		
		if(andOneCnt == oneMemCnt) { //인원초과 신청불가
			return "false";
		}else if(price>afterPoint) { //포인트부족(1) 
			return beforePoint;
		}else { //결제가능(0)
			return "true";
		}
	}

	@Scheduled(fixedRate = 100000) //10초마다 함수호출
	public void handle() {
		System.out.println("=================================>> LogProcessor.handle(): " + new Date());
		p001_d001Service.updateAndOneState();//one_id로 select후 상태 취소로 업데이트
		//취소 상태 작성자 빼고 환불
		
		//환불 컬럼 포인트 지급 컬럼
		//결제완료 상태되면 작성자에게 포인트 지급
		
	}
	
}

