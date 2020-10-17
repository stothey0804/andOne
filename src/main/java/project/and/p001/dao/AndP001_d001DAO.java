package project.and.p001.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.and.vo.AndP001AndOneVO;

public interface AndP001_d001DAO {
	public List<AndP001AndOneVO> selectRecentList(String g_id) throws DataAccessException; //최근등록 같이먹기
	public List<AndP001AndOneVO> selectCtg(String g_id) throws DataAccessException;//카테고리 이름
	public List<AndP001AndOneVO> selectCtgList(AndP001AndOneVO vo) throws DataAccessException;
	public List<AndP001AndOneVO> selectTotalSearchList(AndP001AndOneVO vo) throws DataAccessException;
	public Map<String, Object> selectMemLocate(String m_id) throws DataAccessException;
	public List<Map<String,Object>> selectAndOneLocate(String g_id) throws DataAccessException;
}
