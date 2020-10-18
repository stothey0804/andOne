package project.member.p004.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p004.dao.MemberP004_d001DAO;

@Service
public class MemberP004_d001ServiceImpl implements MemberP004_d001Service{
	
	@Autowired MemberP004_d001DAO memberP004_d001DAO;

	@Override
	public Map<String, String> searchMemberInfo(String m_id) {
		return memberP004_d001DAO.searchMemberInfo(m_id);
	}
	
}
