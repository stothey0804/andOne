package project.member.p003.dao;

import java.util.List;
import java.util.Map;

import project.member.p003.vo.MemberP003VO;

public interface MemberP003_d001DAO {
	// 입력,수정
	public int saveReport(MemberP003VO param);
	// 삭제
	public int deleteReport(String r_id);
	// 마이페이지 - 신고내역 목록 조회
	public List<MemberP003VO> selectReportListById(Map<String, String> param);
	// 마이페이지 - 신고내역 카운트
	public int selectReportListByIdCnt(String m_id);

}
