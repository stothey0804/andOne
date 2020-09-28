package project.member.p001.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p001.dao.MemberP001_d001DAO;
import project.member.p001.vo.MemberP001_MemberVO;

@Service
public class MemberP001_d001ServiceImpl implements MemberP001_d001Service{
	
	@Autowired
	MemberP001_d001DAO memberP001_d001DAO;

	@Override
	public String searchOverlapEmail(String email) {
		return memberP001_d001DAO.searchOverlapEmail(email);
	}

	@Override
	public String searchOverlapPhone(String phone) {
		return memberP001_d001DAO.searchOverlapPhone(phone);
	}

	@Override
	public MemberP001_MemberVO selectMemberByEmail(String email) {
		return memberP001_d001DAO.selectMemberByEmail(email);
	}

	@Override
	public int addMember(MemberP001_MemberVO vo) {
		return memberP001_d001DAO.addMember(vo);
	}

}
