package view.road.util.config;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@Data
@Configuration
public class MyMailSend {

	@Autowired
	private HttpServletRequest request;

	private String host; // host 네이버일 경우(smtp.naver.com), gmail경우(smtp.gmail.com) 로컬일 경우 localhost
	private String username; // 아이디
	private String password; // 비밀번호
	private int size;

	public void emailSend(String fromEmail, String nickname, InternetAddress[] toEmail, String subject, String text,
			String contentType) {

		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);

		if (!host.equals("localhost")) {
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", 465);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", host);
		}

		// .Session.getDefaultInstance(props) 첨부파일과같이 발송될 경우 에러
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		MimeMessage msg = new MimeMessage(session);

		try {
			// 편지보낸시간
			msg.setSentDate(new Date());
			msg.setFrom(new InternetAddress(fromEmail, nickname));
			// 이메일 수신자
			// InternetAddress to = new InternetAddress(toEmail);
			// msg.setRecipient(Message.RecipientType.TO, to);

			msg.addRecipients(Message.RecipientType.TO, toEmail);

			// 이메일 제목
			msg.setSubject(subject, "UTF-8");
			// 이메일 내용
			msg.setText(text, "UTF-8");

			// 이메일 헤더
			msg.setHeader("content-Type", contentType);

			// 메일보내기
			javax.mail.Transport.send(msg, msg.getAllRecipients());

		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch (MessagingException msg_e) {
			msg_e.printStackTrace();
		} catch (Exception msg_e) {
			msg_e.printStackTrace();
		}

	}

	// 인증키 생성
	public String getKey(int size) {
		this.size = size;
		return getAuthCode();
	}

	// 인증코드 난수 발생
	private String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;

		while (buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}

		return buffer.toString();
	}

	/*
	 * public static void main(String[] args) { MyMailSend sendMail = new
	 * MyMailSend(); sendMail.host = "smtp.gmail.com"; sendMail.username =
	 * "111@gmail.com"; sendMail.password = "";
	 * 
	 * 
	 * String email="111@gmail.com"; String authKey=sendMail.getKey(20);
	 * 
	 * 
	 * //String myURL=sendMail.getRequest().getScheme()+"://"+
	 * sendMail.getRequest().getServerName() +":"+
	 * sendMail.getRequest().getServerPort(); //System.out.println("myURL : "
	 * +myURL);
	 * 
	 * //String myURL=request.getScheme()+"://"+ request.getServerName() +":"+
	 * request.getServerPort();
	 * 
	 * StringBuffer stb=new StringBuffer().append("<h1>[이메일 인증]</h1>")
	 * .append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
	 * .append("<a href='http://localhost:9090/member/signUpConfirm?email=")
	 * .append(email) .append("&authKey=") .append(authKey)
	 * .append("'target='_blenk'>이메일 인증 확인</a>");
	 * 
	 * 
	 * //다른 주소나 별칭으로 메일 보내기 https://support.google.com/mail/answer/22370?hl=ko
	 * String fromEmail="junhoda79@naver.com";
	 * 
	 * //다중 메일 : 수신자 주소 InternetAddress[] addArray = new InternetAddress[1]; try {
	 * addArray[0] = new InternetAddress(email); } catch (Exception e) {
	 * e.printStackTrace(); }
	 * 
	 * //sendMail.emailSend(fromEmail, "홍길동기업", addArray, "메일제목", "메일내용",
	 * "text/html"); sendMail.emailSend(fromEmail, "홍길동기업", addArray, "회원가입 이메일 인증",
	 * stb.toString(), "text/html"); }
	 * 
	 */

}
