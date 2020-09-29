package project.and.p001.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import project.and.p001.service.AndP001_d001Service;
import project.and.p001.vo.AndP001_d001VO;


@Controller
public class AndP001_d001ControllerImpl implements AndP001_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	
	//&분의 일 같이먹기 검색화면
	@RequestMapping(value="/eat")
	public ModelAndView search_eat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("eatMain");
		return mav;
	}
	
	//&분의 일 같이먹기 List
	@RequestMapping(value="/eat/listAndOne.do")
	public ModelAndView searchList_eat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<AndP001_d001VO> searchList_eat = p001_d001Service.listAndOne_eat();
		ModelAndView mav = new ModelAndView("andone_eat");
		mav.addObject("searchList_eat",searchList_eat);
		return mav;
	}
	
	//&분의 일 같이하기 List
	@RequestMapping(value="/do/listAndOne.do")
	public ModelAndView searchList_do(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<AndP001_d001VO> searchList_do = p001_d001Service.listAndOne_do();
		ModelAndView mav = new ModelAndView("andone_do");
		mav.addObject("searchList_do",searchList_do);
		return mav;
	}
	//&분의 일 같이사기 List
	@RequestMapping(value="/buy/listAndOne.do")
	public ModelAndView searchList_buy(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<AndP001_d001VO> searchList_buy = p001_d001Service.listAndOne_buy();
		ModelAndView mav = new ModelAndView("andone_buy");
		mav.addObject("searchList_buy",searchList_buy);
		return mav;
	}
	
}

