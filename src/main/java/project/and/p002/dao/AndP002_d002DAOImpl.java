package project.and.p002.dao;

import java.util.List;

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
}
