package common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDAO;

@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	CommonDAO commonDAO;

	@Override
	public List<HashMap<String, String>> searchCommonCodeList(String g_id) {
		return commonDAO.searchCommonCodeList(g_id);
	}

	@Override
	public String selectCommonCodeName(Map<String, String> param) {
		return commonDAO.selectCommonCodeName(param);
	}

	@Override
	public int selectCompareTime(String regTime) {
		return commonDAO.selectCompareTime(regTime);
	}

	@Override
	public String selectCommonGroupName(String g_id) {
		return commonDAO.selectCommonGroupName(g_id);
	}

	@Override
	public String selectClubName(String c_id) {
		return commonDAO.selectClubName(c_id);
	}

	@Override
	public String selectClubManager(String param) {
		return commonDAO.selectClubManager(param);
	}

}
