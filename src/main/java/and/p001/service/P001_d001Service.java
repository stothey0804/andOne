package and.p001.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface P001_d001Service {
	public List listAndOne_eat() throws DataAccessException;
	public List listAndOne_do() throws DataAccessException;
	public List listAndOne_buy() throws DataAccessException;
	
	
}
