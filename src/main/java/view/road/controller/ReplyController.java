package view.road.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import view.road.model.vo.ReplyVO;
import view.road.model.vo.UserVO;
import view.road.service.ReplyService;
import view.road.util.config.PageMakerAndSearch;

@Controller
@RequestMapping("/board/replies/")
public class ReplyController {

	@Autowired
	private ReplyService service;


	/**
	 *  등록
	 * @param replyVO
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="create", method=RequestMethod.POST)
	public ResponseEntity<?> register(ReplyVO replyVO, HttpSession session, HttpServletRequest request) throws Exception {
		ReplyVO vo = ReplyVO.setting(replyVO, session, request);
		if(vo==null)return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
		service.createBoard(vo);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	

	// 해당게시판 답변 목록 전체 불러오기
	@RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public String list(@PathVariable("bno") Integer bno, @RequestParam String boardType, @RequestParam int page, PageMakerAndSearch pageMaker,  Model model) throws Exception {
		pageMaker.setPage(page);
		pageMaker.setBno(bno);
		pageMaker.setPerPageNum(5);
		int totalCount=service.replyTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);				
		List<ReplyVO> replyList = service.listAllReplyVO(pageMaker);
		String pagination = pageMaker.replyPagination("/board/replies/all/"+bno);
				
		for (ReplyVO vo : replyList) {
			if(vo.getContent()!=null) {
				String str = vo.getContent().replaceAll("\n", "<br>");
				vo.setContent(str);				
			}
		}

		model.addAttribute("replyLpagination", pagination); 
		model.addAttribute("replyLpageMaker", pageMaker); 
		model.addAttribute("replyLtotalCount", totalCount); 
		model.addAttribute("replyList", replyList);
		return "web/"+boardType+"/replyList";
	}

	// 로그인한 유저 삭제 처리
	@DeleteMapping(value = "/delete/{rno}")
	public ResponseEntity<?> remove(@PathVariable("rno") Integer rno, HttpSession session) throws Exception {

		UserVO user = (UserVO) session.getAttribute("USER");
		// 체크 삭제 대상과 작성자와 일치 확인
		ReplyVO replyVO = service.getRnoInfo(rno);
		boolean isAdmin = (boolean) session.getAttribute("isAdmin");
		if (user.getUid().equals(replyVO.getUid()) || isAdmin) {

			try {
				// DB 에 삭제 처리한다
				service.deleteBoard(rno);
				// 응답 처리로 SUCCESS 를 반환 하면 헤더에 OK
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				// 응답 처리로 에러 메시지를 반환 하면 헤더에 BAD_REQUEST
				return  new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			}
			// 응답 처리로 FAIL를 반환 하면 헤더에 BAD_REQUEST
		} else
			return new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
	}

	
	@RequestMapping(value = "removePassowrd/{rno}", method = RequestMethod.POST)
	public ResponseEntity<String> removePassowrd(@PathVariable("rno") Integer rno, ReplyVO replyVO, HttpSession session)
			throws Exception {
		ResponseEntity<String> entity = null;

		// 체크 삭제 대상과 작성자와 일치 확인
		Integer resultCount = service.getPasowrdConfirm(replyVO);

		if (resultCount == 1) {
			try {
				service.removePassowrd(replyVO);
				// 응답 처리로 SUCCESS 를 반환 하면 헤더에 OK
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				// 응답 처리로 에러 메시지를 반환 하면 헤더에 BAD_REQUEST
				entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			}
			// 응답 처리로 FAIL를 반환 하면 헤더에 BAD_REQUEST
		} else
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);

		return entity;
	}
	
	
	/**
	 * 업데이트
	 * @param replyVO
	 * @param session
	 * @param request
	 * @return
	 */
	@PutMapping(value = "update")
	public ResponseEntity<?> updateReply(ReplyVO replyVO, HttpSession session, HttpServletRequest request) throws Exception{		
		ReplyVO vo = ReplyVO.setting(replyVO, session, request);
		if(vo==null) return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
		service.updateReply(vo);
		return new ResponseEntity<String>("success", HttpStatus.OK);		
	}

	
	
}
