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

	@Override
	public void updateOkOneMember(Map<String, Object> okMap) {
		sqlSession.update("and.p002.updateOkOneMember",okMap);
		
	}

	@Override
	public void updateDenyOneMember(Map<String, Object> denyMap) {
		sqlSession.update("and.p002.updateDenyOneMember",denyMap);
		
	}
}
