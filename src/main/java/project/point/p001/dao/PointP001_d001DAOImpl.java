package project.point.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.point.p001.vo.PointP001VO;

@Repository
public class PointP001_d001DAOImpl implements PointP001_d001DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public String selectNowPointById(String m_id) {
		return sqlSession.selectOne("point.p001.selectNowPointById", m_id);
	}

	@Override
	public int selectPointDetailCntByMember(String m_id) {
		return sqlSession.selectOne("point.p001.selectPointDetailCntByMember", m_id);
	}

	@Override
	public List<PointP001VO>searchPointListByMember(Map<String, String> param) {
		return sqlSession.selectList("point.p001.searchPointListByMember", param);
	}
	
}
