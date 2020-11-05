package project.club.p001.service;

import java.util.List;
import java.util.Map;

import project.club.vo.ClubVO;

public interface ClubP001_d002Service {
	public List<ClubVO> clubList(Map<String, Object> searchMap);
	public int clubCnt();
}
