package project.and.p003.service;

import java.util.Map;

import project.and.p003.vo.AndP003VO;

public interface AndP003_d001Service {

	//채팅방 목록 불러오기
	public AndP003VO readChatList(Map<String, Object> chatMap)  throws Exception;

	
}
