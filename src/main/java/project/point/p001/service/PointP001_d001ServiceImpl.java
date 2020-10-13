package project.point.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.point.p001.dao.PointP001_d001DAO;

@Service
public class PointP001_d001ServiceImpl implements PointP001_d001Service{

	@Autowired
	PointP001_d001DAO pointP001_d001DAO;
	
	@Override
	public String selectNowPointById(String m_id) {
		return pointP001_d001DAO.selectNowPointById(m_id);
	}

}
