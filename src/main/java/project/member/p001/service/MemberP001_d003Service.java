package project.member.p001.service;

import java.util.Map;

public interface MemberP001_d003Service {
	public void sendMail(String to, String subject, String body);
	public String selectPwdById(String id);	// 회원 비밀번호 조회
	public Map<String, String> searchIdPwdByEmail(String email);
	public int updateMemberPwd(Map<String, String> member);
}
