package view.road.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.UserVO;
import view.road.service.EmailAuthenticationService;
import view.road.service.UserService;

@Controller
@RequestMapping("/findIdPassword/")
public class FindIdOrPasswordController {

	@Autowired
	private UserService userService;

	
	@Autowired
	private EmailAuthenticationService emailAuthenticationService;
	
	
	@GetMapping("findId")
	public String findId() throws Exception {
		return "web/auth/findId";
	}

	
	
	@GetMapping("findPassword")
	public String findIdPassword() throws Exception {
		return "web/auth/findPassword";
	}

	
	/**
	 * 휴대폰 번호 체크
	 * @param phone
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@PostMapping("phoneDbCheck")
	@ResponseBody
	public ResponseEntity<?> checkPhone(String phone, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.phoneDbCheck(phone));
	}
	
	
	/**
	 * 이메일 체크
	 * @param email
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@PostMapping("emailDbCheck")
	@ResponseBody
	public ResponseEntity<?> emailDbCheck(String email, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.emailDbCheck(email));
	}
	
	
	/**
	 * 이메일로 아이디 발송
	 * @param email
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@PostMapping("sendId")
	@ResponseBody
	public ResponseEntity<?> sendId(UserVO userVO, HttpServletRequest request) throws Exception {
		UserVO user=userService.findByEmail(userVO.getEmail());
		String result=emailAuthenticationService.emailSendId(user, request);		
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	
	
	
	
	/**
	 * 아이디와 휴대폰번호 체크
	 * @param userVO
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@PostMapping("idPhoneCheck")
	@ResponseBody
	public ResponseEntity<?> idPhoneCheck(UserVO userVO) throws Exception {
		int cnt=userService.idPhoneCheck(userVO);		
		return ResponseEntity.status(HttpStatus.OK).body(cnt);
	}
	
	
	
	
	/**
	 * 아이디와 이메일로 체크
	 * @param userVO
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@PostMapping("findEmailPassword")
	@ResponseBody
	public ResponseEntity<?> findEmailPassword(UserVO userVO) throws Exception {
		int cnt=userService.findEmailPassword(userVO);		
		return ResponseEntity.status(HttpStatus.OK).body(cnt);
	}
	
	
	
	/**
	 * 이메일로 임시 비밀번호 전송
	 * @param userVO
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@PostMapping("emailSendPassword")
	@ResponseBody
	public ResponseEntity<?> emailSendPassword(UserVO userVO, HttpServletRequest request) throws Exception {
		UserVO user=userService.findByEmail(userVO.getEmail());
		String result=emailAuthenticationService.emailSendPassword(user ,request);		
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
	
	
	
	
}
