package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.and.vo.AndP002AndOneVO;

@Repository
public class AndP002_d003DAOImpl implements AndP002_d003DAO {
	@Autowired
	private SqlSession sqlSession;
	
	//내가 작성한 엔분의일
	@Override
	public List<AndP002AndOneVO> selectWroteAndOneList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP002AndOneVO> selectWroteAndOneList = sqlSession.selectList("and.p002.selectWroteAndOne",searchMap);
		return selectWroteAndOneList;
	}
	//내가 참여한 엔분의일
	@Override
	public List<AndP002AndOneVO> selectParticiateAndOneList(Map<String, Object> searchMap) throws DataAccessException{
		List<AndP002AndOneVO> selectParticiateAndOneList = sqlSession.selectList("and.p002.selectParticiateAndOne",searchMap);
		return selectParticiateAndOneList;
	}

	@Override
	public int selectAndOnePageCnt(Map<String, Object> searchMap) {
		int selectAndOneCnt = sqlSession.selectOne("and.p002.selectAndOnePageCnt",searchMap);
		return selectAndOneCnt;
	}

}
