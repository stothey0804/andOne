package project.member.p001.dao;

import project.member.p001.vo.MemberP001_MemberVO;

public interface MemberP001_d001DAO {
	public String searchOverlapEmail(String email);
	public String searchOverlapPhone(String phone);
	public MemberP001_MemberVO selectMemberByEmail(String email);
	public int addMember(MemberP001_MemberVO vo);
}
