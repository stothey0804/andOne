package project.member.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p002.vo.MemberP002VO;

@Repository
public class MemberP002_d002DAOImpl implements MemberP002_d002DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MemberP002VO> searchNewQnAList(Map<String, String> param) {
		return sqlSession.selectList("member.p002.selectNewQnAList",param);
	}

	@Override
	public List<MemberP002VO> searchAllQnAList(Map<String, String> param) {
		return sqlSession.selectList("member.p002.selectAllQnAList",param);
	}

	@Override
	public MemberP002VO searchQnADetail(String q_id) {
		return sqlSession.selectOne("member.p002.selectQnADetailByQID", q_id);
	}

	@Override
	public int saveQnAState(Map<String, String> param) {
		return sqlSession.update("member.p002.saveQnAState", param);
	}

	@Override
	public int saveReplyQnA(Map<String, String> param) {
		return sqlSession.update("member.p002.saveReplyQnA", param);
	}

	@Override
	public String searchReplyQnA(String q_id) {
		return sqlSession.selectOne("member.p002.selectReplyQnA", q_id);
	}

	@Override
	public int selectAllQnAListCnt(Map<String, String> param) {
		return sqlSession.selectOne("member.p002.selectAllQnAListCnt", param);
	}

	@Override
	public int selectNewQnAListCnt(Map<String, String> param) {
		return sqlSession.selectOne("member.p002.selectNewQnAListCnt", param);
	}


}
