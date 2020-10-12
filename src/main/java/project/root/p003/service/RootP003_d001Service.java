package project.root.p003.service;

import java.util.List;
import java.util.Map;

import project.root.p003.vo.RootP003VO;

public interface RootP003_d001Service {
	public int selectNoticeListCnt();	// 게시글 수 조회
	public int insertNotice(RootP003VO vo);	// 공지작성
	public int updateNoticeById(RootP003VO vo);	// 공지수정
	public List<RootP003VO> searchNoticeList(Map<String, String> param); // 공지리스트 조회
	public int deleteNoticeById(String n_id);	// 공지삭제
	public RootP003VO searchNoticeById(String n_id);	// 수정폼 전달
}
