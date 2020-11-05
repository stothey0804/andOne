package project.and.p003.controller;

import java.util.List;

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
				//m_id 기준 채팅목록 불러오기
				List<AndP003ChatRoomVO> chatRoomList = andP003_d001Service.getChatRoomList((String)session.getAttribute("m_id"));
				model.addAttribute("chatRoomList",chatRoomList);
				viewName = "message";
			}
		}
		return viewName;
	}
	
	@ResponseBody
	@RequestMapping("temp1")
	public List<AndP003ChatContentVO> getChatContentList(@RequestParam String one_id){
		List<AndP003ChatContentVO> chatContentList = andP003_d001Service.getChatContentList(one_id);
		return chatContentList;
	}
	
	@ResponseBody
	@RequestMapping("temp2")
	public List<AndP003ChatUserVO> getChatUserList(@RequestParam String one_id){
		List<AndP003ChatUserVO> chatUserList = andP003_d001Service.getChatUserList(one_id);
		for(int i=0; i<chatUserList.size(); i++) {
			andP003_d001Service.userImageEncoder(chatUserList.get(i));
		}
		return chatUserList;
	}
}
