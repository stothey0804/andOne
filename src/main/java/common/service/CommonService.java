package common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CommonService {
	public List<HashMap<String, String>> searchCommonCodeList(String g_id);
	public String selectCommonCodeName(Map<String, String> param);
}
