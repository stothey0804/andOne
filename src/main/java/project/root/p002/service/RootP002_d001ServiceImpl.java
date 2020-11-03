package project.root.p002.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.root.p002.dao.RootP002_d001DAO;
import project.root.p002.vo.RootP002VO;

@Service
public class RootP002_d001ServiceImpl implements RootP002_d001Service{
	@Autowired
	private RootP002_d001DAO rootP002_d001DAO;

	@Override
	public List<RootP002VO> fullSearch(String searchKeyword) {
		return rootP002_d001DAO.fullSearch(searchKeyword);
	}

	@Override
	public List<Map<String, String>> getObject(Map<String, Object> searchParam) {
		return rootP002_d001DAO.getObject(searchParam);
	}

	@Override
	public List<Map<String, String>> getSearchCnt(String searchKeyword) {
		return rootP002_d001DAO.getSearchCnt(searchKeyword);
	}
}
