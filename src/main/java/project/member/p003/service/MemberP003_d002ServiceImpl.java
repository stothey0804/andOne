package project.member.p003.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p003.dao.MemberP003_d002DAO;
import project.member.p003.vo.MemberP003VO;

@Service
public class MemberP003_d002ServiceImpl implements MemberP003_d002Service{

	@Autowired
	MemberP003_d002DAO memberP003_d002DAO;
	
	@Override
	public MemberP003VO selectReportDetailByRID(String r_id) {
		return memberP003_d002DAO.selectReportDetailByRID(r_id);
	}

	@Override
	public int saveReportState(Map<String, String> param) {
		return memberP003_d002DAO.saveReportState(param);
	}

	@Override
	public List<MemberP003VO> selectAllReportList(Map<String, String> param) {
		return memberP003_d002DAO.selectAllReportList(param);
	}

	@Override
	public int selectAllReportListCnt(Map<String, String> param) {
		return memberP003_d002DAO.selectAllReportListCnt(param);
	}
	
}
