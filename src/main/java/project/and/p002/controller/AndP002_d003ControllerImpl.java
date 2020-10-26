package project.and.p002.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Pagination;
import project.and.p002.service.AndP002_d003Service;
import project.and.vo.AndP001AndOneVO;
import project.and.vo.AndP002AndOneVO;

@Controller
@RequestMapping(value="/and*/*")
public class AndP002_d003ControllerImpl implements AndP002_d003Controller {
	@Autowired
	private AndP002_d003Service p002_d003Service;
	
	//내가 작성한 엔분의일
	@Override
	@RequestMapping(value="wroteAndOne.do")
	public ModelAndView searchWroteAndOne(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) {
		String flag = "write";
		// Session 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("m_id", m_id);
		searchMap.put("flag", flag);
		
		int listCnt = p002_d003Service.selectAndOneCnt(searchMap);
		System.out.println("카운트조회"+listCnt);//카운트조회
		Pagination pagination = new Pagination(listCnt, curPage);
		searchMap.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		searchMap.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index
		
		List<AndP002AndOneVO> searchAndOneList = p002_d003Service.searchWroteAndOneList(searchMap); //엔분의일 가져오기
	
		ModelAndView mav = new ModelAndView("MyAndOne");
		mav.addObject("searchAndOneList",searchAndOneList);
		mav.addObject("pagination",pagination);
		mav.addObject("flag",flag);
		return mav;
	}
	//참가한 엔분의일
	@Override
	@RequestMapping(value="participateAndOne.do")
	public ModelAndView searchParticipateAndOne(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) {
		String flag = "participate"; 
		// Session 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("m_id", m_id);
		searchMap.put("flag", flag);
		
		int listCnt = p002_d003Service.selectAndOneCnt(searchMap); //카운트조회
		Pagination pagination = new Pagination(listCnt, curPage);
		searchMap.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		searchMap.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index

		List<AndP002AndOneVO> searchAndOneList = p002_d003Service.selectParticiateAndOneList(searchMap); //엔분의일 가져오기
		
		
		ModelAndView mav = new ModelAndView("MyAndOne");
		mav.addObject("searchAndOneList",searchAndOneList);
		mav.addObject("pagination",pagination);
		mav.addObject("flag",flag);
		return mav;
	}
	
}
