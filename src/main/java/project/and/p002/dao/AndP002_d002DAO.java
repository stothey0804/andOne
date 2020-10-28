package project.and.p002.dao;

import java.util.List;
import java.util.Map;

import project.and.vo.AndOneMemberVO;

public interface AndP002_d002DAO {
	public List<AndOneMemberVO> selectAndOnewaitMemList(String one_id);
	public void updateOkOneMember(Map<String, Object> okMap);
	public void updateDenyOneMember(Map<String, Object> denyMap);

}
