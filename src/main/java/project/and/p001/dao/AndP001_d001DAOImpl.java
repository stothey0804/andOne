package project.and.p001.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.and.vo.AndP001AndOneVO;

@Repository
public class AndP001_d001DAOImpl implements AndP001_d001DAO{
	@Autowired
	private SqlSession sqlSession;
	//최근 등록된 같이먹기/사기/하기
	@Override
	public List selectRecentList(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> selectRecentList = null;
		selectRecentList = sqlSession.selectList("and.p001.selectRecentList",g_id);
		return selectRecentList;
	}
	//카테고리(이름/번호)
	@Override
	public List selectCtg(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> selectCtg = null;
		selectCtg = sqlSession.selectList("and.p001.selectCtg",g_id);
		return selectCtg;
	}
	//카테고리 검색
	@Override
	public List selectCtgList(AndP001AndOneVO vo) throws DataAccessException{
		List<AndP001AndOneVO> selectCtgList = null;
		selectCtgList = sqlSession.selectList("and.p001.selectCtgList",vo);
		return selectCtgList;
	}
	//전체검색
	@Override
	public List selectTotalSearchList(AndP001AndOneVO vo) throws DataAccessException{
		List<AndP001AndOneVO> selectTotalSearchList = null;
		selectTotalSearchList = sqlSession.selectList("and.p001.selectTotalSearchList",vo);
		return selectTotalSearchList;
	}
	
	
}
