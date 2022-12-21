package view.road.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import view.road.config.auth.PrincipalDetails;
import view.road.model.enums.Role;
import view.road.model.vo.BoardVO;
import view.road.model.vo.UserVO;
import view.road.service.BoardService;
import view.road.service.UserService;

@Controller
@Slf4j
public class HomController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private UserService userService;

	
	@Value("${aladin.key}")
	private String ALADIN_KEY ;
	
	@RequestMapping(value = "/")
	public String index(@AuthenticationPrincipal PrincipalDetails userDetails, BoardVO boardVO, Model model, HttpSession session,
			HttpServletRequest request) throws Exception {
		if (userDetails != null) {
			log.info("로그인 정보 userDetails :  {} " + userDetails.getUser());
		}

		
		List<BoardVO> dailyBestList=boardService.dailyBestList();	 //일간베스트							
		List<BoardVO> weeklyBestList=boardService.weeklyBestList();		//주간베스트				
		List<BoardVO> monthlyBestList=boardService.monthlyBestList();//월간베스트
				
		//Q&A 목록 가져오기
		boardVO.setBoardType("qna");
		List<BoardVO> qnaList = boardService.getMainQnaList();
		
		//Q&A 목록 가져오기
		boardVO.setBoardType("free");
		List<BoardVO> freeList = boardService.getMainfreeList();
		
		
		if(dailyBestList.size()==0)dailyBestList=boardService.mainBestList("view"); //조회수
		if(weeklyBestList.size()==0)weeklyBestList=boardService.mainBestList("like"); //조회수
		if(monthlyBestList.size()==0)monthlyBestList=boardService.mainBestList("reply"); //조회수
			
		
		model.addAttribute("dailyBestList", dailyBestList);
		model.addAttribute("weeklyBestList", weeklyBestList);
		model.addAttribute("monthlyBestList", monthlyBestList);
						
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("freeList", freeList);		
		return "web/index";
	}
	

	@GetMapping("/signUpConfirm")
	public String signUpConfirm(String email, String authKey, Model model) throws Exception {
		if (email == null || authKey == null || !StringUtils.hasText(email) || !StringUtils.hasText(authKey))
			return "redirect:/";
		log.info("email : {}, authKey : {}", email, authKey);

		UserVO userVO = userService.findByEmail(email);
		// null 이거나 인증완료된 회원은 로그인폼으로
		if (userVO == null || !userVO.getRole().equals(Role.ROLE_GUEST))
			return "redirect:/loginForm";

		if (userVO.getEmailAuthKey().equals(authKey)) {
			userService.guestUpdateRole(email);
			model.addAttribute("msg", "인증 처리완료 되었습니다.");
		} else {
			model.addAttribute("msg", "인증에 처리에 실패하였습니다.");
		}
		return "web/signUpConfirm";
	}
	
	
	@GetMapping("/phoneCertification")
	public String phoneCertification() throws Exception{
		return "web/lib/phoneCertification";
	}

	

}


