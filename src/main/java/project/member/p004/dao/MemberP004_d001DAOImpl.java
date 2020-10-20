package project.member.p004.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p004.vo.MemberP004VO;

@Repository
public class MemberP004_d001DAOImpl implements MemberP004_d001DAO{

	@Autowired SqlSession sqlSession;

	@Override
	public Map<String, String> searchMemberInfo(String m_id) {
		return sqlSession.selectOne("member.p004.searchMemberInfo", m_id);
	}

	@Override
	public int insertMemberReview(Map<String, String> param) {
		return sqlSession.insert("member.p004.insertMemberReview", param);
	}

	@Override
	public String selectMemberScore(String m_id) {
		return sqlSession.selectOne("member.p004.selectMemberScore", m_id);
	}

	@Override
	public int updateMemberScore(String m_id) {
		return sqlSession.update("member.p004.updateMemberScore", m_id);
	}

	@Override
	public List<MemberP004VO> searchReceivedMemberReview(Map<String, String> param) {
		return sqlSession.selectList("member.p004.searchReceivedMemberReview", param);
	}

	@Override
	public List<MemberP004VO> searchWroteMemberReview(Map<String, String> param) {
		return sqlSession.selectList("member.p004.searchWroteMemberReview", param);
	}
	
	
}
