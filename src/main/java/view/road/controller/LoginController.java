package view.road.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {


	@GetMapping("/loginForm")
	public String loginform() throws Exception {
		return "web/auth/login";
	}
	


}
