package project.and.p003.dao;

import java.util.List;

import project.and.p003.vo.AndP003ChatContentVO;
import project.and.p003.vo.AndP003ChatRoomVO;
import project.and.p003.vo.AndP003ChatUserVO;

public interface AndP003_d001DAO {
	public List<AndP003ChatRoomVO> getChatRoomList(String m_id);
	public List<AndP003ChatContentVO> getChatContentList(String one_id);
	public List<AndP003ChatUserVO> getChatUserList(String one_id);
	public void insertChatContent(AndP003ChatContentVO vo);
	public List<String> getChatUserIdList(String one_id);
	public AndP003ChatContentVO selectLatestMessage(String one_id);
}
