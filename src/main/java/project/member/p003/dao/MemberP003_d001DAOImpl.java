package project.member.p003.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p003.vo.MemberP003VO;

@Repository
public class MemberP003_d001DAOImpl implements MemberP003_d001DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int saveReport(MemberP003VO param) {
		return sqlSession.insert("member.p003.saveReport", param);
	}

	@Override
	public int deleteReport(String r_id) {
		return sqlSession.delete("member.p003.deleteReport", r_id);
	}

	@Override
	public List<MemberP003VO> selectReportListById(Map<String, String> param) {
		return sqlSession.selectList("member.p003.selectReportListById", param);
	}

	@Override
	public int selectReportListByIdCnt(String m_id) {
		return sqlSession.selectOne("member.p003.selectReportListByIdCnt", m_id);
	}

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
