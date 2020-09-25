package and.p001.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface P001_d001DAO {
	public List selectAllAndOneEatList() throws DataAccessException;
	public List selectAllAndOneDoList() throws DataAccessException;
	public List selectAllAndOneBuyList() throws DataAccessException;
}
