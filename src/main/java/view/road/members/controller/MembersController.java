package view.road.members.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.BoardVO;
import view.road.model.vo.UserVO;
import view.road.service.BoardService;
import view.road.util.config.PageMakerAndSearch;

@Controller
@RequestMapping("/members")
public class MembersController {

	@Autowired
	private BoardService boardService;

	
	@RequestMapping(value={"","/"})
	public String main(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model ) throws Exception {			
		pageMaker.setUid(principalDetails.getUser().getUid());	
		pageMaker.setPerPageNum(15);
		int totalCount=boardService.myBoardTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<BoardVO> myBoardList=boardService.myBoardList(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/members");
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("menuName", "");				
		return "members/main";
	}
	
	
	
	@DeleteMapping("/my/deleteBoard")
	public ResponseEntity<?> deleteNote(BoardVO boardVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		BoardVO boardCheck = boardService.getRead(boardVO);
		UserVO userVO = principalDetails.getUser();
		if (userVO.getUserId().equals(boardCheck.getUserId())) {			
			boardService.remove(boardVO);			
		}			
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	

	
}
