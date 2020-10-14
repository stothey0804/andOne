package project.point.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.point.p001.dao.PointP001_d001DAO;
import project.point.p001.vo.PointP001VO;

@Service
public class PointP001_d001ServiceImpl implements PointP001_d001Service{

	@Autowired
	PointP001_d001DAO pointP001_d001DAO;
	
	@Override
	public String selectNowPointById(String m_id) {
		return pointP001_d001DAO.selectNowPointById(m_id);
	}

	@Override
	public int selectPointDetailCntByMember(String m_id) {
		return pointP001_d001DAO.selectPointDetailCntByMember(m_id);
	}

	@Override
	public List<PointP001VO> searchPointListByMember(Map<String, String> param) {
		return pointP001_d001DAO.searchPointListByMember(param);
	}

}
