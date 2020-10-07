package project.member.p002.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p002.dao.MemberP002_d001DAO;
import project.member.p002.vo.MemberP002VO;

@Service
public class MemberP002_d001ServiceImpl implements MemberP002_d001Service{
	
	@Autowired
	MemberP002_d001DAO memberP002_d001DAO;

	@Override
	public int insertQnA(MemberP002VO vo) {
		return memberP002_d001DAO.insertQnA(vo);
	}

	@Override
	public List<MemberP002VO> searchQnAListbyMemberID(String m_id) {
		return memberP002_d001DAO.searchQnAListbyMemberID(m_id);
	}

}
