package project.member.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p001.dao.MemberP001_d002DAO;
import project.member.p001.vo.MemberP001_MemberVO;

@Service
public class MemberP001_d002ServiceImpl implements MemberP001_d002Service{

	@Autowired
	MemberP001_d002DAO memberP001_d002DAO;
	
	@Override
	public MemberP001_MemberVO selectMemberByEmail(String email) {
		return memberP001_d002DAO.selectMemberByEmail(email);
	}

}
