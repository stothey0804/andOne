package project.member.p002.service;

import java.util.List;
import java.util.Map;

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
	public int selectQnAListCnt(String m_id) {
		return memberP002_d001DAO.selectQnAListCnt(m_id);
	}

	@Override
	public List<MemberP002VO> searchQnAListbyMemberID(Map<String, String> param) {
		return memberP002_d001DAO.searchQnAListbyMemberID(param);
	}

	@Override
	public int saveQnA(MemberP002VO vo) {
		return memberP002_d001DAO.saveQnA(vo);
	}

	@Override
	public int deleteQnA(String q_id) {
		return memberP002_d001DAO.deleteQnA(q_id);
	}

}
