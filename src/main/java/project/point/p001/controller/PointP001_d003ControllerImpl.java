package project.point.p001.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import project.point.p001.service.PointP001_d001Service;
import project.point.p001.service.PointP001_d002Service;
import project.point.p001.service.PointP001_d003Service;
import project.point.p001.vo.PointP001VO;

@Controller
@RequestMapping("/point")
public class PointP001_d003ControllerImpl implements PointP001_d003Controller{
	@Autowired
	PointP001_d002Service pointP001_d002Service; // 포인트 사용
	@Autowired
	PointP001_d001Service pointP001_d001Service; // 포인트조회용
	@Autowired
	PointP001_d003Service pointP001_d003Service; // one_member 추가용
	
	//oneMember update+결제완료
	@Override
	@RequestMapping(value="pay.do")
	public ModelAndView pointPay(@RequestParam Map<String, Object> payMap , HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>확인");
		// Session 얻기
		HttpSession session = request.getSession(false);
		String m_id = (String) session.getAttribute("m_id");
		String m_nickname = (String) session.getAttribute("m_nickname");
		
		//맵확인용
		System.out.println("pay one_type:"+payMap.get("one_type")); 
		System.out.println("pay one_id:"+payMap.get("one_id"));
		payMap.put("m_id", m_id);
		pointP001_d003Service.addOneMember(payMap);//one_member 추가
		
		//사용포인트 -로 변경
		String payPoint = (String) payMap.get("payPoint");
		String minus = "-";
		String p_changepoint = minus.concat(payPoint);
		System.out.println(p_changepoint);
		// Point VO 값 set
		PointP001VO pointVO = new PointP001VO();
		pointVO.setM_id(m_id);
		pointVO.setP_changepoint(p_changepoint);
		pointVO.setP_detail("포인트 사용");
		String nowPoint = pointP001_d001Service.selectNowPointById(m_id);
		pointVO.setP_currentpoint(nowPoint==null? "0": nowPoint); //포인트 null값 0으로 변경
		
		pointP001_d002Service.insertPoint(pointVO);//포인트 사용
		nowPoint = pointP001_d001Service.selectNowPointById(m_id); // 사용 후 값 갱신
		
		ModelAndView mav = new ModelAndView("point/p003_success");
		mav.addObject("payPoint",payPoint);//사용한 포인트
		mav.addObject("nowPoint",nowPoint);//현재포인트
		mav.addObject("m_nickname",m_nickname);
		return mav;
	}
}
