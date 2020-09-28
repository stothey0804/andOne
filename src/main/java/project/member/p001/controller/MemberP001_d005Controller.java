package project.member.p001.controller;

import javax.servlet.http.HttpServletRequest;

import project.member.p001.vo.MemberP001_MemberVO;

public interface MemberP001_d005Controller {
	public String searchMypageMain(HttpServletRequest request);	// 마이페이지 메인
	public String updateMemberInfo(HttpServletRequest request); 	// updateMember.do
	public String saveMemberInfo(MemberP001_MemberVO member, HttpServletRequest request);	// saveMember.do
}
