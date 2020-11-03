package project.member.p001.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p001.vo.MemberP001_MemberVO;

@Repository
public class MemberP001_d005DAOImpl implements MemberP001_d005DAO{

	@Autowired
	SqlSession sqlSession;
	@Override
	public String selectPwdById(String id) {
		String result = sqlSession.selectOne("member.p001.selectPwdById", id);
		return result;
	}

	@Override
	public int updateMember(MemberP001_MemberVO vo) {
		int result = sqlSession.update("member.p001.updateMember", vo);
		return result;
	}

	
	@Override
	public void saveImage(Map<String, Object> hmap) {
		sqlSession.insert("member.p001.saveImage",hmap);
	}

	@Override
	public Map<String, Object> getByteImage(String m_id) {
		return sqlSession.selectOne("member.p001.getByteImage", m_id);
	}

	@Override
	public MemberP001_MemberVO selectMemberById(String id) {
		MemberP001_MemberVO member = sqlSession.selectOne("member.p001.selectMemberById", id);
		return member;
	}

	@Override
	public Map<String, String> seleteMyPageInfo(String m_id) {
		return sqlSession.selectOne("member.p001.seleteMyPageInfo", m_id);
	}
}
