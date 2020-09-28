package project.member.p001.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p001.vo.MemberP001_MemberVO;

@Repository
public class MemberP001_d001DAOImpl implements MemberP001_d001DAO{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public String searchOverlapEmail(String email) {
		String result = sqlSession.selectOne("member.p001.selectOverlapEmail", email);
		return result;
	}

	@Override
	public String searchOverlapPhone(String phone) {
		String result = sqlSession.selectOne("member.p001.selectOverlapPhone", phone);
		return result;
	}

	@Override
	public MemberP001_MemberVO selectMemberByEmail(String email) {
		MemberP001_MemberVO member = sqlSession.selectOne("member.p001.selectMemberByEmail", email);
		return member;
	}

	@Override
	public int addMember(MemberP001_MemberVO vo) {
		int result = sqlSession.insert("member.p001.insertMember", vo);
		return result;
	}
	
}
