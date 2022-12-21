package view.road.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogOutController {

	// 로그 아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		// 세션에 담긴 것을 삭제한다.
		session.invalidate();
		// 리다이렉트 처리로 메인으로 이동시킨다.
		return "redirect:/";
	}

}
