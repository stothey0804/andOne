package project.member.p001.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Pagination;
import project.member.p001.service.MemberP001_d006Service;
import project.member.p001.vo.MemberP001_d006VO;


@Controller
public class MemberP001_d006ControllerImpl implements MemberP001_d006Controller{
	@Autowired
	MemberP001_d006Service memberP001_d006Service;
	
	@Autowired
	MemberP001_d006VO memberP001_d006VO;
	
//	@Override
//	@RequestMapping(value="/detail.do",method= {RequestMethod.GET,RequestMethod.POST})
//	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception{
//		ModelAndView mav = new ModelAndView("project/p001_d002/list");
//		return mav;
//	}
	
	@Override
	@RequestMapping(value="/popup.do", method= {RequestMethod.GET})
	@ResponseBody
	public MemberP001_d006VO memberDetail(@RequestParam(value="m_id",required=true) String m_id,Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(m_id);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("m_id",m_id);
		MemberP001_d006VO vo = memberP001_d006Service.detailMember(searchMap);
		return vo;
	}
	
	@Override
	@RequestMapping("/admin/searchMemberList.do")
	public String searchMemberList(@RequestParam(defaultValue = "1") int curPage, @RequestParam Map<String, String> param, Model model) {
		System.out.println("===>회원목록 조회 " + param );
		if(param.get("searchCondition") == null) {
			param.put("searchCondition","EMAIL");
		}
		if(param.get("searchKeyword") == null) {
			param.put("searchKeyword","");
		}
		
		int listCnt = memberP001_d006Service.selectMemberCnt(param);
		Pagination pagination = new Pagination(listCnt, curPage);	
//		if(vo.getSearchCondition() == null) {
//			vo.setSearchCondition("EMAIL");
//		}
//		if(vo.getSearchKeyword() == null) {
//			vo.setSearchKeyword("");
//		}
		
		param.put("startIndex", (pagination.getStartIndex()+1)+"");	// 시작 index는 1부터 이므로 1을 더해줌.
		param.put("endIndex", (pagination.getStartIndex()+pagination.getPageSize())+"");	// 끝 index

		model.addAttribute("pagination", pagination);
		model.addAttribute("memberList",memberP001_d006Service.getMemberList(param));
		return "p001_d006_search";
	}
	
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap(){
		Map<String, String> conditionMap = new HashMap<>();
		conditionMap.put("이메일", "EMAIL");
		conditionMap.put("닉네임", "NICKNAME");
		return conditionMap;
	}
	
}
