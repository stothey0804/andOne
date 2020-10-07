package project.member.p001.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p001.dao.MemberP001_d005DAO;
import project.member.p001.vo.MemberP001_MemberVO;

@Service
public class MemberP001_d005ServiceImpl implements MemberP001_d005Service{
	@Autowired
	MemberP001_d005DAO memberP001_d005DAO;

	@Override
	public String selectPwdById(String id) {
		return memberP001_d005DAO.selectPwdById(id);
	}

	@Override
	public int updateMember(MemberP001_MemberVO vo) {
		return memberP001_d005DAO.updateMember(vo);
	}

	@Override
	public void saveImage(Map<String, Object> hmap) {
		memberP001_d005DAO.saveImage(hmap);
		
	}

	@Override
	public Map<String, Object> getByteImage(String m_id) {
		return memberP001_d005DAO.getByteImage(m_id);
	}

	@Override
	public MemberP001_MemberVO selectMemberById(String id) {
		return memberP001_d005DAO.selectMemberById(id);
	}
	
	
}
