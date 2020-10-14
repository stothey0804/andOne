package project.point.p001.service;

import java.util.List;
import java.util.Map;

import project.point.p001.vo.PointP001VO;

public interface PointP001_d001Service {
	public String selectNowPointById(String m_id);	// 현재 포인트 조회
	public int selectPointDetailCntByMember(String m_id);	// 포인트 내역 카운트
	public List<PointP001VO> searchPointListByMember(Map<String, String> param); // 포인트 내역 리스트 조회
}
