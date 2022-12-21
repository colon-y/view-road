package view.road.admin.controller;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.SmtpVO;
import view.road.model.vo.UserVO;
import view.road.service.SmtpService;
import view.road.service.UserService;
import view.road.util.config.IpAddress;
import view.road.util.config.PageMakerAndSearch;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/member/")
@Slf4j
public class AdminMemberController {

	@Autowired
	private UserService userService;

	@Autowired
	private SmtpService smtpService;

	@Value("${kakao.appkey}")
	private String KAKAO_APP_KEY;
	


	/**
	 * 회원목록
	 * 
	 * @param pageMaker
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "memberList")
	public String memberList(PageMakerAndSearch pageMaker, Model model) throws Exception {
		log.info(" memberList ==>  {}", pageMaker.toString());

		pageMaker.setTotalCount(userService.getTotalCount(pageMaker));
		model.addAttribute("menuName", "회원관리");
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", userService.memberList(pageMaker));
		return "admin/member/member_list";
	}

	/**
	 * 회원상세보기
	 * 
	 * @param uid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "memberInfo")
	public String memberInfo(int uid, Model model) throws Exception {
		model.addAttribute("menuName", "회원관리");
		model.addAttribute("memberInfo", userService.memberInfo(uid));
		return "admin/member/member_info";
	}

	// 아이디 중복 검사
	@RequestMapping(value = "memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPost(String userId) throws Exception {
		log.info(" 아이디 중복 검사 :  {} ", userId);
		int result = userService.idCheck(userId);
		if (result != 0)
			return "fail";
		else
			return "success";
	}

	// 이메일 중복 검사
	@RequestMapping(value = "memberEmailChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberEmailChk(String email) throws Exception {
		int result = userService.emailDbCheck(email);
		if (result != 0)
			return "fail";
		else
			return "success";
	}

	/**
	 * 회원 삭제
	 * 
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "member/memberDelete")
	public String memberDelete(int uid) throws Exception {
		userService.memberDelete(uid);
		return "redirect:memberList";
	}

	/**
	 * 회원 등록 및 수정 화면
	 * 
	 * @param type
	 * @param uid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "memberWrite")
	public String memberWrite(String type, Integer uid, Model model) throws Exception {

		if (type != null && type.equals("update") && uid != null) {
			model.addAttribute("memberInfo", userService.memberInfo(uid));
		}
		model.addAttribute("KAKAO_APP_KEY", KAKAO_APP_KEY);
		model.addAttribute("menuName", "회원관리");
		model.addAttribute("type", type);
		return "admin/member/member_write";
	}

	/**
	 * 회원 등록
	 * 
	 * @param userVo
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "memberCreate")
	public String memberCreate(UserVO userVo, HttpServletRequest request) throws Exception {
		log.info(" 회원 등록 :  {}", userVo.toString());
		
		userService.memberJoin(userVo, request, true);
		return "redirect:memberList";
	}

	/**
	 * 회원 수정
	 * 
	 * @param userVo
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "memberUpdate")
	public String memberUpdate(UserVO userVo, HttpServletRequest request) throws Exception {
		userVo.setIp(IpAddress.getIP(request));
		userService.memberUpdate(userVo, request);
		return "redirect:memberList";
	}

	@GetMapping("smtpUpdate")
	public String smtpUpdateForm(Model model) throws Exception {
		SmtpVO smtpVO = smtpService.getSmtpInfo(1);
		model.addAttribute("smtpVO", smtpVO);
		model.addAttribute("menu", "smtpUpdate");
		return "admin/smtp/smtp_update";
	}

	@PostMapping("smtpUpdate")
	@ResponseBody
	public ResponseEntity<Integer> smtpUpdate(@RequestBody SmtpVO smtpVO, Model model) throws Exception {
		return ResponseEntity.status(HttpStatus.OK).body(smtpService.smtpUpdate(smtpVO));
	}

}
