package project.and.p001.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;

@Repository
public class AndP001_d001DAOImpl implements AndP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	//최근 등록된 같이먹기/사기/하기
	@Override
	public List<AndP001AndOneVO> selectRecentList(Map<String, Object> param) throws DataAccessException{
		List<AndP001AndOneVO> selectRecentList = null;
		selectRecentList = sqlSession.selectList("and.p001.selectRecentList",param);
		return selectRecentList;
	}
	//더보기
	@Override
	public List<AndP001AndOneVO> searchMoreAndOne(Map<String, Object> searchMap) {
		List<AndP001AndOneVO> searchMoreAndOneList = sqlSession.selectList("and.p001.selectSearchMoreAndOne",searchMap);
		return searchMoreAndOneList;
	}
	//카테고리(이름/번호)
	@Override
	public List<AndP001AndOneVO> selectCtg(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> selectCtg = null;
		selectCtg = sqlSession.selectList("and.p001.selectCtg",g_id);
		return selectCtg;
	}
	//카테고리 검색
	@Override
	public List<AndP001AndOneVO> selectCtgList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP001AndOneVO> selectCtgList = null;
		selectCtgList = sqlSession.selectList("and.p001.selectCtgList",searchMap);
		return selectCtgList;
	}
	//전체검색
	@Override
	public List<AndP001AndOneVO> selectTotalSearchList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP001AndOneVO> selectTotalSearchList = null;
		selectTotalSearchList = sqlSession.selectList("and.p001.selectTotalSearchList",searchMap);
		return selectTotalSearchList;
	}
	//회원위치가져오기
	@Override
	public Map<String, Object> selectMemLocate(String m_id) throws DataAccessException{
		System.out.println(">>>>>>>>>>>>>>"+m_id);
		 Map<String, Object> selectMemLocate = sqlSession.selectOne("and.p001.selectMemLocate", m_id);
		 System.out.println("나왔니?"+selectMemLocate.get("m_locate_Lat"));
		return selectMemLocate;
	}
	//엔분의일 위치 
	@Override
	public List<Map<String,Object>> selectAndOneLocate(String g_id) throws DataAccessException{
		System.out.println(g_id);
		List<Map<String,Object>> selectAndOneLocate = sqlSession.selectList("selectAndOneLocate", g_id);
		return selectAndOneLocate;
	}
	//엔분의일 상세보기
	@Override
	public AndP001AndOneVO selectAndOneDetail(Map<String, Object> detailMap) {
		AndP001AndOneVO selectAndOneDetail = null;
		selectAndOneDetail = sqlSession.selectOne("and.p001.selectAndOneDetail",detailMap);
		return selectAndOneDetail;
	}
	//엔분의일 작성자정보
	@Override
	public List<AndOneMemberVO> selectOneMem(String one_id) {
		List<AndOneMemberVO> selectOneMem = null;
		selectOneMem = sqlSession.selectList("and.p001.selectOneMem",one_id);
		return selectOneMem;
	}
	//om_leader / om_state 체크
	@Override
	public AndOneMemberVO omLeaderCheck(Map<String,Object> omCheckMap) {
		AndOneMemberVO omLeaderCheck = sqlSession.selectOne("and.p001.selectOmLeader",omCheckMap);
		return omLeaderCheck;
	}
	@Override
	public void updateAndOneState() {
		sqlSession.update("and.p001.updateAndOneState");
	}
	@Override
	public List<AndP001AndOneVO> pointList() {
		List<AndP001AndOneVO> pointList = sqlSession.selectList("and.p001.selectPointList");
		return pointList;
	}
	@Override
	public void updateAndOneRefund(String one_id) {
		sqlSession.update("and.p001.updateAndOneRefund",one_id);
		
	}
	@Override
	public List<AndP001AndOneVO> payList() {
		List<AndP001AndOneVO> payList = sqlSession.selectList("and.p001.selectPayList");
		return payList;
	}
	@Override
	public void updateAndOnePay(String one_id) {
		sqlSession.update("and.p001.updateAndOnePay",one_id);
	}
	@Override
	public int selectAndOneCnt() {
		int selectAndOneCnt = sqlSession.selectOne("and.p001.selectAndOneCnt");
		return selectAndOneCnt;
	}
	@Override
	public int selectAndOneCtgCnt(Map<String, Object> ctgSearchMap) {
		int selectAndOneCtgCnt = sqlSession.selectOne("and.p001.selectAndOneCtgCnt",ctgSearchMap);
		return selectAndOneCtgCnt;
	}
	@Override
	public int selectAndOneTotalSearchCnt(Map<String, Object> totalSearchMap) {
		int selectAndOneTotalSearchCnt = sqlSession.selectOne("and.p001.selectAndOneTotalSearchCnt",totalSearchMap);	
		return selectAndOneTotalSearchCnt;
	}
}
