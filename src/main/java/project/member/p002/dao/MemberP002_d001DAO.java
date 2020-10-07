package project.member.p002.dao;


import java.util.List;

import project.member.p002.vo.MemberP002VO;

public interface MemberP002_d001DAO {
	public int insertQnA(MemberP002VO vo);	// 문의사항 작성
	public List<MemberP002VO> searchQnAListbyMemberID(String m_id);	// 회원별 문의사항 조회
}
