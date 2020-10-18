package project.club.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.club.p002.dao.ClubP002_d002DAO;
import project.club.vo.ClubMemberVO;

@Service
public class ClubP002_d002ServiceImpl implements ClubP002_d002Service{
	@Autowired
	private ClubP002_d002DAO clubP002_d002DAO;

	@Override
	public List<ClubMemberVO> waitMemberList(Map<String, Object> searchMap) {
		List<ClubMemberVO> waitMemberList = clubP002_d002DAO.waitMemberList(searchMap);
		return waitMemberList;
	}

	@Override
	public void permitMember(Map<String, Object> updateMap) {
		clubP002_d002DAO.permitMember(updateMap);
	}

	@Override
	public void denyMember(Map<String, Object> deleteMap) {
		clubP002_d002DAO.denyMember(deleteMap);
	}

}
