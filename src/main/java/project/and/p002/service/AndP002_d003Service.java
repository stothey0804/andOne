package project.and.p002.service;

import java.util.List;
import java.util.Map;

import project.and.vo.AndP002AndOneVO;

public interface AndP002_d003Service {
	public List<AndP002AndOneVO> searchWroteAndOneList(Map<String, Object> searchMap);
	public List<AndP002AndOneVO> selectParticiateAndOneList(Map<String, Object> searchMap);
	public int selectAndOneCnt(Map<String, Object> searchMap);

}
