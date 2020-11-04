package project.and.p002.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import project.and.p002.service.AndP002_d002Service;
import project.and.vo.AndOneMemberVO;
import project.point.p001.service.PointP001_d001Service;
import project.point.p001.service.PointP001_d002Service;
import project.point.p001.vo.PointP001VO;

@Controller
@RequestMapping(value="/and*/*")
public class AndP002_d002ControllerImpl implements AndP002_d002Controller {
	@Autowired
	private AndP002_d002Service p002_d002Service;
	@Autowired
	private PointP001_d002Service pointP001_d002Service; // 포인트 사용
	@Autowired
	PointP001_d001Service pointP001_d001Service; // 포인트조회용
	
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
	//신청 수락(작성자)
	@Override
	@ResponseBody
	@RequestMapping(value="okOneMember.do") 
	public String okOneMember(@RequestParam Map<String, Object> okMap) {
		System.out.println("m_id"+okMap.get("m_id"));
		System.out.println("one"+okMap.get("one_id"));
		String one_id = (String) okMap.get("one_id");
		
		int andOneCnt = p002_d002Service.andOneCnt(one_id); //글작성시 선택한 참가자 수
		//글 인원수 가져오고 one_member 수 가져와서 같고 omstate 20 omleader 20 -> one_state 20(결제완료)로 변경
		Map<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("one_id", one_id);
		cntMap.put("flag", "pay");
		int oneMemCnt = p002_d002Service.oneMemCnt(cntMap); //신청 수락완료된 참가자 수(om_state 20->참여확정상태)
		String check = "success";
		
		if(andOneCnt == oneMemCnt) {//신청인원초과로 수락불가능
			check = "fail";
			return check;
		}else { // 수락가능
			p002_d002Service.okOneMember(okMap);//one_member 상태변경
			System.out.println("=============변경완료");
			oneMemCnt = p002_d002Service.oneMemCnt(cntMap);
			System.out.println("ㅠㅠㅠㅠㅠㅠㅠ글인원수:"+andOneCnt);
			System.out.println("ㅠㅠㅠㅠㅠㅠㅠ참가인원수:"+oneMemCnt);
			if(andOneCnt == oneMemCnt) {
				System.out.println("인원수 마감!!!!!!");
				Map<String, Object> updateMap = new HashMap<String, Object>();
				updateMap.put("one_id", one_id);
				updateMap.put("flag", "update");
				p002_d002Service.updateOneState(updateMap); //엔분의일 one_state 20(결제완료)로 변경
			}
			return check;
		}
	}
	//신청 거절(작성자)
	@Override
	@ResponseBody
	@RequestMapping(value="denyOneMember.do")
	public String denyOneMember(@RequestParam Map<String, Object> denyMap) {
		System.out.println("m_id"+denyMap.get("m_id"));
		System.out.println("one"+denyMap.get("one_id"));
		p002_d002Service.denyOneMember(denyMap);//one_member 상태변경(10->30)
		return "fail";
		
	}
	//신청 취소(참가자)
	@Override
	@ResponseBody
	@RequestMapping(value="cancelOneMember.do")
	public String cancelOneMember(@RequestParam Map<String, Object> cancelMap, HttpServletRequest request) {
		String one_id = (String) cancelMap.get("one_id");
		String one_price = (String) cancelMap.get("one_price");
		// Session 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		cancelMap.put("m_id", m_id);
		
		int CancelTime =p002_d002Service.CancelTime(one_id);
		System.out.println("시간계산:"+CancelTime);
		
		String cancelCheck = "true";
		
		if(CancelTime>=30) {  //취소가능
			p002_d002Service.cancelOneMember(cancelMap); ////one_member에서 지우기
			
			// Point VO 값 set
			PointP001VO pointVO = new PointP001VO();
			pointVO.setM_id(m_id);
			pointVO.setP_changepoint(one_price);
			pointVO.setP_detail("포인트 환불");
			String nowPoint = pointP001_d001Service.selectNowPointById(m_id);
			pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint); //포인트 null값 0으로 변경
			
			pointP001_d002Service.insertPoint(pointVO);//포인트 환불
			nowPoint = pointP001_d001Service.selectNowPointById(m_id); //환불 후 값 갱신
			
			int andOneCnt = p002_d002Service.andOneCnt(one_id); //글작성시 선택한 참가자 수
			Map<String, Object> cntMap = new HashMap<String, Object>();
			cntMap.put("one_id", one_id);
			cntMap.put("flag", "pay");
			int oneMemCnt = p002_d002Service.oneMemCnt(cntMap); //신청 수락완료된 참가자 수(om_state 20->참여확정상태)
			
			if(andOneCnt > oneMemCnt) { //취소후 참여확정 인원이 부족하면 모집중으로 변경
				Map<String, Object> updateMap = new HashMap<String, Object>();
				updateMap.put("one_id", one_id);
				updateMap.put("flag", "reupdate");
				p002_d002Service.updateOneState(updateMap); //엔분의일 one_state 10(모집중)로 변경
			}
			return cancelCheck;
		}else {  //취소불가능
			cancelCheck = "false";
			return cancelCheck;
		}
	
	}
	

}
