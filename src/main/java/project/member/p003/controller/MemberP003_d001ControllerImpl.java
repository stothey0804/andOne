package project.member.p003.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import common.Pagination;
import common.service.CommonService;
import project.member.p003.service.MemberP003_d001Service;
import project.member.p003.service.MemberP003_d002Service;
import project.member.p003.vo.MemberP003VO;

/*
 * @Title	신고하기
 * @Author	김세영
 * @Date	2020.10.27.
 * 
 * */

@Controller
@RequestMapping("/member")
public class MemberP003_d001ControllerImpl implements MemberP003_d001Controller{
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	MemberP003_d001Service memberP003_d001Service;
	
	@Autowired
	MemberP003_d002Service memberP003_d002Servcie;
	
	// 회원신고
	@RequestMapping("/reportInit.do")
	public ModelAndView reportInit(@RequestParam Map<String, String> param) {
		ModelAndView mav = new ModelAndView("member/p003_d001_insert_popup");
		if(param.get("r_id")!=null) {	// 수정시
			String r_id = param.get("r_id");
			MemberP003VO vo = memberP003_d002Servcie.selectReportDetailByRID(r_id);
			mav.addObject("article", vo);
			mav.addObject("r_target", vo.getR_target());
			mav.addObject("flag", vo.getR_category_id());
			// 신고건유형 조회
			List<HashMap<String, String>> rTypeList = commonService.searchCommonCodeList(vo.getR_category_id());	// 그룹ID별 조회
			mav.addObject("rTypeList", rTypeList);
		}else {	// 신규작성
			String sendFlag = "";
			String sendTarget = "";
			if("member".equals(param.get("flag"))) {
				sendFlag = "013";
			}else if("club".equals(param.get("flag"))) { 
				sendFlag = "014";
			}else if("one".equals(param.get("flag"))) {	// 엔분의일 경우
				sendFlag = "015";
				sendTarget = param.get("target") + "&g_id=" + param.get("type");
			}
			// 신고건유형 조회
			List<HashMap<String, String>> rTypeList = commonService.searchCommonCodeList(sendFlag);	// 그룹ID별 조회
			mav.addObject("r_target", sendTarget);
			mav.addObject("flag", sendFlag);
			mav.addObject("rTypeList", rTypeList);
		}
		return mav;
	}
	
	// 신고 전송
	@RequestMapping(value="/saveReport.do", method=RequestMethod.POST)
	public String saveReport(@ModelAttribute MemberP003VO param, @RequestParam(required = false) String modify) {
		System.out.println("modify==========>" + modify);
		if(modify==null && "013".equals(param.getR_category())){
			// 유저
			String tmp = "<a href='/andOne/member/searchMemberInfoPopup.do?m_id=" + param.getR_target() + "' onclick=\"window.open(this.href,'_blank','resizable=no,top=0,left=0,width=450,height=500');return false;\">상세보기</a>";
			param.setR_target(tmp);
		}else if(modify==null && "014".equals(param.getR_category())) {
			// 클럽
			String tmp = "<a href='/andOne/club/detailClub.do?c_id=" + param.getR_target() + "' target='_blank'>상세보기</a>";
			param.setR_target(tmp);
		}else if(modify==null && "015".equals(param.getR_category())) {
			// &분의일
			String tmp = "<a href='/andOne/and/detailAndOne.do?one_id=" + param.getR_target() + "' target='_blank'>상세보기</a>";
			param.setR_target(tmp);
		}
		try {
			memberP003_d001Service.saveReport(param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/p003_d001_insert_success";
	}
	
	// 내가 쓴 신고 조회
	@RequestMapping("/searchReport.do")
	public ModelAndView searchReport(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(Common.checkLoginDestinationView("MemberP003_d001_search", request));
		// 세션에서 id 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		int listCnt = memberP003_d001Service.selectReportListByIdCnt(m_id);
		Pagination pagination = new Pagination(listCnt, curPage);
		
		// 파라미터 생성
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex",(pagination.getStartIndex()+1)+"");
		searchParam.put("endIndex",(pagination.getStartIndex()+pagination.getPageSize())+"");
		searchParam.put("m_id", m_id);
		
		List<MemberP003VO> list = memberP003_d001Service.selectReportListById(searchParam);
		mav.addObject("pagination", pagination);	//페이지네이션
		mav.addObject("articleList",list);
		return mav;
	} 
	
	// 신고 삭제
	@RequestMapping("/deleteReport.do")
	public String deleteReport(@RequestParam String r_id, HttpServletRequest request) {
		memberP003_d001Service.deleteReport(r_id);
		return "redirect:"+ request.getHeader("Referer");
	}
}
