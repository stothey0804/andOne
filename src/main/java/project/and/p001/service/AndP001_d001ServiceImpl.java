package project.and.p001.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import project.and.p001.dao.AndP001_d001DAO;
import project.and.p001.vo.AndP001AndOneVO;


@Service
public class AndP001_d001ServiceImpl implements AndP001_d001Service {
	@Autowired
	private AndP001_d001DAO p001_d001DAO;
	
	//메인 최근등록같이먹기
	@Override
	public List recentAndOneList(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> recentAndOneList = null;
		System.out.println("service찍혀라ㅠㅠㅠㅠ"+g_id);
		recentAndOneList = p001_d001DAO.selectRecentList(g_id);
		return recentAndOneList;
	}
	//카테고리(이름/번호)
	@Override
	public List searchCtg(String g_id) throws DataAccessException{
		List<AndP001AndOneVO> searchCtg = null;
		searchCtg = p001_d001DAO.selectCtg(g_id);
		return searchCtg;
	}
	//카테고리검색
	@Override
	public List ctgSearchList(AndP001AndOneVO vo) throws DataAccessException{
		List<AndP001AndOneVO> ctgSearchList = null;
		ctgSearchList = p001_d001DAO.selectCtgList(vo);
		return ctgSearchList;
	}
	//전체검색
	@Override
	public List totalSearchList(AndP001AndOneVO vo) throws DataAccessException{
		List<AndP001AndOneVO> totalSearchList = null;
		totalSearchList = p001_d001DAO.selectTotalSearchList(vo);
		return totalSearchList;
	}
	
}
