package project.and.p002.controller;

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
import project.and.vo.AndP001AndOneVO;

@Controller
public class AndP002_d001ControllerImpl implements AndP002_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service; //엔분의일 수정
	@Autowired
	private AndP002_d001Service p002_d001Service;
	
	//글쓰기로 이동
	@Override
	@RequestMapping(value="/and*/insertAndOnePage.do")
	public ModelAndView insertAndOnePage(HttpServletRequest request) {
		String g_id = request.getParameter("g_id");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+g_id);
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리설정
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(Common.checkLoginDestinationView("insertAndOnePage", request));
		mav.addObject("g_id",g_id);//구분
		mav.addObject("ctg_eat",ctg_eat);//카테고리
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
	public void deleteAndOne(@RequestParam ("one_id") String one_id) {
		p002_d001Service.deleteAndOne(one_id);
	}
	
	//&분의일 수정조건확인 후 수정페이지로 이동
	@Override
	@RequestMapping(value="/and*/modifyAndOnePage.do")
	public ModelAndView modifyAndOnePage(@RequestParam Map<String, Object> modifyMap) {
		System.out.println("확인!!!!!!!!!!");
		String one_id = (String) modifyMap.get("one_id");
		System.out.println("one_id:::::::::"+one_id);
		int countOneMem = p002_d001Service.countOneMem(one_id);//참가인원확인
		System.out.println("참가자수"+countOneMem);
		if(countOneMem > 1) { //참가자가 있을 경우
			System.out.println("참가자있음");
			ModelAndView mav = new ModelAndView("andOneDetail");
			mav.addObject("msg","참가자가 존재해 수정이 불가능합니다");
			return mav;
		}else { //참가자가 없는 경우
			System.out.println("참가자없음");
			List<AndP001AndOneVO> andOneEditList = p001_d001Service.andOneDetailList(modifyMap);
			ModelAndView mav = new ModelAndView("modifyAndOnePage");
			mav.addObject("andOneEditList",andOneEditList);
			//p002_d001Service.editAndOne(one_id);
			return mav;
		}
	}
	
	
	

}
