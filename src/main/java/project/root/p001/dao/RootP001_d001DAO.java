package project.root.p001.dao;

import java.util.Map;



public interface RootP001_d001DAO {
	public int updateMemberLocate(Map<String, String> map);
	public Map<String, String> selectMemberLocate(String m_id);
}
