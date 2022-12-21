package view.road.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import view.road.model.vo.UserVO;
import view.road.service.EmailAuthenticationService;

@Controller
@RequestMapping("/emailAuthentication")
public class EmailAuthenticationController {

	
	@Autowired
	private EmailAuthenticationService emailAuthenticationService;
	
	@PostMapping("/send")
	public ResponseEntity<?> emailSend(UserVO userVO, HttpServletRequest request) throws Exception{		
		try {		
			String result= emailAuthenticationService.emailSend(userVO, request);		
			Map<String,Object> map=new HashMap<>();
			map.put("code", "success");
			map.put("emailAuthKey", result);
			
			//이메일 인증키 세션에 저장
			request.getSession().setAttribute("emailAuthKey", result);
			
			return ResponseEntity.status(HttpStatus.OK).body(map);		
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.OK).body("failed");
		}
	}
	
	
	
	
}
