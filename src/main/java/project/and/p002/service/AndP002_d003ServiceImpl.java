package project.and.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.and.p002.dao.AndP002_d003DAO;
import project.and.vo.AndP002AndOneVO;

@Service
public class AndP002_d003ServiceImpl implements AndP002_d003Service {
	@Autowired
	private AndP002_d003DAO p002_d003DAO;
	
	//내가 작성한 엔분의일
	@Override
	public List<AndP002AndOneVO> searchWroteAndOneList(Map<String, Object> searchMap){
		List<AndP002AndOneVO> searchWroteAndOneList = p002_d003DAO.selectWroteAndOneList(searchMap);
		return searchWroteAndOneList;
	}
	//내가 참여한 엔분의일
	@Override
	public List<AndP002AndOneVO> selectParticiateAndOneList(Map<String, Object> searchMap){
		List<AndP002AndOneVO> selectParticiateAndOneList = p002_d003DAO.selectParticiateAndOneList(searchMap);
		return selectParticiateAndOneList;
	}
	
	@Override
	public int selectAndOnePageCnt(Map<String, Object> searchMap){
		int selectAndOneCnt = p002_d003DAO.selectAndOnePageCnt(searchMap);
		return selectAndOneCnt;
	}

}
