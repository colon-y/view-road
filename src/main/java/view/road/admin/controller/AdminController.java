package view.road.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {
	
	
	@GetMapping(value = { "", "/" })
	public String index(Model model) {
		model.addAttribute("menuName", "관리자 메인화면");
		return "admin/main";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void adminMainGET(Model model) throws Exception {
		model.addAttribute("menuName", "관리자 메인화면");
		log.info("관리자 페이지 이동");
	}
	
}
