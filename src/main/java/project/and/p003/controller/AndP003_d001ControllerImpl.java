package project.and.p003.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.and.p003.service.AndP003_d001Service;
import project.and.p003.vo.AndP003ChatContentVO;
import project.and.p003.vo.AndP003ChatRoomVO;
import project.and.p003.vo.AndP003ChatUserVO;

@Controller
public class AndP003_d001ControllerImpl implements AndP003_d001Controller{
	@Autowired
	private AndP003_d001Service andP003_d001Service;
	
	@RequestMapping("message/messageInit.do")
	public String messageInit(HttpServletRequest request, Model model) {
		String viewName = "member/p001_d002";
		HttpSession session = request.getSession(false);
		if(session!=null) {
			if(session.getAttribute("m_id")!=null && session.getAttribute("isLogOn")!=null){
				//m_id attribute
				String m_id = (String)session.getAttribute("m_id");
				model.addAttribute("m_id",m_id);
				viewName = "message";
			}
		}
		return viewName;
	}
	
	@ResponseBody
	@RequestMapping("message/getChatRoomList.do")
	public List<AndP003ChatRoomVO> getChatRoomList(@RequestParam String m_id){
		List<AndP003ChatRoomVO> chatRoomList = andP003_d001Service.getChatRoomList(m_id);
		return chatRoomList;
	}
	
	@ResponseBody
	@RequestMapping("message/getChatContentList.do")
	public List<AndP003ChatContentVO> getChatContentList(@RequestParam String one_id){
		List<AndP003ChatContentVO> chatContentList = andP003_d001Service.getChatContentList(one_id);
		return chatContentList;
	}
	
	@ResponseBody
	@RequestMapping("message/getChatUserList.do")
	public List<AndP003ChatUserVO> getChatUserList(@RequestParam String one_id) {
		List<AndP003ChatUserVO> chatUserList = andP003_d001Service.getChatUserList(one_id);
		for(int i=0; i<chatUserList.size(); i++) {
			andP003_d001Service.userImageEncoder(chatUserList.get(i));
		}
		return chatUserList;
	}
	
	@ResponseBody
	@RequestMapping("message/insertChatContent.do")
	public Map<String,Object> insertChatContent(AndP003ChatContentVO vo) {
		andP003_d001Service.insertChatContent(vo);
		String one_id = vo.getOne_id();
		AndP003ChatContentVO latestMessage = andP003_d001Service.selectLatestMessage(one_id);
		List<String> userList = andP003_d001Service.getChatUserIdList(one_id);
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("latestMessage", latestMessage);
		resultMap.put("userList", userList);
		return resultMap;
	}
}
