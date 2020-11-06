package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import project.and.vo.AndOneMemberVO;

public interface AndP002_d002DAO {
	public List<AndOneMemberVO> selectAndOnewaitMemList(String one_id);
	public void updateOkOneMember(Map<String, Object> okMap);
	public void updateDenyOneMember(Map<String, Object> denyMap);
	public int selectCancelTime(String one_id);
	public void updateCancelOneMember(Map<String, Object> cancelMap);
	public int selectAndOneMemberCnt(String one_id);
	public int selectOneMemCnt(Map<String, Object> cntMap);
	public void updateOneState(Map<String, Object> updateMap);
	public String selectGidByOneId(String one_id);	// g_id 선택..
}
