package project.member.p005.dao;

import java.util.List;
import java.util.Map;

import project.member.p005.vo.MemberP005VO;

public interface MemberP005_d001DAO {
	public int selectNewNotifyCnt(String m_id);	// 신규 알림 카운트
	public int selectOldNotifyCnt(String m_id);	// 읽은 알림 카운트
	public List<MemberP005VO> searchNewNotifyList(String m_id);					// 신규 알림 리스트 
	public List<MemberP005VO> searchOldNotifyList(Map<String, String> param);	// 읽은 알림 리스트
	public int updateNotifyChecked(Map<String, String> param);					// 읽음 상태 변경
	public int insertNotify(MemberP005VO vo);									// 신규 알림 등록
}
