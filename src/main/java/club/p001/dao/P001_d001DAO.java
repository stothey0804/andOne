package club.p001.dao;

import java.util.List;
import java.util.Map;

import club.p001.vo.P001_d001VO;

public interface P001_d001DAO {
	public List<P001_d001VO> clubList();
	public List<P001_d001VO> myClubList();
	public List<P001_d001VO> searchClubList(Map<String, Object> searchMap);
	public P001_d001VO detailClub(Map<String, Object> searchMap);
}
