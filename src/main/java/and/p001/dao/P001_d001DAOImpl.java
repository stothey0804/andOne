package and.p001.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import and.p001.vo.P001_d001VO;

@Repository
public class P001_d001DAOImpl implements P001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	//같이먹기
	public List selectAllAndOneEatList() throws DataAccessException{
		List<P001_d001VO> andOneEatList = null;
		andOneEatList = sqlSession.selectList("project.p003_d001.selectAllAndOneEatList");
		return andOneEatList;
	}
	
	//같이하기
	public List selectAllAndOneDoList() throws DataAccessException{
		List<P001_d001VO> andOneDOList = null;
		andOneDOList = sqlSession.selectList("project.p003_d001.selectAllAndOneDoList");
		return andOneDOList;
	}
	
	//같이사기
	public List selectAllAndOneBuyList() throws DataAccessException{
		List<P001_d001VO> andOneBuyList = null;
		andOneBuyList = sqlSession.selectList("project.p003_d001.selectAllAndOneBuyList");
		return andOneBuyList;
	}
	
}
