package project.root.p004.dao;

import java.util.List;
import java.util.Map;

public interface RootP004_d001DAO {
	public Map<String, String> selectMemberGenderChart();	// 성별별 회원수 조회
	public Map<String, String> selectMemberAgeChart();	// 성별별 회원수 조회
	public List<Map<String, String>> selectAndOneChart(Map<String, String> map);	// 조건별 엔분의일 사용내역 조회
	public List<Map<String, String>> selectTotalAndOneTypeChart();	// 전체 엔분의일 점유율 조회
	public List<Map<String, String>> selectCategoryAndOne(String one_type);	// 카테고리 점유율 조회
}
