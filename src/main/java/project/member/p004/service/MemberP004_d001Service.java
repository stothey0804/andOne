package project.member.p004.service;

import java.util.List;
import java.util.Map;

import project.member.p004.vo.MemberP004VO;

public interface MemberP004_d001Service {
	public Map<String, String> searchMemberInfo(String m_id);
	public String selectMemberScore(String m_id);// 점수조회
	public int insertMemberReview(Map<String, String> param);	// 평가입력
	public int updateMemberScore(String m_id);// 평점 업데이트
	public List<MemberP004VO> searchReceivedMemberReview(Map<String, String> param); // 작성리뷰 조회
	public List<MemberP004VO> searchWroteMemberReview(Map<String, String> param); // 받은리뷰 조회
	public int selectMemberReviewCnt(Map<String, String> param);// 카운트
	public MemberP004VO searchReviewContent(String mr_id);	// 내용수정시 조회
	public int deleteMemberReview(String mr_id);	//삭제
}
