package project.member.p003.service;

import java.util.List;
import java.util.Map;

import project.member.p003.vo.MemberP003VO;

public interface MemberP003_d001Service {
	// 입력,수정
	public int saveReport(MemberP003VO param);
	// 삭제
	public int deleteReport(String r_id);
	// 마이페이지 - 신고내역 목록 조회
	public List<MemberP003VO> selectReportListById(Map<String, String> param);
	// 마이페이지 - 신고내역 카운트
	public int selectReportListByIdCnt(String m_id);
	// 어드민 - 신고내역 상세 조회
	public MemberP003VO selectReportDetailByRID(String r_id);
	// 어드민 - 상태변경 + 답글저장
	public int saveReportState(Map<String, String> param);
	// 어드민 - 리스트 조회
	public List<MemberP003VO> selectAllReportList(Map<String, String> param);
	// 어드민 - 카운트
	public int selectAllReportListCnt(Map<String, String> param);
}
