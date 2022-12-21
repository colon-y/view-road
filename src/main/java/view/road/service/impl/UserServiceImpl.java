package view.road.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import view.road.model.dao.mapper.UserMapper;
import view.road.model.vo.UserVO;
import view.road.service.UserService;
import view.road.util.config.IpAddress;
import view.road.util.config.PageMakerAndSearch;

@Service
public class UserServiceImpl implements UserService {

	// UserMapper 객체를 의존성 주입시킨다.
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private PasswordEncoder passwordEncoder;


	// 아이디 중복 체크 -> UserMapper 로 이동후 처리 된다
	@Override
	public Integer userGet(UserVO userVO) throws Exception {
		return userMapper.userGet(userVO);
	}

	// 유저명 중복 체크 -> UserMapper 로 이동후 처리 된다
	@Override
	public Integer userGetUsername(UserVO userVO) throws Exception {
		return userMapper.userGetUsername(userVO);
	}

	// 유저 가입 생성 -> UserMapper 로 이동후 처리 된다
	@Override
	public void userCreate(UserVO userVO) throws Exception {
		userMapper.userCreate(userVO);
	}

	// 유저 로그인 -> UserMapper 로 이동후 처리 된다
	@Override
	public UserVO userLoginIdPw(UserVO userVO) throws Exception {
		return userMapper.userLoginIdPw(userVO);
	}

	/**
	 * 관리자
	 */	
	@Transactional
	@Override
	public void memberJoin(UserVO userVO, HttpServletRequest request, boolean isAdmin) throws Exception {
		/**
		 * if(!isAdmin) { //관리자에서 등록한 것이 아니면 이메일 전송
		 * 
		 * SmtpVO smtpVO=smtpMapper.getSmtpInfo(1); mailSend.setHost(smtpVO.getHost());
		 * mailSend.setUsername(smtpVO.getUsername());
		 * mailSend.setPassword(smtpVO.getPassword()); String
		 * emailName=smtpVO.getEmailName();
		 * 
		 * 
		 * String toEmail=userVO.getEmail(); String emailAuthKey=mailSend.getKey(20);
		 * 
		 * String myURL=request.getScheme()+"://"+ request.getServerName() +":"+
		 * request.getServerPort(); StringBuffer stb=new StringBuffer().append("
		 * <h1>[이메일 인증]</h1>") .append("
		 * <p>
		 * 아래 링크를 클릭하시면 이메일 인증이 완료됩니다.
		 * </p>
		 * ") .append("<a href='"+myURL+"/signUpConfirm?email=") .append(toEmail)
		 * .append("&authKey=") .append(emailAuthKey) .append("'target='_blenk'>이메일 인증
		 * 확인</a>");
		 * 
		 * //다른 주소나 별칭으로 메일 보내기 https://support.google.com/mail/answer/22370?hl=ko
		 * String fromEmail=toEmail; //다중 메일 : 수신자 주소 InternetAddress[] addArray = new
		 * InternetAddress[1]; try { addArray[0] = new InternetAddress(toEmail); } catch
		 * (Exception e) { e.printStackTrace(); }
		 * 
		 * //sendMail.emailSend(fromEmail, "홍길동기업", addArray, "메일제목", "메일내용",
		 * "text/html"); mailSend.emailSend(fromEmail, emailName, addArray, "회원가입 이메일
		 * 인증", stb.toString(), "text/html");
		 * 
		 * userVO.setEmailAuthKey(emailAuthKey); }
		 **/
		userVO.setUserColor(null);
		userVO.setIp(IpAddress.getIP(request));
		userVO.setPassword(passwordEncoder.encode(userVO.getPassword()));
		userMapper.memberJoin(userVO);
	}

	@Override
	public int idCheck(String email) throws Exception {
		return userMapper.idCheck(email);
	}

	@Override
	public Integer emailDbCheck(String email) throws Exception {
		return userMapper.emailDbCheck(email);
	}

	@Override
	public UserVO memberLogin(UserVO member) throws Exception {
		return userMapper.memberLogin(member);
	}

	@Override
	public int getTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return userMapper.getTotalCount(pageMaker);
	}

	@Override
	public List<UserVO> memberList(PageMakerAndSearch pageMaker) throws Exception {
		return userMapper.memberList(pageMaker);
	}

	@Override
	public UserVO memberInfo(int uid) throws Exception {
		return userMapper.memberInfo(uid);
	}

	@Override
	public void memberDelete(int uid) throws Exception {
		userMapper.memberDelete(uid);
	}

	@Override
	public void memberUpdate(UserVO userVO,HttpServletRequest request) throws Exception {
		if(userVO.getPassword()!=null && !userVO.getPassword().equals("")) {
			userVO.setPassword(passwordEncoder.encode(userVO.getPassword()));	
		}	
		userVO.setIp(IpAddress.getIP(request));
		userMapper.memberUpdate(userVO);
	}

	@Override
	public UserVO findByEmail(String email) throws Exception {
		return userMapper.findByEmail(email);
	}

	@Override
	public void guestUpdateRole(String email) throws Exception {
		userMapper.guestUpdateRole(email);
	}

	
	@Override
	public List<UserVO> getManagerList() throws Exception {
		return userMapper.getManagerList();
	}

	@Override
	public Integer phoneDbCheck(String phone) throws Exception {
		return userMapper.phoneDbCheck(phone);
	}

	
	@Override
	public Integer usernameDbCheck(String username) throws Exception {
		return userMapper.usernameDbCheck(username);
	}

	
	@Override
	public Integer idPhoneCheck(UserVO userVO) throws Exception {
		return userMapper.idPhoneCheck(userVO);
	}

	@Override
	public int findEmailPassword(UserVO userVO) throws Exception {
		return userMapper.findEmailPassword(userVO);
	}

	
	@Override
	public UserVO findByUserId(String userId) throws Exception {
		return userMapper.findByUserId(userId);
	}

	


	

}
