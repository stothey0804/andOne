package project.member.p005.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.member.p005.vo.MemberP005VO;

/*
 * @Title	알림 - DAO
 * @Author	김세영
 * @Date	2020.10.22.
 * 
 * */

@Repository
public class MemberP005_d001DAOImpl implements MemberP005_d001DAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int selectNewNotifyCnt(String m_id) {
		return sqlSession.selectOne("member.p005.selectNewNotifyCnt", m_id);
	}

	@Override
	public int selectOldNotifyCnt(String m_id) {
		return sqlSession.selectOne("member.p005.selectOldNotifyCnt", m_id);
	}

	@Override
	public List<MemberP005VO> searchNewNotifyList(String m_id) {
		return sqlSession.selectList("member.p005.searchNewNotifyList", m_id);
	}

	@Override
	public List<MemberP005VO> searchOldNotifyList(Map<String, String> param) {
		return sqlSession.selectList("member.p005.searchOldNotifyList", param);
	}

	@Override
	public int updateNotifyChecked(Map<String, String> param) {
		return sqlSession.update("member.p005.updateNotifyChecked", param);
	}

	@Override
	public int insertNotify(MemberP005VO vo) {
		return sqlSession.insert("member.p005.insertNotify", vo);
	}

}
