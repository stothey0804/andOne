package project.root.p003.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.root.p003.dao.RootP003_d001DAO;
import project.root.p003.vo.RootP003VO;

@Service
public class RootP003_d001ServiceImpl implements RootP003_d001Service{

	@Autowired
	RootP003_d001DAO rootP003_d001DAO;
	
	@Override
	public int selectNoticeListCnt() {
		return rootP003_d001DAO.selectNoticeListCnt();
	}

	@Override
	public int insertNotice(RootP003VO vo) {
		return rootP003_d001DAO.insertNotice(vo);
	}

	@Override
	public int updateNoticeById(RootP003VO vo) {
		return rootP003_d001DAO.updateNoticeById(vo);
	}

	@Override
	public List<RootP003VO> searchNoticeList(Map<String, String> param) {
		return rootP003_d001DAO.searchNoticeList(param);
	}

	@Override
	public int deleteNoticeById(String n_id) {
		return rootP003_d001DAO.deleteNoticeById(n_id);
	}

	@Override
	public RootP003VO searchNoticeById(String n_id) {
		return rootP003_d001DAO.searchNoticeById(n_id);
	}
	
}
