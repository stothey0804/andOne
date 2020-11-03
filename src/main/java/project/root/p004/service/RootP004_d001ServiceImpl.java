package project.root.p004.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.root.p004.dao.RootP004_d001DAO;

@Service
public class RootP004_d001ServiceImpl implements RootP004_d001Service{
	
	@Autowired
	RootP004_d001DAO rootP004_d001DAO;

	@Override
	public Map<String, String> selectMemberGenderChart() {
		return rootP004_d001DAO.selectMemberGenderChart();
	}

	@Override
	public Map<String, String> selectMemberAgeChart() {
		return rootP004_d001DAO.selectMemberAgeChart();
	}

	@Override
	public List<Map<String, String>> selectAndOneChart(Map<String, String> map) {
		return rootP004_d001DAO.selectAndOneChart(map);
	}

	@Override
	public List<Map<String, String>> selectTotalAndOneTypeChart() {
		return rootP004_d001DAO.selectTotalAndOneTypeChart();
	}

	@Override
	public List<Map<String, String>> selectCategoryAndOne(String one_type) {
		return rootP004_d001DAO.selectCategoryAndOne(one_type);
	}
}
