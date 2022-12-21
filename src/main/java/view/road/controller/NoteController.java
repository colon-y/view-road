package view.road.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.NoteVO;
import view.road.service.NoteService;

@Controller
@RequestMapping("/note/")
public class NoteController {

	@Autowired
	private NoteService noteService;

	@Value("${noticeCount.setInterval}")
	private String NOTICE_COUNT_SETINTERVAL;
	

	@PostMapping(value="send")
	public ResponseEntity<?> sendNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception {
		noteVO.setSendId(principalDetails.getUser().getUid());
		noteService.insertNote(noteVO);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	
	
	
	@PostMapping(value="noticeCount")
	public ResponseEntity<?> noticeCount(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) throws Exception {
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		int noticeCount = noteService.noticeCount(noteVO);
		Map<String, Object> map=new HashMap<>();
		map.put("NOTICE_COUNT_SETINTERVAL", NOTICE_COUNT_SETINTERVAL);
		map.put("noticeCount" ,noticeCount);
		return  ResponseEntity.status(HttpStatus.OK).body(map);
	}

	
	@PostMapping(value="notificationMessage")
	public String notificationMessage(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) throws Exception {
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		List<NoteVO> notificationMessage= noteService.notificationMessage(noteVO);
		model.addAttribute("notificationMessage", notificationMessage);
		return  "web/lib/notificationMessage";
	}
	
	
	
	@PostMapping(value="notificationMyPage")
	public String notificationMyPage(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) throws Exception {
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		List<NoteVO> notificationMessage= noteService.notificationMessage(noteVO);
		model.addAttribute("notificationMessage", notificationMessage);
		return  "members/lib/notificationMyPage";
	}
	
	/**
	 * 관리자 알림
	 * @param noteVO
	 * @param principalDetails
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value="notificationAdminPage")
	public String notificationAdminPage(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) throws Exception {
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		List<NoteVO> notificationMessage= noteService.notificationMessage(noteVO);
		model.addAttribute("notificationMessage", notificationMessage);
		return  "admin/lib/notificationAdminPage";
	}
	
	
	
	
}
