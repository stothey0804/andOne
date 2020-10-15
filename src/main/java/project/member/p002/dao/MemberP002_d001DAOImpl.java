package project.member.p002.dao;

import java.util.List;
import java.util.Map;

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
	public int selectQnAListCnt(String m_id) {
		return sqlSession.selectOne("member.p002.selectQnAListCnt", m_id);
	}

	@Override
	public List<MemberP002VO> searchQnAListbyMemberID(Map<String, String> param) {
		return sqlSession.selectList("member.p002.selectQnAListById", param);
	}

	@Override
	public int saveQnA(MemberP002VO vo) {
		return sqlSession.update("member.p002.saveQnA", vo);
	}

	@Override
	public int deleteQnA(String q_id) {
		return sqlSession.delete("member.p002.deleteQnA", q_id);
	}

}
