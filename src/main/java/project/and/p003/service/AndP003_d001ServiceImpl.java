package project.and.p003.service;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.and.p003.dao.AndP003_d001DAO;
import project.and.p003.vo.AndP003ChatContentVO;
import project.and.p003.vo.AndP003ChatRoomVO;
import project.and.p003.vo.AndP003ChatUserVO;

@Service
public class AndP003_d001ServiceImpl implements AndP003_d001Service{
	@Autowired
	private AndP003_d001DAO andP003_d001DAO;

	@Override
	public List<AndP003ChatRoomVO> getChatRoomList(String m_id) {
		return andP003_d001DAO.getChatRoomList(m_id);
	}

	@Override
	public List<AndP003ChatContentVO> getChatContentList(String one_id) {
		return andP003_d001DAO.getChatContentList(one_id);
	}

	@Override
	public List<AndP003ChatUserVO> getChatUserList(String one_id) {
		return andP003_d001DAO.getChatUserList(one_id);
	}
	
	@Override
	public void userImageEncoder(AndP003ChatUserVO vo) {
		if(vo.getM_imgEncoder()!=null) {
			byte[] encoded = Base64.getEncoder().encode((byte[])vo.getM_imgEncoder().get("m_imgEncoder"));
			vo.setM_encodedImg(new String(encoded));
			vo.setM_imgEncoder(null);
		}
	}

	@Override
	public void insertChatContent(AndP003ChatContentVO vo) {
		andP003_d001DAO.insertChatContent(vo);
	}

	@Override
	public List<String> getChatUserIdList(String one_id) {
		return andP003_d001DAO.getChatUserIdList(one_id);
	}

	@Override
	public AndP003ChatContentVO selectLatestMessage(String one_id) {
		return andP003_d001DAO.selectLatestMessage(one_id);
	}
}
