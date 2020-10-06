package project.member.p001.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import project.member.p001.vo.MemberP001_d006VO;

public interface MemberP001_d006DAO {
	public MemberP001_d006VO detailMember(Map<String, Object> searchMap) throws DataAccessException;
	public List<MemberP001_d006VO> getMemberList(MemberP001_d006VO vo);
}
