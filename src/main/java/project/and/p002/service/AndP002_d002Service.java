package project.and.p002.service;

import java.util.List;
import java.util.Map;

import project.and.vo.AndOneMemberVO;

public interface AndP002_d002Service {
	public List<AndOneMemberVO> AndOnewaitMemList(String one_id);
	public void okOneMember(Map<String, Object> okMap);
	public void denyOneMember(Map<String, Object> denyMap);
	public int CancelTime(String one_id);
	public void cancelOneMember(Map<String, Object> cancelMap);
	public int andOneCnt(String one_id);
	public int oneMemCnt(Map<String, Object> cntMap);
	public void updateOneState(Map<String, Object> updateMap);
	public String selectGidByOneId(String one_id);	// g_id 선택..

}
