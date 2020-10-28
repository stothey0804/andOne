package project.member.p003.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p003.dao.MemberP003_d001DAO;
import project.member.p003.vo.MemberP003VO;

@Service
public class MemberP003_d001ServiceImpl implements MemberP003_d001Service{

	@Autowired
	MemberP003_d001DAO memberP003_d001DAO;
	
	@Override
	public int saveReport(MemberP003VO param) {
		return memberP003_d001DAO.saveReport(param);
	}

	@Override
	public int deleteReport(String r_id) {
		return memberP003_d001DAO.deleteReport(r_id);
	}

	@Override
	public List<MemberP003VO> selectReportListById(Map<String, String> param) {
		return memberP003_d001DAO.selectReportListById(param);
	}

	@Override
	public int selectReportListByIdCnt(String m_id) {
		return memberP003_d001DAO.selectReportListByIdCnt(m_id);
	}

	@Override
	public MemberP003VO selectReportDetailByRID(String r_id) {
		return memberP003_d001DAO.selectReportDetailByRID(r_id);
	}

	@Override
	public int saveReportState(Map<String, String> param) {
		return memberP003_d001DAO.saveReportState(param);
	}

	@Override
	public List<MemberP003VO> selectAllReportList(Map<String, String> param) {
		return memberP003_d001DAO.selectAllReportList(param);
	}

	@Override
	public int selectAllReportListCnt(Map<String, String> param) {
		return memberP003_d001DAO.selectAllReportListCnt(param);
	}

}
