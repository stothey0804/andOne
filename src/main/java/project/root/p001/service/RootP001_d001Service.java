package project.root.p001.service;

import java.util.List;
import java.util.Map;


public interface RootP001_d001Service {
	public int updateMemberLocate(Map<String, String> map);
	public Map<String, String> selectMemberLocate(String m_id);
	public Map<String, String> selectTodayAdminMain();	// 당일 새 글 조회 영역
	public List<Map<String, String>> selectWeeklyNewMember();	// 7일간 가입자
	public List<Map<String, String>> selectWeeklySales();	// 7일간 가입자
}
