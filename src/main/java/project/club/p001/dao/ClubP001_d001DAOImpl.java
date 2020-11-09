package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.and.vo.AndP002AndOneVO;
import project.club.vo.ClubMemberVO;
import project.club.vo.ClubVO;

@Repository
public class ClubP001_d001DAOImpl implements ClubP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	@Override
	public List<ClubVO> clubList() throws DataAccessException {
		List<ClubVO> clubList = sqlSession.selectList("club.p001.clubList");
		return clubList;
	}
	@Override
	public List<ClubVO> myClubList(String m_id) {
		List<ClubVO> myClubList = sqlSession.selectList("club.p001.myClubList",m_id);
		return myClubList;
	}
	@Override
	public List<ClubVO> searchClubList(Map<String, Object> searchMap){
		List<ClubVO> searchClubList = sqlSession.selectList("club.p001.searchClubList",searchMap);
		return searchClubList;
	}
	@Override
	public ClubVO detailClub(Map<String, Object> searchMap) throws DataAccessException{
		ClubVO vo = sqlSession.selectOne("club.p001.detailClub",searchMap);
		return vo;
	}
	@Override
	public String memberCheck(Map<String, Object> searchMap) {
		ClubMemberVO vo = sqlSession.selectOne("club.p001.memberCheck",searchMap);
		String result="";
		if(vo == null) {
			result ="0";
		} else {
			result = vo.getCm_rank();
		}
		return result;
	}
	@Override
	public List<ClubMemberVO> getClubMember(Map<String, Object> searchMap) {
		List<ClubMemberVO> list = sqlSession.selectList("club.p001.getClubMember", searchMap);
		return list;
	}
	@Override
	public List<ClubMemberVO> getLeaderMember(Map<String, Object> searchMap) {
		List<ClubMemberVO> list = sqlSession.selectList("club.p001.getLeaderMember",searchMap);
		return list;
	}
	@Override
	public List<ClubVO> categoryClubList(Map<String, Object> searchMap) {
		List<ClubVO> categoryClubList = sqlSession.selectList("club.p001.categoryClubList",searchMap);
		return categoryClubList;
	}
	@Override
	public String categoryName(Map<String, Object> searchMap) {
		return sqlSession.selectOne("club.p001.categoryName", searchMap);
	}
	@Override
	public ClubVO detailClubCard(Map<String, Object> searchMap) {
		ClubVO vo = sqlSession.selectOne("club.p001.detailClubCard",searchMap);
		return vo;
	}
	@Override
	public List<ClubVO> searchClubListHashtag(Map<String, Object> searchMap) {
		List<ClubVO> searchClubList = sqlSession.selectList("club.p001.searchClubListHashtag",searchMap);
		return searchClubList;
	}
	@Override
	public int searchClubListCnt(Map<String, Object> searchMap) {
		return sqlSession.selectOne("club.p001.searchClubListCnt", searchMap);
	}
	@Override
	public int searchClubListCntHashtag(Map<String, Object> searchMap) {
		return sqlSession.selectOne("club.p001.searchClubListCntHashtag", searchMap);
	}
	@Override
	public int searchClubListCntCategory(Map<String, Object> searchMap) {
		return sqlSession.selectOne("club.p001.searchClubListCntCategory", searchMap);
	}
	@Override
	public List<AndP002AndOneVO> getAndOne(Map<String, Object> searchMap) {
		List<AndP002AndOneVO> list = sqlSession.selectList("club.p001.getAndOne", searchMap);
		return list;
	}
}
