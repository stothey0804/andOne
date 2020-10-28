package project.point.p001.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.point.p001.dao.PointP001_d003DAO;

@Service
public class PointP001_d003ServiceImpl implements PointP001_d003Service {
	@Autowired
	private PointP001_d003DAO p001_d003DAO;
	
	//참가자 신청
	@Override
	public void addOneMember(Map<String, Object> addMemMap) {
		p001_d003DAO.addOneMember(addMemMap);
	}

}
