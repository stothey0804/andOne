package project.root.p002.service;

import java.util.List;
import java.util.Map;

import project.root.p002.vo.RootP002VO;

public interface RootP002_d001Service {
	public List<RootP002VO> fullSearch(String searchKeyword);
	public List<Map<String,String>> getObject(Map<String,Object> searchParam);
	public List<Map<String,String>> getSearchCnt(String searchKeyword);
}
