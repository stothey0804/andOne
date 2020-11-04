package project.and.p002.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.and.p001.service.AndP001_d001Service;
import project.and.p002.service.AndP002_d001Service;
import project.and.p002.service.AndP002_d002Service;
import project.and.vo.AndP001AndOneVO;

@Controller
public class AndP002_d001ControllerImpl implements AndP002_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service; //엔분의일 수정
	@Autowired
	private AndP002_d001Service p002_d001Service;
	@Autowired
	private AndP002_d002Service p002_d002Service;
	
	//글쓰기로 이동
	@Override
	@RequestMapping(value="/and*/insertAndOnePage.do")
	public ModelAndView insertAndOnePage(HttpServletRequest request) {
		String g_id = request.getParameter("g_id");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+g_id);
		List<AndP001AndOneVO> ctg = p001_d001Service.searchCtg(g_id); //카테고리설정
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(Common.checkLoginDestinationView("insertAndOnePage", request));
		mav.addObject("g_id",g_id);//구분
		mav.addObject("ctg",ctg);//카테고리
		return mav;
	}
	//글쓰기 내용 DB저장
	@Override
	@RequestMapping(value="/and*/insertAndOne.do")
	public String insertAndOne(@RequestParam Map<String,Object> Andone, HttpServletRequest request) {
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		String g_id = (String) Andone.get("one_type");
		System.out.println(g_id);
		String one_addr = (String) Andone.get("one_addr");
		System.out.println("한글주소:"+one_addr);
		
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_ID :"+m_id); //회원아이디 가져오기
		Andone.put("m_id", m_id);//m_id 추가
		
		p002_d001Service.insertAndOne(Andone); //글쓰기
		System.out.println(">>>>>>>>>>>>>>>>글쓰기 성공<<<<<<<<<<<<<<<<<<<<<<<<<<");
		p002_d001Service.insertOneMem(Andone); //참가자 테이블 추가하기
		
		return "redirect:/and?g_id="+g_id;
	}
	//&분의일 삭제
	@Override
	@ResponseBody
	@RequestMapping(value="/and*/deleteAndOne.do")
	public String deleteAndOne(@RequestParam ("one_id") String one_id) {
		int countOneMem = p002_d001Service.countOneMem(one_id);
		String check = "ok";
		if(countOneMem > 1) { //참가자가 있을 경우
			System.out.println("참가자있음");
			return check;
		}else { //참가자가 없는 경우
			System.out.println("참가자없음");
			p002_d001Service.deleteAndOne(one_id);
			check = "empty";
			return check;
		}
	}
	
	//&분의일 수정조건확인 후 수정페이지로 이동
	@Override
	@ResponseBody
	@RequestMapping(value="/and*/modifyAndOneCheck.do")
	public String modifyAndOneCheck(@RequestParam("one_id") String one_id) {
		System.out.println("확인:"+one_id);
		int countOneMem = p002_d001Service.countOneMem(one_id);//참가인원확인
		System.out.println("참가자수"+countOneMem);
		String check = "ok";
		if(countOneMem > 1) { //참가자가 있을 경우
			System.out.println("참가자있음");
			return check;
		}else { //참가자가 없는 경우
			System.out.println("참가자없음");
			check = "empty";
			return check;
		}
	}
	//&분의일 수정하기 페이지이동
	@Override
	@RequestMapping(value="/and*/modifyAndOnePage.do")
	public ModelAndView modifyAndOnePage(@RequestParam Map<String, Object> modifyMap) {
		String g_id = (String) modifyMap.get("g_id");
		List<AndP001AndOneVO> ctg = p001_d001Service.searchCtg(g_id);//카테고리
		AndP001AndOneVO vo = p001_d001Service.andOneDetail(modifyMap);//글상세조회
		ModelAndView mav = new ModelAndView("modifyAndOne");
		mav.addObject("andOneEdit",vo);
		mav.addObject("g_id",g_id);//구분
		mav.addObject("ctg",ctg);//카테고리
		return mav;
	}
	//&분의일 수정하기 클릭시 실행
	@Override
	@RequestMapping(value="/and*/modifyAndOne.do")
	public String modifyAndOne(@RequestParam Map<String, Object> modifyMap, HttpServletRequest request) {
		System.out.println(">>>>>>"+modifyMap.get("one_locate_Lat"));
		System.out.println(">>>>>>"+modifyMap.get("one_locate_Lng"));
		System.out.println(">>>>>>"+modifyMap.get("one_memberMax"));
		System.out.println(">>>>>>"+modifyMap.get("one_category"));
		String g_id = (String) modifyMap.get("one_type");
		System.out.println(g_id);
		String one_addr = (String) modifyMap.get("one_addr");
		System.out.println("한글주소:"+one_addr);
		
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_ID :"+m_id); //회원아이디 가져오기
		modifyMap.put("m_id", m_id);//m_id 추가
		
		p002_d001Service.insertAndOne(modifyMap); //글 수정
		System.out.println(">>>>>>>>>>>>>>>>글수정 성공<<<<<<<<<<<<<<<<<<<<<<<<<<");
	
		return "redirect:/and?g_id="+g_id;
	}
	//엔분의일 완료
	@Override
	@ResponseBody
	@RequestMapping(value="/and*/completeAndOne.do")
	public void completeAndOne(@RequestParam("one_id") String one_id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		System.out.println("M_ID :"+m_id); //회원아이디 가져오기
		
		Map<String, Object> completeMap = new HashMap<String, Object>();
		completeMap.put("m_id", m_id);
		completeMap.put("one_id", one_id);
		
		p002_d001Service.completeAndOne(completeMap);//완료 후 om_state변경
		int andOneCnt = p002_d002Service.andOneCnt(one_id); //글작성시 선택한 참가자 수
		Map<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("one_id", one_id);
		cntMap.put("flag", "complete");
		int oneMemCnt = p002_d002Service.oneMemCnt(cntMap); //완료(30)상태 참가자수
		
		if(andOneCnt == oneMemCnt) {
			Map<String, Object> updateMap = new HashMap<String, Object>();
			updateMap.put("one_id", one_id);
			updateMap.put("flag", "complete");
			p002_d002Service.updateOneState(updateMap);
		}
	}
}
