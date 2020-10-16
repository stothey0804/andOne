package project.and.p002.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.and.p001.service.AndP001_d001Service;
import project.and.p002.service.AndP002_d001Service;
import project.and.vo.AndP001AndOneVO;

@Controller
public class AndP002_d001ControllerImpl implements AndP002_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	@Autowired
	private AndP002_d001Service p002_d001Service;
	
	//글쓰기로 이동
	@Override
	@RequestMapping(value="/and*/insertAndOnePage.do")
	public ModelAndView insertAndOnePage(HttpServletRequest request) {
		String g_id = request.getParameter("g_id");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+g_id);
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리설정
		
		ModelAndView mav = new ModelAndView("insertAndOnePage");
		mav.addObject("g_id",g_id);
		mav.addObject("ctg_eat",ctg_eat);
		return mav;
	}
	//글쓰기 내용 DB저장
	@Override
	@RequestMapping(value="/and*/insertAndOne.do")
	public String insertAndOne(@RequestParam Map<String,Object> Andone) {
		System.out.println(">>>>>>"+Andone.get("one_locate_Lat"));
		System.out.println(">>>>>>"+Andone.get("one_locate_Lng"));
		String g_id = (String) Andone.get("one_type");
		System.out.println(g_id);
		p002_d001Service.insertAndOne(Andone); //글쓰기
		
		return "redirect:/and?g_id="+g_id;
	}
	
	

}
