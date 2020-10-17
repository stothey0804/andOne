package project.member.p004.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberP004_d001DAOImpl implements MemberP004_d001DAO{

	@Autowired SqlSession sqlSession;

	@Override
	public Map<String, String> searchMemberInfo(String m_id) {
		return sqlSession.selectOne("member.p004.searchMemberInfo", m_id);
	}
	
	
}
