package club.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import club.p001.vo.P001_d001VO;
@Repository("club")
public class P001_d001DAOImpl implements P001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<P001_d001VO> clubList() throws DataAccessException {
		List<P001_d001VO> clubList = sqlSession.selectList("club.p001_d001.clubList");
		return clubList;
	}
	@Override
	public List<P001_d001VO> myClubList() {
		List<P001_d001VO> myClubList = sqlSession.selectList("club.p001_d001.myClubList");
		return myClubList;
	}
	@Override
	public List<P001_d001VO> searchClubList(Map<String, Object> searchMap){
		List<P001_d001VO> searchClubList = sqlSession.selectList("club.p001_d001.searchClubList",searchMap);
		return searchClubList;
	}
	@Override
	public P001_d001VO detailClub(Map<String, Object> searchMap) throws DataAccessException{
		P001_d001VO vo = sqlSession.selectOne("club.p001_d001.detailClub",searchMap);
		return vo;
	}
}
