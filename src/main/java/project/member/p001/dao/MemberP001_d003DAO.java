package project.member.p001.dao;

import java.util.Map;

public interface MemberP001_d003DAO {
	public String selectPwdById(String id);	// 회원 비밀번호 조회
	public Map<String, String> searchIdPwdByEmail(String email);
	public int updateMemberPwd(Map<String, String> member); // 비밀번호 업데이트
}
