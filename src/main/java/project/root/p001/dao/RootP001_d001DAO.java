package project.root.p001.dao;

import java.util.List;
import java.util.Map;

import project.member.p001.vo.MemberP001_MemberVO;


public interface RootP001_d001DAO {
	public int updateMemberLocate(Map<String, String> map);
	public String selectMemberLocate(String m_id);
}
