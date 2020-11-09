package project.root.p001.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.root.p001.dao.RootP001_d001DAO;


@Service
public class RootP001_d001ServiceImpl implements RootP001_d001Service{

	@Autowired
	RootP001_d001DAO rootP001_d001DAO;
	
	@Override
	public int updateMemberLocate(Map<String, String> map) {
		return rootP001_d001DAO.updateMemberLocate(map);
	}

	@Override
	public Map<String, String> selectMemberLocate(String m_id) {
		return rootP001_d001DAO.selectMemberLocate(m_id);
	}

	@Override
	public Map<String, String> selectTodayAdminMain() {
		return rootP001_d001DAO.selectTodayAdminMain();
	}

	@Override
	public List<Map<String, String>> selectWeeklyNewMember() {
		return rootP001_d001DAO.selectWeeklyNewMember();
	}

	@Override
	public List<Map<String, String>> selectWeeklySales() {
		return rootP001_d001DAO.selectWeeklySales();
	}

	@Override
	public void updatePopularHashtag(String ph_content) {
		rootP001_d001DAO.updatePopularHashtag(ph_content);
	}

	@Override
	public List<String> getAllHashtagList() {
		return rootP001_d001DAO.getAllHashtagList();
	}

	@Override
	public String getPopularHashtag() {
		return rootP001_d001DAO.getPopularHashtag();
	}
	
	@Override
	public void popularHashtagUpdate() {
		List<String> hashtagList = getAllHashtagList();
		Map<String,Integer> hashtagMap = new HashMap<>();
		for(int i=0; i<hashtagList.size(); i++) {
			if(hashtagList.get(i) == null) {
				continue;
			}else {
				String[] parser = hashtagList.get(i).split(",");
				for(int j=0; j<parser.length; j++) {
					if(parser[j].equals("")) {
						continue;
					}else {
						if(hashtagMap.containsKey(parser[j])) {
							int value = (int)hashtagMap.get(parser[j]);
							value++;
							hashtagMap.replace(parser[j], value);
						}else {
							hashtagMap.put(parser[j], 1);
						}
					}
				}
			}
		}
		List<String> keySetList = new ArrayList<>(hashtagMap.keySet());
		Collections.sort(keySetList, (o1, o2) -> (hashtagMap.get(o2).compareTo(hashtagMap.get(o1))));
		System.out.println("======>상위 4개 해시태그만 printout");
		String result = "";
		for(int i=0; i<4; i++) {
			result += keySetList.get(i);
			System.out.println("#"+keySetList.get(i));
			result += ",";
		}
		result = result.substring(0, result.length()-1);
		System.out.println("=======>DB에 들어갈 인기 해시태그");
		System.out.println(result);
		updatePopularHashtag(result);
	}
}
