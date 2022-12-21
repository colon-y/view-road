package view.road.members.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.UserVO;
import view.road.service.UserService;

@Controller
@RequestMapping("/members/profile")
public class MembersProfileController {

	
	@Autowired
	private UserService userService;

	
	@Value("${kakao.appkey}")
	private String KAKAO_APP_KEY;
	
	
	/**
	 * 회원정보
	 * 
	 * @param uid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = {"" ,"/"})
	public String profile(@AuthenticationPrincipal PrincipalDetails principalDetails, Model model) throws Exception {
		model.addAttribute("memberInfo", userService.memberInfo(principalDetails.getUser().getUid()));
		model.addAttribute("menuName", "member");
		return "members/profile/profile_info";
	}
	
	
	
	/**
	 * 회원 탈퇴
	 * 
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/memberDelete")
	public String memberDelete(@AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception {
		userService.memberDelete(principalDetails.getUser().getUid());
		return "redirect:/logout";
	}
	
	
	
	/**
	 * 회원수정 화면
	 * 
	 * @param type
	 * @param uid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "updateForm")
	public String updateForm(@AuthenticationPrincipal PrincipalDetails principalDetails , String type, Model model) throws Exception {

		model.addAttribute("memberInfo", userService.memberInfo(principalDetails.getUser().getUid()));
		model.addAttribute("KAKAO_APP_KEY", KAKAO_APP_KEY);
		model.addAttribute("type", type);	
		model.addAttribute("menuName", "member");
		return "members/profile/updateForm";
	}
	
	
	

	/**
	 * 회원 업데이트 처리
	 * 
	 * @param userVo
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value = "/updateMember")
	public String updateMember(UserVO userVo, @AuthenticationPrincipal PrincipalDetails principalDetails,
			HttpServletRequest request,  RedirectAttributes rttr) throws Exception {		
		userVo.setUserId(null);
		userVo.setEmail(null);
		userVo.setUid(principalDetails.getUser().getUid());
		userService.memberUpdate(userVo, request);
		
		//세션 업그레이드 처리
		UserVO userEntitiy=userService.findByUserId(principalDetails.getUser().getUserId());		
		request.getSession().setAttribute("USER", userEntitiy);
		rttr.addFlashAttribute("msg", "업데이트 처리 되었습니다.");
		return "redirect:/members/profile";
	}
	
	
	
	
	
}
