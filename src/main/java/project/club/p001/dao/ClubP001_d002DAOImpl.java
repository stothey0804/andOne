package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.club.vo.ClubVO;

@Repository
public class ClubP001_d002DAOImpl implements ClubP001_d002DAO{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ClubVO> clubList(Map<String, Object> searchMap) {
		List<ClubVO> clubList = sqlSession.selectList("club.p001.allClubList",searchMap);
		return clubList;
	}

	@Override
	public int clubCnt() {
		return sqlSession.selectOne("club.p001.allClubCnt");
	}
} 