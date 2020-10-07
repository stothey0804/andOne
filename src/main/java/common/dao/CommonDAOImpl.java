package common.dao;

import java.util.HashMap;
import java.util.List;

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
	
	
}
