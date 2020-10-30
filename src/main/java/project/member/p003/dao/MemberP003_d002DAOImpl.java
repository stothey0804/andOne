package project.member.p003.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p003.vo.MemberP003VO;

@Repository
public class MemberP003_d002DAOImpl implements MemberP003_d002DAO{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public MemberP003VO selectReportDetailByRID(String r_id) {
		return sqlSession.selectOne("member.p003.selectReportDetailByRID", r_id);
	}

	@Override
	public int saveReportState(Map<String, String> param) {
		return sqlSession.update("member.p003.saveReportState", param);
	}

	@Override
	public List<MemberP003VO> selectAllReportList(Map<String, String> param) {
		return sqlSession.selectList("member.p003.selectAllReportList", param);
	}

	@Override
	public int selectAllReportListCnt(Map<String, String> param) {
		return sqlSession.selectOne("member.p003.selectAllReportListCnt", param);
	}
}
