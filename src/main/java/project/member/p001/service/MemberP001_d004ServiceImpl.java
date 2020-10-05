package project.member.p001.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import project.member.p001.dao.MemberP001_d004DAO;

@Service
public class MemberP001_d004ServiceImpl implements MemberP001_d004Service{
	@Autowired
	private MemberP001_d004DAO memberP001_d004DAO;
	
	@Override
	public int deleteMember(String id) {
		return memberP001_d004DAO.deleteMember(id);
	}
	
	
}
