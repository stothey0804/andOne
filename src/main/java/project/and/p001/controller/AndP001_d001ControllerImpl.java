package project.and.p001.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import common.Common;
import project.and.p001.service.AndP001_d001Service;
import project.and.p002.service.AndP002_d002Service;
import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;
import project.point.p001.service.PointP001_d001Service;
import project.point.p001.service.PointP001_d002Service;
import project.point.p001.vo.PointP001VO;


@Controller
@Component
public class AndP001_d001ControllerImpl implements AndP001_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	@Autowired
	private PointP001_d001Service pointP001_d001Service; //포인트조회
	@Autowired
	private AndP002_d002Service p002_d002Service; //인원수 체크용
	@Autowired
	private PointP001_d002Service pointP001_d002Service; // 포인트 사용
	
	//&분의일 먹기 사기 하기 메인
	@Override
	@RequestMapping(value="/and*")
	public ModelAndView andOneMain(@RequestParam Map<String, Object> mainMap, 
			@CookieValue(value="locate_lat", required = false) Cookie latCookie, 
			@CookieValue(value="locate_lng", required = false) Cookie lngCookie, HttpServletRequest request) throws Exception {
		
		String g_id = (String) mainMap.get("g_id");
		String flag = (String) mainMap.get("flag");
		System.out.println("************메인용g_id: "+g_id);
		System.out.println("************메인용flag: "+flag);
		//세션가져오기
		String m_id ="";
		String m_locate_Lat ="";
		String m_locate_Lng ="";

		m_locate_Lat = latCookie.getValue();
		m_locate_Lng = lngCookie.getValue();
		System.out.println("123123: "+m_locate_Lat);
		System.out.println("123123: "+m_locate_Lng);

		Map<String,Object> param = new HashMap<String,Object>(); 
		param.put("m_id", m_id);
		param.put("m_locate_Lat", m_locate_Lat);
		param.put("m_locate_Lng", m_locate_Lng);
		param.put("g_id", g_id);
		param.put("flag", flag);
		
		List<AndP001AndOneVO> ctg = p001_d001Service.searchCtg(g_id); //카테고리설정
		List<AndP001AndOneVO> recentAndOneList = null;
		//최근 등록된 같이먹기 + 해쉬태그
		if(flag ==null || flag.equals("")) {
			recentAndOneList = p001_d001Service.recentAndOneList(param); //최근등록된 같이먹기			
		}else if(flag.equals("distance")) {
			System.out.println(">>>>>>>>distance");
			recentAndOneList = p001_d001Service.recentAndOneList(param);//거리순
		}else if(flag.equals("date")) {
			System.out.println(">>>>>>>>date");
			recentAndOneList = p001_d001Service.recentAndOneList(param);//마감순
		}
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("andOneMain");
		mav.addObject("g_id",g_id);
		mav.addObject("ctg",ctg);//카테고리
		mav.addObject("recentAndOneList", recentAndOneList);//최근 엔분의일
		
		return mav;
	}
	
	//&분의 일 같이먹기 List
	//1.전체검색 O
	//2.카테고리검색 O
	//3.해쉬태그검색 
	//4.거리순정렬O
	//5.마감순정렬O
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
		String mapPrice = (String) addMap.get("one_price");
		String one_id = (String) addMap.get("one_id");
		
		String one_price = mapPrice.replaceAll("[^0-9]", "");
		System.out.println("콤마제거콤마제거"+one_price);
		
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

	@Scheduled(fixedRate = 60000000) //1분마다 호출
	public void handle() {
		System.out.println("=================================>> LogProcessor.handle(): " + new Date());
		
		p001_d001Service.updateAndOneState();//시간초과 엔분의일 취소
		
		//취소 상태 작성자 빼고 환불
		List<AndP001AndOneVO> pointList = p001_d001Service.pointList();
		for(int i =0; i<pointList.size(); i++) {
			String m_id = pointList.get(i).getM_id();
			String one_price = pointList.get(i).getOne_price();
			String one_id = pointList.get(i).getOne_id();
			
			PointP001VO pointVO = new PointP001VO();
			pointVO.setM_id(m_id);
			pointVO.setP_changepoint(one_price);
			pointVO.setP_detail("&분의일["+one_id+"]취소 포인트환불");
			String nowPoint = pointP001_d001Service.selectNowPointById(m_id);
			pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint); //포인트 null값 0으로 변경
			pointP001_d002Service.insertPoint(pointVO);//포인트 환불
			nowPoint = pointP001_d001Service.selectNowPointById(m_id); //환불 후 값 갱신
			p001_d001Service.updateAndOneRefund(one_id);//엔분의일 테이블 refund 0->1변경
		}
		//결제완료 상태되면 작성자에게 포인트 지급
		List<AndP001AndOneVO> payList = p001_d001Service.payList();
		for(int i =0; i<payList.size(); i++) {
			String m_id = payList.get(i).getM_id();
			String one_price = payList.get(i).getOne_price();
			String one_id = payList.get(i).getOne_id();
			
			PointP001VO pointVO = new PointP001VO();
			pointVO.setM_id(m_id);
			pointVO.setP_changepoint(one_price);
			pointVO.setP_detail("&분의일["+one_id+"]결제용 포인트지급");
			String nowPoint = pointP001_d001Service.selectNowPointById(m_id);
			pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint); //포인트 null값 0으로 변경
			pointP001_d002Service.insertPoint(pointVO);//포인트 환불
			nowPoint = pointP001_d001Service.selectNowPointById(m_id); //환불 후 값 갱신
			p001_d001Service.updateAndOnePay(one_id);//엔분의일 pay 0->1변경
		}
		
	}
	
}

