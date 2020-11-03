package project.root.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class RootP001_d001DAOImpl implements RootP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
		
	public int updateMemberLocate(Map<String, String> map) {
		int result = sqlSession.update("member.p001.updateMemberLocate", map);
		return result;
	}
	
	public Map<String, String> selectMemberLocate(String m_id) {
		Map<String, String> result = sqlSession.selectOne("member.p001.selectMemberLocate",m_id);
		return result;
	}

	@Override
	public Map<String, String> selectTodayAdminMain() {
		return sqlSession.selectOne("root.p001.selectTodayAdminMain");
	}

	@Override
	public List<Map<String, String>> selectWeeklyNewMember() {
		return sqlSession.selectList("root.p001.selectWeeklyNewMember");
	}

	@Override
	public List<Map<String, String>> selectWeeklySales() {
		return sqlSession.selectList("root.p001.selectWeeklySales");
	}

}
