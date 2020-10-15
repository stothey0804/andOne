package project.member.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.member.p001.vo.MemberP001_d006VO;

@Repository
public class MemberP001_d006DAOImpl implements MemberP001_d006DAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberP001_d006VO detailMember(Map<String, Object> searchMap) throws DataAccessException {
		MemberP001_d006VO p001_d002VO = sqlSession.selectOne("member.p001.detailMember",searchMap);
		if(sqlSession.selectList("member.p001.getPointList",searchMap) != null) {
			p001_d002VO.setList(sqlSession.selectList("member.p001.getPointList",searchMap));
		} else {
			p001_d002VO.setList(null);
		}
		return p001_d002VO;
	}

	@Override
	public List<MemberP001_d006VO> getMemberList(Map<String, String> param) {
		return sqlSession.selectList("member.p001.getMemberList", param);
	}

	@Override
	public int selectMemberCnt(Map<String, String> param) {
		return sqlSession.selectOne("member.p001.selectMemberCnt",param);
	}

}
