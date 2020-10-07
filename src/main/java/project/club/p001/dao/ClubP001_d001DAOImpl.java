package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.club.vo.ClubP001_d001MemberVO;
import project.club.vo.ClubP001_d001VO;

@Repository
public class ClubP001_d001DAOImpl implements ClubP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<ClubP001_d001VO> clubList() throws DataAccessException {
		List<ClubP001_d001VO> clubList = sqlSession.selectList("club.p001.clubList");
		return clubList;
	}
	@Override
	public List<ClubP001_d001VO> myClubList(String m_id) {
		List<ClubP001_d001VO> myClubList = sqlSession.selectList("club.p001.myClubList",m_id);
		return myClubList;
	}
	@Override
	public List<ClubP001_d001VO> searchClubList(Map<String, Object> searchMap){
		List<ClubP001_d001VO> searchClubList = sqlSession.selectList("club.p001.searchClubList",searchMap);
		return searchClubList;
	}
	@Override
	public ClubP001_d001VO detailClub(Map<String, Object> searchMap) throws DataAccessException{
		ClubP001_d001VO vo = sqlSession.selectOne("club.p001.detailClub",searchMap);
		for(int i=0; i <vo.getArticleList().size();i++) {
			System.out.println("========="+vo.getArticleList().get(i).getImgList());
		}
		return vo;
	}
//	@Override
//	public List<Object> getByteImage(String c_id) {
//		return sqlSession.selectList("club.p001.getByteImage", c_id);
//	}
	@Override
	public String memberCheck(Map<String, Object> searchMap) {
		ClubP001_d001MemberVO vo = sqlSession.selectOne("club.p001.memberCheck",searchMap);
		String result="";
		if(vo == null) {
			result ="0";
		} else {
			result = vo.getCm_rank();
		}
		return result;
	}
}
