package project.member.p002.dao;


import java.util.List;
import java.util.Map;

import project.member.p002.vo.MemberP002VO;

public interface MemberP002_d001DAO {
	public int insertQnA(MemberP002VO vo);	// 문의사항 작성
	public List<MemberP002VO> searchQnAListbyMemberID(Map<String, String> param); // 회원별 문의사항 조회
	// 수정, 삭제
	public int saveQnA(MemberP002VO vo);
	public int deleteQnA(String q_id);
	public int selectQnAListCnt(String m_id);	// 카운트 조회
}
