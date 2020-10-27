package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.and.vo.AndP002AndOneVO;

public interface AndP002_d003DAO {
	public List<AndP002AndOneVO> selectWroteAndOneList(Map<String, Object> searchMap) throws DataAccessException;
	public List<AndP002AndOneVO> selectParticiateAndOneList(Map<String, Object> searchMap) throws DataAccessException;
	public int selectAndOneCnt(Map<String, Object> searchMap);

}
