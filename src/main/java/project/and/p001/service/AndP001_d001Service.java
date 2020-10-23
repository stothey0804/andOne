package project.and.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.and.vo.AndOneMemberVO;
import project.and.vo.AndP001AndOneVO;

public interface AndP001_d001Service {
	public List recentAndOneList(Map<String, Object> param) throws DataAccessException;
	public List searchCtg(String g_id) throws DataAccessException;
	public List ctgSearchList(Map<String, Object> searchMap) throws DataAccessException;
	public List totalSearchList(Map<String, Object> searchMap) throws DataAccessException;
	public Map<String, Object> selectMemLocate(String m_id) throws DataAccessException;
	public List<AndP001AndOneVO> andOneDetailList(Map<String, Object> detailMap);
	public List<AndOneMemberVO> oneMemList(String one_id);
	public void addOneMember(Map<String, Object> addMemMap);
	public String omLeaderCheck(Map<String, Object> omCheckMap);
	public String checkPoint(String m_id);
}
