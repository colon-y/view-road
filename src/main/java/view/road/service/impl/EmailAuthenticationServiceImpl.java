package view.road.service.impl;

import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import view.road.model.dao.mapper.SmtpMapper;
import view.road.model.dao.mapper.UserMapper;
import view.road.model.vo.SmtpVO;
import view.road.model.vo.UserVO;
import view.road.service.EmailAuthenticationService;
import view.road.util.config.MyMailSend;

@Service
public class EmailAuthenticationServiceImpl implements EmailAuthenticationService {

	@Autowired
	private MyMailSend mailSend;

	@Autowired
	private SmtpMapper smtpMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;	

	
	@Override
	public String emailSend(UserVO userVO, HttpServletRequest request) throws Exception {

		SmtpVO smtpVO = smtpMapper.getSmtpInfo(1);
		mailSend.setHost(smtpVO.getHost());
		mailSend.setUsername(smtpVO.getUsername());
		mailSend.setPassword(smtpVO.getPassword());
		String emailName = smtpVO.getEmailName();

		String toEmail = userVO.getEmail();
		String emailAuthKey = mailSend.getKey(7);		
		StringBuffer stb = new StringBuffer().append("<h1>[이메일 인증]</h1>").append("<h3>키값 : "+emailAuthKey+"</h3>")
				.append("<p>이메일 인증 키값을 입력 해주세요.</p>");
				
		String fromEmail = toEmail;
		// 다중 메일 : 수신자 주소
		InternetAddress[] addArray = new InternetAddress[1];
		try {
			addArray[0] = new InternetAddress(toEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		mailSend.emailSend(fromEmail, emailName, addArray, "회원가입 이메일 인증", stb.toString(), "text/html");

		return emailAuthKey;
	}

	
	/**
	 * 이메일로 아이디 발송
	 */
	@Override
	public String emailSendId(UserVO userVO, HttpServletRequest request) throws Exception {

		SmtpVO smtpVO = smtpMapper.getSmtpInfo(1);
		mailSend.setHost(smtpVO.getHost());
		mailSend.setUsername(smtpVO.getUsername());
		mailSend.setPassword(smtpVO.getPassword());
		String emailName = smtpVO.getEmailName();

		String toEmail = userVO.getEmail();		
		StringBuffer stb = new StringBuffer().append("<h1>[등록된 아이디]</h1>").append("<h2>"+userVO.getUserId()+"</h2>");
				
		String fromEmail = toEmail;
		// 다중 메일 : 수신자 주소
		InternetAddress[] addArray = new InternetAddress[1];
		try {
			addArray[0] = new InternetAddress(toEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		mailSend.emailSend(fromEmail, emailName, addArray, "등록된 아이디 발송", stb.toString(), "text/html");

		return "success";
	}

	
	
	@Transactional
	@Override
	public String emailSendPassword(UserVO userVO, HttpServletRequest request) throws Exception {
		//래덤 비밀번호 8자리 숫자 생성
		String password=RandomStringUtils.randomAlphanumeric(8);
		userVO.setPassword(passwordEncoder.encode(password));
		userMapper.updatePassword(userVO);
		//비밀번호 DB 저장
		
		SmtpVO smtpVO = smtpMapper.getSmtpInfo(1);
		mailSend.setHost(smtpVO.getHost());
		mailSend.setUsername(smtpVO.getUsername());
		mailSend.setPassword(smtpVO.getPassword());
		String emailName = smtpVO.getEmailName();

		String toEmail = userVO.getEmail();		
				
		
		StringBuffer stb = new StringBuffer().append("<h1>[임시 비밀번호]</h1>").append("<h2>"+password+"</h2>");
				
		String fromEmail = toEmail;
		// 다중 메일 : 수신자 주소
		InternetAddress[] addArray = new InternetAddress[1];
		try {
			addArray[0] = new InternetAddress(toEmail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		mailSend.emailSend(fromEmail, emailName, addArray, "임시 비밀번호 발송", stb.toString(), "text/html");
		
		return "success";
	}
	
	


}
