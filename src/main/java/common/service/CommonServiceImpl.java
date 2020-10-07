package common.service;

import java.util.HashMap;
import java.util.List;

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

}