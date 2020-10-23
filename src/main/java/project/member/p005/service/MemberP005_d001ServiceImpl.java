package project.member.p005.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.member.p005.dao.MemberP005_d001DAO;
import project.member.p005.vo.MemberP005VO;


/*
 * @Title	알림 - Service 
 * @Author	김세영
 * @Date	2020.10.22.
 * 
 * */

@Service
public class MemberP005_d001ServiceImpl implements MemberP005_d001Service{

	@Autowired
	MemberP005_d001DAO memberP005_d001DAO;

	@Override
	public int selectNewNotifyCnt(String m_id) {
		return memberP005_d001DAO.selectNewNotifyCnt(m_id);
	}

	@Override
	public int selectOldNotifyCnt(String m_id) {
		return memberP005_d001DAO.selectOldNotifyCnt(m_id);
	}

	@Override
	public List<MemberP005VO> searchNewNotifyList(String m_id) {
		return memberP005_d001DAO.searchNewNotifyList(m_id);
	}

	@Override
	public List<MemberP005VO> searchOldNotifyList(Map<String, String> param) {
		return memberP005_d001DAO.searchOldNotifyList(param);
	}

	@Override
	public int updateNotifyChecked(Map<String, String> param) {
		return memberP005_d001DAO.updateNotifyChecked(param);
	}

	@Override
	public int insertNotify(MemberP005VO vo) {
		return memberP005_d001DAO.insertNotify(vo);
	}
	
	
}
