package view.road.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.SmtpVO;
import view.road.service.SmtpService;

@Controller
@RequestMapping("/admin")
public class AdminSMTPController {

	@Autowired
	private SmtpService smtpService;

	@GetMapping("/smtpUpdate")
	public String smtpUpdateForm(Model model) throws Exception {
		SmtpVO smtpVO = smtpService.getSmtpInfo(1);
		model.addAttribute("smtpVO", smtpVO);
		model.addAttribute("menu", "smtpUpdate");
		return "admin/smtp/smtp_update";
	}

	@PostMapping("/smtpUpdate")
	@ResponseBody
	public ResponseEntity<Integer> smtpUpdate(@RequestBody SmtpVO smtpVO, Model model) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(smtpService.smtpUpdate(smtpVO));
	}

}
