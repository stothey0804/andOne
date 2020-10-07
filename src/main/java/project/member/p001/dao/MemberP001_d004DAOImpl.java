package project.member.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberP001_d004DAOImpl implements MemberP001_d004DAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int deleteMember(String id) {
		int result = sqlSession.delete("member.p001.deleteMember", id);
		return result;
	}

}
