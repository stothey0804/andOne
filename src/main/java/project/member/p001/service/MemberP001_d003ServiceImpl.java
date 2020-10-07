package project.member.p001.service;

import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import project.member.p001.dao.MemberP001_d003DAO;

@Service
public class MemberP001_d003ServiceImpl implements MemberP001_d003Service{
	
	@Autowired
	private MemberP001_d003DAO memberP001_d003DAO;
	
	@Autowired
	private JavaMailSender mailSender;	// 메일발송

	@Override
	@Async
	public void sendMail(String to, String subject, String body) {	// 메일발송
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("andOneProject2020@gmail.com","&분의일");// 송신자
			messageHelper.setSubject(subject);	// 제목
			messageHelper.setTo(to);	// 수신자
			messageHelper.setText(body, true);
			mailSender.send(message);	// 발송
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Map<String, String> searchIdPwdByEmail(String email) {
		return memberP001_d003DAO.searchIdPwdByEmail(email);
	}

	@Override
	public String selectPwdById(String id) {
		return memberP001_d003DAO.selectPwdById(id);
	}

	@Override
	public int updateMemberPwd(Map<String, String> member) {
		return memberP001_d003DAO.updateMemberPwd(member);
	}
	
}
