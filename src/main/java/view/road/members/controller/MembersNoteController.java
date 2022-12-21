package view.road.members.controller;

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
@RequestMapping("/members/note")
public class MembersNoteController {

	
	@Autowired
	private NoteService noteService;
	
	@GetMapping("receiveList")
	public String listNote(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model)  throws Exception{
		
		pageMaker.setUid(principalDetails.getUser().getUid());	
		pageMaker.setPerPageNum(10);
		int totalCount=noteService.noteReceiveTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<NoteVO>  receiveList=noteService.listNoteReceive(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/members/note/receiveList");
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("totalCount", totalCount);		
		model.addAttribute("menuName", "note");
		return "members/note/note_list";
	}
	
	
	/** 유저별 목록 
	 * groupMessgeList
	 * @param pageMaker
	 * @param principalDetails
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("groupMessgeList")
	public String groupMessgeList(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model)  throws Exception{
		
		pageMaker.setUid(principalDetails.getUser().getUid());	
		pageMaker.setPerPageNum(10);
		int totalCount=noteService.groupMessgeListTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<NoteVO>  groupMessgeList=noteService.groupMessgeList(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/members/note/groupMessgeList");
		model.addAttribute("groupMessgeList", groupMessgeList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("menuName", "note");
		return "members/note/note_group_List";
	}
	
	
	
	@GetMapping("read/{noteId}")
	public String readNote(@PathVariable Long noteId, NoteVO noteVO,  
			@AuthenticationPrincipal PrincipalDetails principalDetails,  Model model) throws Exception{		
		noteVO.setReceiveId(principalDetails.getUser().getUid());	
		noteService.updateReadCnt(noteVO);	
		NoteVO  noteInfo=noteService.readNote(noteVO);		
		model.addAttribute("menuName", "note");
		model.addAttribute("noteInfo", noteInfo);		
		return "members/note/note_read";
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
		noteVO.setReceiveId(principalDetails.getUser().getUid());	
		
		// 	
		noteService.updateTotalReadCnt(noteVO);	
		
		noteVO.setMyId(principalDetails.getUser().getUid());
		noteVO.setOtherId(noteVO.getSendId());
		List<NoteVO>  messageList=noteService.messageList(noteVO);		
		model.addAttribute("messageList",messageList);				
		return "members/note/note_message_list";
	}

	
	/**
	 * 개별 삭제
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteNote")
	public ResponseEntity<?> deleteNote(NoteVO noteVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		noteService.deleteNote(noteVO);
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
		noteVO.setSendId(principalDetails.getUser().getUid());
		noteService.deleteMyNote(noteVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
		
	
	
	/**
	 * 전체 선택 삭제
	 * @param scno
	 * @param noteVO
	 * @param principalDetails
	 * @return
	 * @throws Exception
	 */
	@DeleteMapping("deleteSelect")
	public ResponseEntity<?> deleteSelect(@RequestParam List<Integer>  noteId,
			NoteVO noteVO,  @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		noteVO.setReceiveId(principalDetails.getUser().getUid());
		for(Integer no : noteId) {
			noteVO.setNoteId(no);
			noteService.deleteNote(noteVO);
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
