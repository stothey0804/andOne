package common;

import java.text.DecimalFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.service.CommonService;
import project.and.vo.AndOneMemberVO;
import project.club.vo.ClubMemberVO;
import project.member.p001.service.MemberP001_d005Service;

public class Common {
	
	// 로그인 체크 메서드, dest = 목적지 view
	public static String checkLoginDestinationView(String dest, HttpServletRequest request) {
		// 세션체크
		String returnView = "member/p001_d002";	// 로그인 페이지
		HttpSession session = request.getSession(false);
		// 세션 멤버정보, 로그인상태 체크
		if(session!=null) {
			if(session.getAttribute("m_id")!=null && session.getAttribute("isLogOn")!=null){
				returnView = dest;				// 목적지 view로
			}
		}
		return returnView;
	}
	// 관리자여부 체크 메서드, dest = 목적지 view
	public static String checkAdminDestinationView(String dest, HttpServletRequest request) {
		// 세션체크
		String returnView = "member/p001_d002";	// 로그인 페이지
		HttpSession session = request.getSession(false);
		// 세션 멤버정보, 로그인상태 체크
		if(session!=null) {
			if("00000001".equals(session.getAttribute("m_id")) && session.getAttribute("isLogOn")!=null){
				returnView = dest;				// 목적지 view로
			}else {
				returnView = "main";			// 일반회원일 경우 메인으로 
			}
		}
		return returnView;
	}
	
	// blob이미지 encode 메서드
	public static String encodeBlobImage(String m_id, MemberP001_d005Service memberP001_d005Service) {
		String result = "";
		Map<String, Object> map = memberP001_d005Service.getByteImage(m_id);
		if(map!=null) {
			byte[] encoded = Base64.getEncoder().encode((byte[])map.get("m_img"));
			result = new String(encoded);	// encodedString
		}
		return result;
	}
	
	// 천단위 컴마 찍기 
	 public static String toNumFormat(String num) {
		 DecimalFormat df = new DecimalFormat("#,###");
		 return df.format(Integer.parseInt(num));
	 }
	 
	 //ClubUserImg encoding method
	 public static void getEncodedUser(List<ClubMemberVO> list) {
		 byte[] encoded = null;
		 for(int i=0; i < list.size();i++) {
			 if(list.get(i).getUserImg() != null) {
				 encoded = Base64.getEncoder().encode(list.get(i).getUserImg());
				 list.get(i).setResultUserImg(new String(encoded));	
			 }
		 }
	 }
	 //AndOneUserImg encoding method
	 public static void getEncodedAndUser(List<AndOneMemberVO> andOneList) {
		 byte[] encoded = null;
		 for(int i=0; i < andOneList.size();i++) {
			 if(andOneList.get(i).getUserImg() != null) {
				 encoded = Base64.getEncoder().encode(andOneList.get(i).getUserImg());
				 andOneList.get(i).setResultUserImg(new String(encoded));
			 }
		 }
	 }
	 
	 private static class TIME_MAXIMUM {
			public static final int SEC = 60;
			public static final int MIN = 60;
			public static final int HOUR = 24;
			public static final int DAY = 30;
			public static final int MONTH = 12;
	 }

	public static String formatTimeString(String regTime, CommonService commonService) {
		// 비교시간
//			long regTime = 0;
		// 비교시간 생성 쿼리
		int diffTime = commonService.selectCompareTime(regTime);
		String msg = null;
		if (diffTime < TIME_MAXIMUM.SEC) {
			// sec
			msg = "방금 전";
		} else if ((diffTime /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) {
			// min
			msg = diffTime + "분 전";
		} else if ((diffTime /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) {
			// hour
			msg = (diffTime) + "시간 전";
		} else if ((diffTime /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) {
			// day
			msg = (diffTime) + "일 전";
		} else if ((diffTime /= TIME_MAXIMUM.DAY) < TIME_MAXIMUM.MONTH) {
			// day
			msg = (diffTime) + "달 전";
		} else {
			msg = (diffTime) + "년 전";
		}
		return msg;
	}



}
