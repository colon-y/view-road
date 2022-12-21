package view.road.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.enums.Role;
import view.road.model.vo.UserVO;
import view.road.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/join/")
@Slf4j
public class JoinController {

	@Autowired
	private UserService userService;


	@Value("${kakao.appkey}")
	private  String KAKAO_APP_KEY;
	
	@GetMapping("register")
	public String register(Model model) {		
		log.info("회원 가입 폼");
		model.addAttribute("KAKAO_APP_KEY", KAKAO_APP_KEY);
		return "web/auth/register";
	}


	/**
	 * 회원 가입 프로세스
	 * @param userVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@PostMapping("signup")
	@ResponseBody
	public ResponseEntity<String> expertSignup(@RequestBody UserVO userVO, Model model, HttpServletRequest request)throws Exception {
		log.info("회원 가입가입 : {}", userVO.toString());
		
		//이메일 세션 인증확인
		String emailAuthKey=(String)request.getSession().getAttribute("emailAuthKey");
		log.info( " 이메일 인증 완료  : {} , {}", emailAuthKey ,userVO.getEmailAuthKey());
		
		if(userVO==null || emailAuthKey==null || !emailAuthKey.equals(userVO.getEmailAuthKey())) {			
		  return new ResponseEntity<>("이메일 인증 오류", HttpStatus.BAD_REQUEST);
		}
		
		if(userVO.getMembership()!=null && userVO.getMembership().equals("manager")) {
			userVO.setRole(Role.ROLE_MANAGER);	
		}else{
			userVO.setRole(Role.ROLE_USER);
		}
		
		userService.memberJoin(userVO, request, false);	
		//이메일 인증키 세션에 삭제처리
		request.getSession().removeAttribute("emailAuthKey");
		
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	



	// 유저 아이디 중복 체크
	@PostMapping("checkUserId")
	public ResponseEntity<Integer> checkUserId(UserVO userVO, HttpServletResponse response) throws Exception {
		// 아이디 중복 없음 1 중복 있음 0
		return ResponseEntity.status(HttpStatus.OK).body(userService.userGet(userVO));
	}

	// 유저네임 중복 체크
	@PostMapping("checkUsername")
	@ResponseBody
	public ResponseEntity<Integer> checkUsername(UserVO userVO, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.userGetUsername(userVO));
	}

	@PostMapping("emailDbCheck")
	@ResponseBody
	public ResponseEntity<Integer> checkEmail(String email, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.emailDbCheck(email));
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
	public ResponseEntity<Integer> checkPhone(String phone, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.phoneDbCheck(phone));
	}
	
	/**
	 * 닉네임 중복 체크
	 * @param username
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@PostMapping("usernameDbCheck")
	@ResponseBody
	public ResponseEntity<Integer> usernameDbCheck(String username, HttpServletResponse response) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(userService.usernameDbCheck(username));
	}
	
	
	

}
