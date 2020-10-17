package project.and.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.and.vo.AndP001AndOneVO;

public interface AndP001_d001Service {
	public List recentAndOneList(String g_id) throws DataAccessException;
	public List searchCtg(String g_id) throws DataAccessException;
	public List ctgSearchList(AndP001AndOneVO vo) throws DataAccessException;
	public List totalSearchList(AndP001AndOneVO vo) throws DataAccessException;
	public  Map<String, Object> selectMemLocate(String m_id) throws DataAccessException;
	public List<Map<String,Object>> selectAndOneLocate(String g_id) throws DataAccessException;
}
