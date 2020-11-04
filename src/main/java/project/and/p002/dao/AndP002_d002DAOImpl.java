package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.and.vo.AndOneMemberVO;

@Repository
public class AndP002_d002DAOImpl implements AndP002_d002DAO {
	@Autowired
	private SqlSession sqlSession;
	
	//엔분의일 신청자정보
	@Override
	public List<AndOneMemberVO> selectAndOnewaitMemList(String one_id){
		List<AndOneMemberVO> selectAndOnewaitMemList = sqlSession.selectList("and.p002.selectAndOneWaitMem",one_id);
		return selectAndOnewaitMemList;
	}
	
	//엔분의일 신청수락
	@Override
	public void updateOkOneMember(Map<String, Object> okMap) {
		sqlSession.update("and.p002.updateOkOneMember",okMap);
		
	}
	
	//엔분의일 신청거절
	@Override
	public void updateDenyOneMember(Map<String, Object> denyMap) {
		sqlSession.update("and.p002.updateDenyOneMember",denyMap);
		
	}
	
	//취소 시간 계산
	@Override
	public int selectCancelTime(String one_id) {
		int CancelTime = sqlSession.selectOne("and.p002.selectCancelTime", one_id);
		return CancelTime;
	}
	
	//엔분의일 취소
	@Override
	public void updateCancelOneMember(Map<String, Object> cancelMap) {
		sqlSession.update("and.p002.updateCancelOneMember", cancelMap);
	}
	//엔분의일 글 인원 수 확인
	@Override
	public int selectAndOneMemberCnt(String one_id) {
		int andOneCnt = sqlSession.selectOne("and.p002.selectAndOneMemberCnt",one_id);
		return andOneCnt;
	}
	//결제완료후 수락까지 받은 인원수 확인
	@Override
	public int selectOneMemCnt(Map<String, Object> cntMap) {
		int OneMemCnt = sqlSession.selectOne("and.p002.selectOneMemCnt", cntMap);
		return OneMemCnt;
	}
	//엔분의일 진행상태 업테이트
	@Override
	public void updateOneState(Map<String, Object> updateMap) {
		sqlSession.update("and.p002.updateOneState", updateMap);
	}
}
