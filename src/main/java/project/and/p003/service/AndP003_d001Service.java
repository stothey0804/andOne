package project.and.p003.service;

import java.util.List;

import project.and.p003.vo.AndP003ChatContentVO;
import project.and.p003.vo.AndP003ChatRoomVO;
import project.and.p003.vo.AndP003ChatUserVO;

public interface AndP003_d001Service {
	public List<AndP003ChatRoomVO> getChatRoomList(String m_id);
	public List<AndP003ChatContentVO> getChatContentList(String one_id);
	public List<AndP003ChatUserVO> getChatUserList(String one_id);
	public void userImageEncoder(AndP003ChatUserVO vo);
}
