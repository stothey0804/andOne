package project.club.p002.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ClubP002_d001ControllerImpl implements ClubP002_d001Controller{
	@Override
	@RequestMapping(value="/createClubForm.do",method= {RequestMethod.GET})
	public ModelAndView createClubForm() throws Exception {
		ModelAndView mav = new ModelAndView("createClub");
		return mav;
	}
}
