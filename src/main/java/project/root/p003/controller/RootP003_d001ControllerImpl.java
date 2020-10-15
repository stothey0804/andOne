package project.root.p003.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import project.root.p003.service.RootP003_d001Service;
import project.root.p003.vo.RootP003VO;

/*
 * 공지사항 - main 및 admin
 * 작성자 - 김세영
 * 
 * */
@Controller
public class RootP003_d001ControllerImpl implements RootP003_d001Controller{

	@Autowired
	RootP003_d001Service rootP003_d001Service;

	// ADMIN 영역
	// 공지사항 수정, 작성 폼 연결
	@Override
	@RequestMapping(value="/admin/initNotice.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView initNoticeForm(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView(Common.checkAdminDestinationView("RootP003_d001_save", request));
		String n_id = request.getParameter("n_id");
		if(n_id!=null && !"".equals(n_id)) {
			// 내용 전달
			RootP003VO vo = rootP003_d001Service.searchNoticeById(n_id);
			mav.addObject("article", vo);
			mav.addObject("flag",1);	// 수정
		}else {
			mav.addObject("flag",0);	// 신규작성
		}
		return mav;
	}

	// 공지사항 작성
	@Override
	@RequestMapping(value="/admin/insertNotice.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String insertNotice(@RequestParam Map<String, String> param, HttpServletRequest request) throws Exception {
		RootP003VO vo = new RootP003VO(param.get("n_title"), param.get("n_content"));
		rootP003_d001Service.insertNotice(vo);
		return "redirect:/admin/searchNotice.do";
	}

	// 공지사항 수정
	@Override
	@RequestMapping(value="/admin/updateNotice.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateNotice(@RequestParam Map<String, String> param, HttpServletRequest request) throws Exception {
		RootP003VO vo = new RootP003VO(param.get("n_id"), param.get("n_title"), param.get("n_content"));
		rootP003_d001Service.updateNoticeById(vo);
		return "redirect:/admin/searchNotice.do";
	}

	// 공지사항 삭제
	@Override
	@RequestMapping(value="/admin/deleteNotice.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String deleteNotice(HttpServletRequest request) throws Exception {
		String n_id = request.getParameter("n_id");
		if(n_id != null) {
			rootP003_d001Service.deleteNoticeById(n_id);
		}
		return "redirect:/admin/searchNotice.do";
	}

	// 어드민 - 공지사항 조회
	@Override
	@RequestMapping(value="/admin/searchNotice.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView searchNotice(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) throws Exception {
		ModelAndView mav = setNoticeListObject(curPage);	// notice 리스트 생성
		mav.setViewName(Common.checkAdminDestinationView("RootP003_d001_search", request));
		return mav;
	}
	
	// 메인(회원) - 공지사항 조회
	@RequestMapping(value="/notice.do", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView notice(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) {
		ModelAndView mav = setNoticeListObject(curPage);	// notice 리스트 생성
		mav.setViewName("RootP003_d001_search_common");
		return mav;
	}
	
	// notice 리스트 생성 전달
	private ModelAndView setNoticeListObject(int curPage) {
		ModelAndView mav = new ModelAndView();
		// Pagination
		int listCnt = rootP003_d001Service.selectNoticeListCnt();	// 전체 게시글 수 조회
		Pagination pagination = new Pagination(listCnt, curPage);	// pagination 객체 생성
		// 조회용 Parameter 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		searchParam.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index
		// Notice List 조회
		List<RootP003VO> list = rootP003_d001Service.searchNoticeList(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList",list);			//글목록
		return mav;
	}
	
}
