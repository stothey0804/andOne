package project.root.p001.service;

import java.util.List;
import java.util.Map;


public interface RootP001_d001Service {
	public int updateMemberLocate(Map<String, String> map);
	public Map<String, String> selectMemberLocate(String m_id);
	public Map<String, String> selectTodayAdminMain();	// 당일 새 글 조회 영역
	public List<Map<String, String>> selectWeeklyNewMember();	// 7일간 가입자
	public List<Map<String, String>> selectWeeklySales();	// 7일간 가입자
	public void updatePopularHashtag(String ph_content); // 인기 해시태그 업데이트 쿼리
	public List<String> getAllHashtagList(); // 인기 해시태그 계산을 위해 모든 해시태그 불러오는 쿼리
	public String getPopularHashtag(); // 인기 해시태그 불러오는 쿼리
	public void popularHashtagUpdate(); // 인기 해시태그 계산 및 업데이트 메소드
}
