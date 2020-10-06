package project.member.p001.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import project.member.p001.dao.MemberP001_d006DAO;
import project.member.p001.vo.MemberP001_d006VO;


@Service
@Transactional(propagation = Propagation.REQUIRED)
public class MemberP001_d006ServiceImpl implements MemberP001_d006Service{
	@Autowired
	private MemberP001_d006DAO memberP001_d006DAO;
	
	@Override
	public MemberP001_d006VO detailMember(Map<String, Object> searchMap) throws DataAccessException {
		MemberP001_d006VO p001_d002VO = memberP001_d006DAO.detailMember(searchMap);
		return p001_d002VO;
	}

	@Override
	public List<MemberP001_d006VO> getMemberList(MemberP001_d006VO vo) {
		return memberP001_d006DAO.getMemberList(vo);
	}
	
	

}
