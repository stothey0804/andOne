package project.and.p002.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.and.p002.dao.AndP002_d001DAO;

@Service
public class AndP002_d001ServiceImpl implements AndP002_d001Service {
	@Autowired
	private AndP002_d001DAO p002_d001DAO;
	

}
