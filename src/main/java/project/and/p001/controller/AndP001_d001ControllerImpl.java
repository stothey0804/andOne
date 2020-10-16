package project.and.p001.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;

import net.sf.json.JSONArray;
import project.and.p001.service.AndP001_d001Service;
import project.and.vo.AndP001AndOneVO;


@Controller
public class AndP001_d001ControllerImpl implements AndP001_d001Controller {
	@Autowired
	private AndP001_d001Service p001_d001Service;
	
	//&분의일 먹기 사기 하기 메인
	@Override
	@RequestMapping(value="/and*")
	public ModelAndView andOneMain(@RequestParam("g_id") String g_id, HttpSession session) throws Exception {
		System.out.println(">>>>>>>>>g_id: "+g_id);
		//최근 등록된 같이먹기 + 해쉬태그
		List<AndP001AndOneVO> recentAndOneList = p001_d001Service.recentAndOneList(g_id); //최근등록된 같이먹기
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리설정
		
		//회원 위치 가져오기
		String m_id = (String) session.getAttribute("m_id");
		System.out.println(m_id);
		Map<String, Object> memLocate = p001_d001Service.selectMemLocate(m_id);
		System.out.println(memLocate);
		
		//AndOne 글 위치 가져오기
		List<String> andOneLocate = p001_d001Service.selectAndOneLocate(g_id);
		System.out.println(andOneLocate.toString());
//		JSONArray jsonArray = new JSONArray();
		
		ModelAndView mav = new ModelAndView("andOneMain");
		mav.addObject("g_id",g_id);
		mav.addObject("ctg_eat",ctg_eat);
		mav.addObject("recentAndOneList", recentAndOneList);
		mav.addObject("andOneLocate",andOneLocate);
//		mav.addObject("AndOneLocate", JSONArray.fromObject(andOneLocate));
		mav.addObject("memLocate",memLocate);
		
		return mav;
	}
	
	//&분의 일 같이먹기 List
	//1.전체검색
	//2.카테고리검색
	//3.해쉬태그검색
	@Override
	@RequestMapping(value="/and*/searchAndOne.do")
	public ModelAndView searchAndOneList(@ModelAttribute AndP001AndOneVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//1.전체검색
		String one_category = vo.getOne_category();
		String g_id = vo.getG_id();
		String totalSearch = vo.getTotalSearch();
		System.out.println(">>>>>>>>>>one_category:" +one_category);
		System.out.println(">>>>>>>>>>g_id:" +g_id);
		
		List<AndP001AndOneVO> ctg_eat = p001_d001Service.searchCtg(g_id); //카테고리 설정
		List<AndP001AndOneVO> SearchAndOneList =null;
		
		if(totalSearch != null) {
			System.out.println(">>>>>>>>>>>>>>>전체검색 실행");
			SearchAndOneList = p001_d001Service.totalSearchList(vo);//전체 검색
		}else {
			System.out.println(">>>>>>>>>>>>>>>카테고리검색 실행");
			SearchAndOneList = p001_d001Service.ctgSearchList(vo);//카테고리별 검색
		}
		
		ModelAndView mav = new ModelAndView("andOneSearch");
		mav.addObject("SearchAndOneList", SearchAndOneList);
		mav.addObject("size",SearchAndOneList.size()); //검색 결과 건수
		mav.addObject("g_id",g_id);
		mav.addObject("ctg_eat",ctg_eat);
		
		return mav;
	}

	@Override
	public String selectMemLocate( HttpSession session) {
		//회원 위치 가져오기
				
		return null;
	}
	
}

