package project.member.p001.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberP001_d003DAOImpl implements MemberP001_d003DAO{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Map<String, String> searchIdPwdByEmail(String email) {
		Map<String, String> result = new HashMap<String, String>();
		result = sqlSession.selectOne("member.p001.selectIdPwdByEmail",email);
		return result;
	}

	@Override
	public String selectPwdById(String id) {
		String result = sqlSession.selectOne("member.p001.selectPwdById",id);
		return result;
	}

	@Override
	public int updateMemberPwd(Map<String, String> member) {
		int result = sqlSession.update("member.p001.updateMemberPwd", member);
		return result;
	}

}
