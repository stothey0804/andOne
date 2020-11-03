package project.root.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.root.p002.vo.RootP002VO;

@Repository
public class RootP002_d001DAOImpl implements RootP002_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<RootP002VO> fullSearch(String searchKeyword) {
		return sqlSession.selectList("root.p002.fullSearch",searchKeyword);
	}

	@Override
	public List<Map<String, String>> getObject(Map<String, Object> searchParam) {
		return sqlSession.selectList("root.p002.getObject",searchParam);
	}

	@Override
	public List<Map<String, String>> getSearchCnt(String searchKeyword) {
		return sqlSession.selectList("root.p002.getSearchCnt",searchKeyword);
	}

	@Override
	public List<Map<String, String>> searchDetail(Map<String, String> searchParam) {
		return sqlSession.selectList("root.p002.searchDetail",searchParam);
	}

}
