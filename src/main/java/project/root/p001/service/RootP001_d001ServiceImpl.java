package project.root.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.root.p001.dao.RootP001_d001DAO;


@Service
public class RootP001_d001ServiceImpl implements RootP001_d001Service{

	@Autowired
	RootP001_d001DAO rootP001_d001DAO;
	
	@Override
	public int updateMemberLocate(Map<String, String> map) {
		return rootP001_d001DAO.updateMemberLocate(map);
	}

	@Override
	public String selectMemberLocate(String m_id) {
		return rootP001_d001DAO.selectMemberLocate(m_id);
	}


}
