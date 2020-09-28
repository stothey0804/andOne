package project.club.p001.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import project.club.p001.service.ClubP001_d001Service;
import project.club.p001.vo.ClubP001_d001VO;

@Controller
public class ClubP001_d002ControllerImpl implements ClubP001_d002Controller{
	@Autowired
	ClubP001_d001Service clubP001_d001Service;
	@Autowired
	ClubP001_d001VO p001_d001;
	@Override
	@RequestMapping(value="/createClub.do",method= {RequestMethod.GET})
	public ModelAndView createClub() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
		return mav;
	}
	

}
