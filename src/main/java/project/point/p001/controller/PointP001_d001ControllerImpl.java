package project.point.p001.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import project.point.p001.service.PointP001_d001Service;
import project.point.p001.vo.PointP001VO;

@Controller
@RequestMapping("/point")
public class PointP001_d001ControllerImpl implements PointP001_d001Controller{

	@Autowired
	PointP001_d001Service pointP001_d001Service;
	
	@Override
	@RequestMapping(value="/pointDetail.do")
	public ModelAndView pointDetailSearch(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("PointP001_d001_Search", request));
		// m_id 조회
		HttpSession session = request.getSession(false);
		String m_id = (String)session.getAttribute("m_id");
		// 카운트 조회
		int listCnt = pointP001_d001Service.selectPointDetailCntByMember(m_id);
		System.out.println("===========================>listCnt : " + listCnt);
		Pagination pagination = new Pagination(listCnt, curPage);
		// 조회 param 
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index
		searchParam.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index
		searchParam.put("m_id", m_id);
		// List 조회
		List<PointP001VO> list = pointP001_d001Service.searchPointListByMember(searchParam);
		mav.addObject("pointList", list);
		mav.addObject("pagination", pagination);	//페이지네이션
		return mav;
	}

}
