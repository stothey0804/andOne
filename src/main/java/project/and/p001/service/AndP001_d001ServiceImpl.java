package project.and.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import project.and.p001.dao.AndP001_d001DAO;
import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;


@Service
public class AndP001_d001ServiceImpl implements AndP001_d001Service {
	@Autowired
	private AndP001_d001DAO p001_d001DAO;
	
	//메인 최근등록같이먹기
	@Override
	public List<AndP001AndOneVO> recentAndOneList(Map<String, Object> param) throws DataAccessException{
		List<AndP001AndOneVO> recentAndOneList = null;
		recentAndOneList = p001_d001DAO.selectRecentList(param);
		return recentAndOneList;
	}
	//카테고리(이름/번호)
	@Override
	public List<AndP001AndOneVO> searchCtg(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> searchCtg = null;
		searchCtg = p001_d001DAO.selectCtg(g_id);
		return searchCtg;
	}
	//더보기
	@Override
	public List<AndP001AndOneVO> searchMoreAndOne(Map<String, Object> searchMap) {
		List<AndP001AndOneVO> searchMoreAndOneList = p001_d001DAO.searchMoreAndOne(searchMap);
		return searchMoreAndOneList;
	}
	//카테고리검색
	@Override
	public List<AndP001AndOneVO> ctgSearchList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP001AndOneVO> ctgSearchList = null;
		ctgSearchList = p001_d001DAO.selectCtgList(searchMap);
		return ctgSearchList;
	}
	//전체검색
	@Override
	public List<AndP001AndOneVO> totalSearchList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP001AndOneVO> totalSearchList = null;
		totalSearchList = p001_d001DAO.selectTotalSearchList(searchMap);
		return totalSearchList;
	}
	//회원위치가져오기
	@Override
	public Map<String, Object> selectMemLocate(String m_id) throws DataAccessException{
		Map<String, Object> locate =  p001_d001DAO.selectMemLocate(m_id);
		 System.out.println("나왔니,,,?"+locate.get("m_locate_Lat"));
		return locate;
	}
	//엔분의 일 상세보기
	@Override
	public AndP001AndOneVO andOneDetail(Map<String, Object> detailMap) {
		AndP001AndOneVO andOneDetail = null;
		andOneDetail = p001_d001DAO.selectAndOneDetail(detailMap);
		return andOneDetail;
	}
	//엔분의 작성자 
	@Override
	public List<AndOneMemberVO> oneMemList(String one_id) {
		List<AndOneMemberVO> oneMemList = null;
		oneMemList = p001_d001DAO.selectOneMem(one_id);
		return oneMemList;
	}
	//작성자 참가자 확인
	@Override
	public AndOneMemberVO omLeaderCheck(Map<String,Object> omCheckMap) {
		AndOneMemberVO omLeaderCheck = p001_d001DAO.omLeaderCheck(omCheckMap);
		System.out.println("서비스체크   :"+omLeaderCheck);
		return omLeaderCheck;
	}
	@Override
	public void updateAndOneState() {
		p001_d001DAO.updateAndOneState();
	}
	@Override
	public List<AndP001AndOneVO> pointList() {
		List<AndP001AndOneVO> pointList = p001_d001DAO.pointList();
		return pointList;
	}
	@Override
	public void updateAndOneRefund(String one_id) {
		p001_d001DAO.updateAndOneRefund(one_id);
		
	}
	@Override
	public List<AndP001AndOneVO> payList() {
		List<AndP001AndOneVO> payList = p001_d001DAO.payList();
		return payList;
	}
	@Override
	public void updateAndOnePay(String one_id) {
		p001_d001DAO.updateAndOnePay(one_id);
	}
	@Override
	public int andOneCnt() {
		int andOneCnt = p001_d001DAO.selectAndOneCnt();
		return andOneCnt;
	}
	@Override
	public int selectAndOneCtgCnt(Map<String, Object> ctgSearchMap) {
		int selectAndOneCtgCnt = p001_d001DAO.selectAndOneCtgCnt(ctgSearchMap);
		return selectAndOneCtgCnt;
	}
	@Override
	public int selectAndOneTotalSearchCnt(Map<String, Object> totalSearchMap) {
		int selectAndOneTotalSearchCnt = p001_d001DAO.selectAndOneTotalSearchCnt(totalSearchMap);
		return selectAndOneTotalSearchCnt;
	}

}
