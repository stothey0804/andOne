package project.member.p002.dao;


import java.util.List;
import java.util.Map;

import project.member.p002.vo.MemberP002VO;

public interface MemberP002_d002DAO {
	public List<MemberP002VO> searchNewQnAList(Map<String, String> param);	// 신규 문의사항 조회
	public List<MemberP002VO> searchAllQnAList(Map<String, String> param);	// 전체 문의사항 조회
	public MemberP002VO searchQnADetail(String q_id);	// qna 글 조회
	public int saveQnAState(Map<String, String> param);	// qna 상태변경
	public int saveReplyQnA(Map<String, String> param);	// qna 답변작성
	public String searchReplyQnA(String q_id);
	// 페이징을 위한 글목록 수 count
	public int selectAllQnAListCnt(Map<String, String> param);
	public int selectNewQnAListCnt(Map<String, String> param);
}
