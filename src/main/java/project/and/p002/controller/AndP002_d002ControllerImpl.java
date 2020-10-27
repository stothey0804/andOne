package project.and.p002.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.and.p002.service.AndP002_d002Service;
import project.and.vo.AndOneMemberVO;

@Controller
@RequestMapping(value="/and*/*")
public class AndP002_d002ControllerImpl implements AndP002_d002Controller {

	@Autowired
	private AndP002_d002Service p002_d002Service;
	
	//엔분의일 참가신청수락OR거절
	@Override
	@RequestMapping(value="waitonemem.do")
	public ModelAndView AndOnewaitMemList(@RequestParam("one_id") String one_id) {
		List<AndOneMemberVO> AndOnewaitMemList = p002_d002Service.AndOnewaitMemList(one_id);
		Common.getEncodedAndUser(AndOnewaitMemList);
		
		ModelAndView mav = new ModelAndView("approveAndOne");
		mav.addObject("AndOnewaitMemList",AndOnewaitMemList);
		return mav;
	}

}
