package project.and.p002.service;

import java.util.List;
import java.util.Map;

import project.and.vo.AndOneMemberVO;

public interface AndP002_d002Service {
	public List<AndOneMemberVO> AndOnewaitMemList(String one_id);
	public void okOneMember(Map<String, Object> okMap);
	public void denyOneMember(Map<String, Object> denyMap);

}
