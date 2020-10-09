package project.member.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p002.dao.MemberP002_d002DAO;
import project.member.p002.vo.MemberP002VO;

@Service
public class MemberP002_d002ServiceImpl implements MemberP002_d002Service{

	@Autowired
	MemberP002_d002DAO memberP002_d002DAO;
	@Override
	public List<MemberP002VO> searchNewQnAList(Map<String, String> param) {
		return memberP002_d002DAO.searchNewQnAList(param);
	}
	@Override
	public List<MemberP002VO> searchAllQnAList(Map<String, String> param) {
		return memberP002_d002DAO.searchAllQnAList(param);
	}
	@Override
	public MemberP002VO searchQnADetail(String q_id) {
		return memberP002_d002DAO.searchQnADetail(q_id);
	}
	@Override
	public int saveQnAState(Map<String, String> param) {
		return memberP002_d002DAO.saveQnAState(param);
	}
	@Override
	public int saveReplyQnA(Map<String, String> param) {
		return memberP002_d002DAO.saveReplyQnA(param);
	}
	@Override
	public String searchReplyQnA(String q_id) {
		return memberP002_d002DAO.searchReplyQnA(q_id);
	}

}
