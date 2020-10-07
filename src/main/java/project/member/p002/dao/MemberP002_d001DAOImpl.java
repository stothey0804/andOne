package project.member.p002.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p002.vo.MemberP002VO;

@Repository
public class MemberP002_d001DAOImpl implements MemberP002_d001DAO{
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertQnA(MemberP002VO vo) {
		return sqlSession.insert("member.p002.insertQnA", vo);
	}

	@Override
	public List<MemberP002VO> searchQnAListbyMemberID(String m_id) {
		return sqlSession.selectList("member.p002.selectQnAListById", m_id);
	}

}
