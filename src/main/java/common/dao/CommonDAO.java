package common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CommonDAO {
	public int selectCompareTime(String regTime);	// 시간 비교
	public List<HashMap<String, String>> searchCommonCodeList(String g_id);
	public String selectCommonCodeName(Map<String, String> param);
	public String selectCommonGroupName(String g_id);
	public String selectClubName(String c_id);	// 소모임명 조회
	public String selectClubManager(String param); // 소모임장 아이디 조회
}
