package view.road.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.NoteVO;
import view.road.service.NoteService;
import view.road.util.config.PageMakerAndSearch;

@Controller
@RequestMapping("/admin/note")
public class AdminNoteController {

	
	@Autowired
	private NoteService noteService;
	
	@GetMapping("receiveList")
	public String listNote(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model)  throws Exception{
		
		pageMaker.setPerPageNum(10);
		int totalCount=noteService.noteReceiveAdminTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<NoteVO>  receiveList=noteService.listNoteAdminReceive(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/admin/note/receiveList");
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("menuName", "쪽지관리");
		return "admin/note/note_list";
	}
	
	
	/** 유저별 목록 
	 * groupMessgeList
	 * @param pageMaker
	 * @param principalDetails
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("adminGroupMessgeList")
	public String groupMessgeList(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model)  throws Exception{
		
		pageMaker.setPerPageNum(10);
		int totalCount=noteService.adminGroupMessgeListTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<NoteVO>  adminGroupMessgeList=noteService.adminGroupMessgeList(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/admin/note/adminGroupMessgeList");
		model.addAttribute("adminGroupMessgeList", adminGroupMessgeList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("menuName", "쪽지관리");
		return "admin/note/note_group_List";
	}
	
	
	
	@GetMapping("read/{noteId}")
	public String readNote(@PathVariable Long noteId, NoteVO noteVO, String group, 
			@AuthenticationPrincipal PrincipalDetails principalDetails,  Model model) throws Exception{		

		model.addAttribute("group", group);
		model.addAttribute("sendId", noteVO.getSendId());
		model.addAttribute("receiveId", noteVO.getReceiveId());
		
		NoteVO  noteInfo=noteService.readNote(noteVO);			
		model.addAttribute("menuName", "쪽지관리");
		model.addAttribute("noteInfo", noteInfo);		
		return "admin/note/note_read";
	}

	
	/**
	 * 메시지 대화목록
	 * @param noteId
	 * @param noteVO
	 * @param principalDetails
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("messageList")
	public String messageList(
		NoteVO noteVO,   @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model) throws Exception{		

		
		noteVO.setMyId(noteVO.getReceiveId());
		noteVO.setOtherId(noteVO.getSendId());
		List<NoteVO>  messageList=noteService.messageList(noteVO);		
		model.addAttribute("messageList",messageList);				
		return "admin/note/note_message_list";
	}

	
	/**
	 * 개별 숨김처리
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("hideNote")
	public ResponseEntity<?> hideNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveName("admin");
		noteService.deleteNote(noteVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	/**
	 * 개별 실질적인 삭제처리
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteRealNote")
	public ResponseEntity<?> deleteRealNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveName("admin");
		noteService.deleteRealNote(noteVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
	
	/** 개별 선택 삭제
	 * 
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteMyNote")
	public ResponseEntity<?> deleteMyNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveName("admin");
		noteService.deleteMyNote(noteVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
		
	
	
	/**
	 * 전체 선택 숨김 처리
	 *
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("hideSelect")
	public ResponseEntity<?> hideSelect(@RequestParam List<Integer>  noteId,NoteVO noteVO) throws Exception{
		noteVO.setReceiveName("admin");
		for(Integer no : noteId) {
			noteVO.setNoteId(no);
			noteService.deleteNote(noteVO);
		}
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
	/**전체 선택 실질적인 삭제 처리
	 * 
	 * @param noteId
	 * @param noteVO
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteRealSelect")
	public ResponseEntity<?> deleteRealSelect(@RequestParam List<Integer>  noteId,NoteVO noteVO) throws Exception{
		noteVO.setReceiveName("admin");
		for(Integer no : noteId) {
			noteVO.setNoteId(no);
			noteService.deleteRealNote(noteVO);
		}
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
	
	
	
	
	
	
	/**
	 *  그룹삭제
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteGroupNote")
	public ResponseEntity<?> deleteGroupNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		noteService.deleteGroupNote(noteVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	 /**그룹 선택 삭제
	 * 
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteSelectGroup")
	public ResponseEntity<?> deleteSelectGroup(@RequestParam List<Integer>  sendId,
			NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{	
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		for(Integer no : sendId) {
			noteVO.setSendId(no);
			noteService.deleteGroupNote(noteVO);
		}		
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
}
