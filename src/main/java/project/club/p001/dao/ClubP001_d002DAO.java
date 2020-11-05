package project.club.p001.dao;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubVO;

public interface ClubP001_d002DAO {
	public List<ClubVO> clubList(Map<String, Object> searchMap);
	public int clubCnt();
}
