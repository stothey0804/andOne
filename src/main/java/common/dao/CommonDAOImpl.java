package common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDAOImpl implements CommonDAO{

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> searchCommonCodeList(String g_id) {
		return sqlSession.selectList("common.selectCommonCodeNameList", g_id);
	}

	@Override
	public String selectCommonCodeName(Map<String, String> param) {
		return sqlSession.selectOne("common.selectCommonCodeName", param);
	}

	@Override
	public int selectCompareTime(String regTime) {
		return sqlSession.selectOne("common.selectCompareTime", regTime);
	}

	@Override
	public String selectCommonGroupName(String g_id) {
		return sqlSession.selectOne("common.selectCommonGroupName",g_id);
	}
	
	
}
