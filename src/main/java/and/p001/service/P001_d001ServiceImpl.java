package and.p001.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import and.p001.dao.P001_d001DAO;
import and.p001.vo.P001_d001VO;


@Service
public class P001_d001ServiceImpl implements P001_d001Service {
	@Autowired
	private P001_d001DAO p001_d001DAO;
	
	@Override
	public List listAndOne_eat() throws DataAccessException{
		List<P001_d001VO> searchList_eat = null;
		searchList_eat = p001_d001DAO.selectAllAndOneEatList();
		return searchList_eat;
	}
	@Override
	public List listAndOne_do() throws DataAccessException{
		List<P001_d001VO> searchList_do = null;
		searchList_do = p001_d001DAO.selectAllAndOneDoList();
		return searchList_do;
	}
	@Override
	public List listAndOne_buy() throws DataAccessException{
		List<P001_d001VO> searchList_buy = null;
		searchList_buy = p001_d001DAO.selectAllAndOneBuyList();
		return searchList_buy;
	}
}
