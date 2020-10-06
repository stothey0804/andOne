package project.member.p001.service;
import java.util.Map;

import project.member.p001.vo.MemberP001_MemberVO;

public interface MemberP001_d005Service {
	public MemberP001_MemberVO selectMemberById(String id);	// 멤버조회
	public String selectPwdById(String id);	// 회원 비밀번호 조회
	public int updateMember(MemberP001_MemberVO vo);	// 회원정보변경
	public void saveImage(Map<String, Object> hmap);	// 프로필이미지 저장
	public Map<String, Object> getByteImage(String m_id);			// 프로필 이미지 get
}
