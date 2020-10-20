package project.member.p004.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p004.dao.MemberP004_d001DAO;
import project.member.p004.vo.MemberP004VO;

@Service
public class MemberP004_d001ServiceImpl implements MemberP004_d001Service{
	
	@Autowired MemberP004_d001DAO memberP004_d001DAO;

	@Override
	public Map<String, String> searchMemberInfo(String m_id) {
		return memberP004_d001DAO.searchMemberInfo(m_id);
	}

	@Override
	public int insertMemberReview(Map<String, String> param) {
		return memberP004_d001DAO.insertMemberReview(param);
	}

	@Override
	public String selectMemberScore(String m_id) {
		return memberP004_d001DAO.selectMemberScore(m_id);
	}

	@Override
	public int updateMemberScore(String m_id) {
		return memberP004_d001DAO.updateMemberScore(m_id);
	}

	@Override
	public List<MemberP004VO> searchReceivedMemberReview(Map<String, String> param) {
		return memberP004_d001DAO.searchReceivedMemberReview(param);
	}

	@Override
	public List<MemberP004VO> searchWroteMemberReview(Map<String, String> param) {
		return memberP004_d001DAO.searchWroteMemberReview(param);
	}
	
}
