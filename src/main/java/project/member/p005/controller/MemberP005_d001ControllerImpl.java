package project.member.p005.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.http.HttpResponse;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import common.service.CommonService;
import project.member.p005.service.MemberP005_d001Service;
import project.member.p005.vo.MemberP005VO;

/*
 * @Title	알림
 * @Author 	김세영
 * @Date	2020.10.21
 * 
 * */

@Controller
public class MemberP005_d001ControllerImpl implements MemberP005_d001Controller{
	
	@Autowired
	MemberP005_d001Service memberP005_d001Service;
	
	@Autowired
	CommonService commonService;	// 날짜변환
	
	// 알림조회 (전체)
	@Override
	@RequestMapping("/member/notify.do")
	public ModelAndView notifyInit(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("MemberP005_d001_init", request));
		String m_id = (String) request.getSession(false).getAttribute("m_id");
		// 세션에 m_id가 존재할 때 
		if(m_id != null && !"".equals(m_id)){
			// 새로운 알람 조회
			List<MemberP005VO> newList = memberP005_d001Service.searchNewNotifyList(m_id);
			for(MemberP005VO vo : newList) {	// 날짜 포맷 변경
				vo.setN_time(Common.formatTimeString(vo.getN_time(), commonService));
			}
			// 이전 알람 조회
//			Map<String, String> searchParam = new HashMap<String, String>();
			// 정보 전달
//			mav.addObject("pagination", pagination);
			mav.addObject("newList", newList);
//			mav.addObject("oldList", oldList);
			mav.addObject("oldListCnt", memberP005_d001Service.selectOldNotifyCnt(m_id));
		}
		return mav;
	}
	
	// 더보기 요청
	@Override
	@RequestMapping(value = "/member/searchMoreNotify.do", produces = "application/text;charset=UTF-8", method=RequestMethod.POST)
	@ResponseBody
	public String searchMoreNotify(@RequestParam Map<String,String> param) throws Exception {
		Map<String, String> searchParam = new HashMap<String, String>();	// search 파라미터 생성
		searchParam.put("startIndex", param.get("startIndex"));	
		searchParam.put("endIndex", param.get("endIndex"));
		searchParam.put("m_id", param.get("m_id"));
		// startIndex ~ endIndex 범위에 해당하는 list 조회 
		List<MemberP005VO> addList = memberP005_d001Service.searchOldNotifyList(searchParam);
		for(MemberP005VO vo : addList) {	// 날짜 포맷 변경
			vo.setN_time(Common.formatTimeString(vo.getN_time(), commonService));
		}
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(addList);
		return jsonStr;
	}
	
	// 읽음상태 변경 
	@Override
	@RequestMapping("/member/readNotify.do")
	@ResponseBody
	public void readNotify(@RequestParam String n_id, HttpServletRequest request) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("n_id", n_id);
		param.put("m_id", (String)request.getSession(false).getAttribute("m_id"));
		memberP005_d001Service.updateNotifyChecked(param);
	}
	
	// 새 알림 조회
	@Override
	@RequestMapping("member/selectNewNoticeCnt.do")
	@ResponseBody
	public String selectNewNoticeCnt(@RequestParam String m_id) {
		return memberP005_d001Service.selectNewNotifyCnt(m_id)+"";
	}
	
	// notify DB저장
	@Override
	@RequestMapping("member/saveNotify.do")
	@ResponseBody
	public void saveNotify(@RequestParam Map<String,String> param) throws Exception {
		MemberP005VO vo = new MemberP005VO();
		vo.setN_target(param.get("target"));
		vo.setN_content(param.get("content"));
		vo.setN_type(param.get("type"));
		vo.setN_url(param.get("url"));
		memberP005_d001Service.insertNotify(vo);
	}
	
		
}
