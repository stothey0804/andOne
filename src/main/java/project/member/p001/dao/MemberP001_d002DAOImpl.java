package project.member.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p001.vo.MemberP001_MemberVO;

@Repository
public class MemberP001_d002DAOImpl implements MemberP001_d002DAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberP001_MemberVO selectMemberByEmail(String email) {
		MemberP001_MemberVO member = sqlSession.selectOne("member.p001.selectMemberByEmail", email);
		return member;
	}

}
