package project.and.p001.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.and.p001.vo.AndP001_d001VO;

@Repository
public class AndP001_d001DAOImpl implements AndP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	//같이먹기
	public List selectAllAndOneEatList() throws DataAccessException{
		List<AndP001_d001VO> andOneEatList = null;
		andOneEatList = sqlSession.selectList("mapper.and.p001_d001.selectAllAndOneEatList");
		return andOneEatList;
	}
	
	//같이하기
	public List selectAllAndOneDoList() throws DataAccessException{
		List<AndP001_d001VO> andOneDOList = null;
		andOneDOList = sqlSession.selectList("mapper.and.p001_d001.selectAllAndOneDoList");
		return andOneDOList;
	}
	
	//같이사기
	public List selectAllAndOneBuyList() throws DataAccessException{
		List<AndP001_d001VO> andOneBuyList = null;
		andOneBuyList = sqlSession.selectList("mapper.and.p001_d001.selectAllAndOneBuyList");
		return andOneBuyList;
	}
	
}
