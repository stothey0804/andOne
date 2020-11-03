package project.root.p004.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RootP004_d001DAOImpl implements RootP004_d001DAO{

	@Autowired
	SqlSession sqlSession;

	@Override
	public Map<String, String> selectMemberGenderChart() {
		return sqlSession.selectOne("root.p004.selectMemberGenderChart");
	}

	@Override
	public Map<String, String> selectMemberAgeChart() {
		return sqlSession.selectOne("root.p004.selectMemberAgeChart");
	}

	@Override
	public List<Map<String, String>> selectAndOneChart(Map<String, String> map) {
		return sqlSession.selectList("root.p004.selectAndOneChart", map);
	}

	@Override
	public List<Map<String, String>> selectTotalAndOneTypeChart() {
		return sqlSession.selectList("root.p004.selectTotalAndOneTypeChart");
	}

	@Override
	public List<Map<String, String>> selectCategoryAndOne(String one_type) {
		return sqlSession.selectList("root.p004.selectCategoryAndOne", one_type);
	}
	
	
}
