package view.road.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.BoardVO;
import view.road.model.vo.UserVO;
import view.road.service.BoardService;
import view.road.util.config.IpAddress;
import view.road.util.config.PageMakerAndSearch;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board/free/")
@Slf4j
public class BoardFreeController {

	@Autowired
	private BoardService boardService;
	
	@Value("${upload.path}")
	public String uploadDirectory;
	
	@GetMapping("write")
	public String registeForm(@AuthenticationPrincipal PrincipalDetails priDetails, BoardVO boardVO) throws Exception {
		if(priDetails==null)return "redirect:/";				
		return "web/board_free/write";
	}

	// 등록
	@PostMapping("write")
	public String registe(@AuthenticationPrincipal PrincipalDetails priDetails, @Valid BoardVO boardVO,
			@RequestParam(required = false, name="uploadfile" ) MultipartFile[] uploadfile,
			BindingResult bindingResult, Model model, HttpServletRequest request) throws Exception {
		if(priDetails==null)return "redirect:/";		

		boardVO.setBoardType("free");		
		boardVO.setUserId(priDetails.getUser().getUserId());
		if (bindingResult.hasErrors()) {
			return "web/board_free/write";
		}

		if (boardVO.getImgCnt() == null) {
			boardVO.setImgCnt(0);
		}

		boardVO.setIp(IpAddress.getIP(request));
		boardVO.setting();
		
		if(uploadfile!=null) {
			StringBuilder uploadedFileName = new StringBuilder();
			for (MultipartFile file : uploadfile) {
				try {
					log.info("*** file.getOriginalFilename() : ", file.getOriginalFilename());
					if(file.getOriginalFilename()!=null && StringUtils.hasText(file.getOriginalFilename())) {
						uploadedFileName.append(FileUploadController.uploadFile(uploadDirectory, file.getOriginalFilename(), file.getBytes(), null));
						if(uploadedFileName!=null) {
							boardVO.setImgCnt(1);
							boardVO.setFileName(uploadedFileName.toString());	
						}	
					}
								
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

				
		// DB에 저장 시킨다.
		boardService.register(boardVO);
		return "redirect:list";
	}

	// 목록
	@GetMapping("list")
	public String getReadList(@AuthenticationPrincipal PrincipalDetails priDetails, PageMakerAndSearch pageMaker,
			BoardVO boardVO, Model model) throws Exception {
		// if(priDetails.getUser().getRole().equals(Role.ROLE_GUEST)) return
		// "redirect:/";

		log.info("페이지 정보  :  {}", pageMaker.toString());
		boardVO.setBoardType("free");
		pageMaker.setBoardType("free");
		// 전체 tbl_board 갯수를 구한다.
		Integer totalCount = boardService.boardTotalCount(pageMaker);

		// 20개의 목록이 출력이 나오도록 처리한다.
		pageMaker.setPerPageNum(15);
		// 페이징은 3개씩 보이도록 처리한다.
		pageMaker.setDisplayPageNum(3);
		// pageMaker 에 전체 갯수를 저장후 계산 처리한다.
		pageMaker.setTotalCount(totalCount);

		List<BoardVO> list = boardService.getReadList(pageMaker);

		String pagination = pageMaker.bootStrapPagingSearchHTML4("/board/free/list");

		model.addAttribute("pagination", pagination); // 페이징 String 담는다
		model.addAttribute("pageMaker", pageMaker); // 페이지 메이커 객체를 담는다.
		model.addAttribute("totalCount", totalCount); // 전체 개수를 구한 totalcount 를 담는다.
		model.addAttribute("list", list); // 목록처리한 List<BoardVO> 객체를 담는다.

		// 추천 1개 이상 최신 데이터 5개 항목 가져오기
		List<BoardVO> likeList = boardService.getReadLikeList(boardVO);
		model.addAttribute("likeList", likeList);

		return "web/board_free/list";
	}

	// 읽기
	@GetMapping("read/{bno}")
	public String getRead(@PathVariable("bno") Integer bno, @AuthenticationPrincipal PrincipalDetails priDetails,
			BoardVO boardVO, Model model) throws Exception {
		if(priDetails!=null) {
			boardVO.setUid(priDetails.getUser().getUid());			
		}
				
		boardService.viewCntAdd(boardVO);
		BoardVO board =boardService.getRead(boardVO);
		if(board.getBoardType()==null|| !board.getBoardType().equals("free")) return "redirect:/";
		model.addAttribute("boardVO", board);
		return "web/board_free/read";
	}

	// 게시글 상세보기 하단에 게시글을 리스트로 보여줄 것이다.
	@GetMapping("inlist")
	public String inlist(PageMakerAndSearch pageMaker,  BoardVO boardVO, @RequestParam String bno,
			@RequestParam(defaultValue="1", required = false) String page, Model model) throws Exception {
		boardVO.setBoardType("free");
		pageMaker.setBoardType("free");
		Integer totalCount = boardService.boardTotalCount(pageMaker);

		pageMaker.setPage(Integer.parseInt(page));
		pageMaker.setPerPageNum(15);
		pageMaker.setDisplayPageNum(3);
		pageMaker.setTotalCount(totalCount);

		List<BoardVO> list = boardService.getReadList(pageMaker);

		String pagination = pageMaker.inListPagination("/board/free/inlist/");

		model.addAttribute("pagination", pagination); // 페이징 String 담는다
		model.addAttribute("pageMaker", pageMaker); // 페이지 메이커 객체를 담는다.
		model.addAttribute("totalCount", totalCount); // 전체 개수를 구한 totalcount 를 담는다.
		model.addAttribute("list", list); // 목록처리한 List<BoardVO> 객체를 담는다.
		model.addAttribute("bno", bno);
		
		// 추천 1개 이상 최신 데이터 5개 항목 가져오기
		List<BoardVO> likeList = boardService.getReadLikeList(boardVO);
		model.addAttribute("likeList", likeList);

		return "web/board_free/inlist";
	}

	
	
	@PostMapping("boardEdit")
	public String boardEdit(@AuthenticationPrincipal PrincipalDetails priDetails, BoardVO boardVO, 
			HttpServletResponse response, Model model) throws Exception {
		//if (priDetails == null || !priDetails.isWriteAdminAndManagerEnabled())return "redirect:/";	
						
		// 비밀번호 재 확인
		log.info("작성한 게시판 업데이트 폼  {}", boardVO.toString());
		if (boardService.passwordConfirm(boardVO) == 1) {
			// 업데이트 폼으로 이동
			BoardVO getBoard = boardService.getRead(boardVO);
			model.addAttribute("boardVO", getBoard);
			return "web/board_free/update";
		} else {
			return "redirect:/";
		}
	}
	
	

	@PostMapping("boardEditDirect")
	public String boardEditDirect(BoardVO boardVO, HttpSession session, Model model) throws Exception {		
		// 보안 체크
		BoardVO getBoard = boardService.getRead(boardVO);
		UserVO userVO = (UserVO) session.getAttribute("USER");
		boolean isAdmin = (boolean) session.getAttribute("isAdmin");

		if (userVO.getUserId().equals(getBoard.getUserId()) || isAdmin) {
			model.addAttribute("boardVO", getBoard);
			return "web/board_free/update";
		}
		return "redirect:/";
	}
	
	

	@PostMapping("removeDirect")
	public void removeDirect(BoardVO boardVO, HttpSession session, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();

		// 다시 한번 서버에서 보안 체크를 한다 tbl_board 에서 해당 번호로 정보를 가져온다
		BoardVO boardCheck = boardService.getRead(boardVO);
		// 세션에 담긴 유저 객체를 정보를 UserVO 에 넣는다.
		UserVO userVO = (UserVO) session.getAttribute("USER");
		// 세션에 담김 객체와 해당글을 작성한 유저가 동일인지 체크를 한다.
		boolean isAdmin = (boolean) session.getAttribute("isAdmin");
		if (userVO.getUserId().equals(boardCheck.getUserId()) || isAdmin) {
			// 동일할 경우 DB 에서 제거 처리를 한다
			boardService.remove(boardVO);
			// 에러가 없을 경우 ajax 에 SUCCESS 를 반환 시킨다.
			out.print("SUCCESS");
		} else {
			// 동일하지 않거나 에러가 있을시 fail 을 ajax 에 반환 시켜 준다.
			out.print("fail");
		}
	}

	@PostMapping("remove")
	public void remove(BoardVO boardVO, HttpSession session, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		if (boardService.passwordConfirm(boardVO) == 1) {
			boardService.remove(boardVO);
			out.print("SUCCESS");
		} else {
			out.print("fail");
		}
	}

	// 변경
	@PostMapping("update")
	public String boardUpdate(@AuthenticationPrincipal PrincipalDetails priDetails,
			@RequestParam(required = false, name = "uploadfile") MultipartFile[] uploadfile, BoardVO boardVO) throws Exception {
	
		BoardVO getBoard = boardService.getRead(boardVO);
		// 로그인한 유저가 작성자 같거나 관리자계정인 경우 변경 허용
		if (getBoard.getUserId().equals(priDetails.getUser().getUserId())
				|| priDetails.isWriteAdminAndManagerEnabled()) {

			log.info(" update   {} ", boardVO.toString());
			
					
			if(uploadfile!=null) {
				StringBuilder uploadedFileName = new StringBuilder();
				for (MultipartFile file : uploadfile) {
					try {
						log.info("*** file.getOriginalFilename() : ", file.getOriginalFilename());
						if(file.getOriginalFilename()!=null && StringUtils.hasText(file.getOriginalFilename())) {
							uploadedFileName.append(FileUploadController.uploadFile(uploadDirectory, file.getOriginalFilename(), file.getBytes(), null));
							if(uploadedFileName!=null) {
								boardVO.setImgCnt(1);
								boardVO.setFileName(uploadedFileName.toString());	
							}	
						}							
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			
			
			// boardVO.setting() 의 메서드를 통해 xss 제목과 작성자에서 스크립트 제거 처리를 한다.
			boardVO.setting();
			boardService.boardUpdate(boardVO);
			return "redirect:read/" + boardVO.getBno();

		} else
			return "redirect:/";

	}

	@PostMapping("passwordConfirm")
	public void passwordConfirm(BoardVO boardVO, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		// 카운터 갯수를 반환 시킨다.
		out.print(boardService.passwordConfirm(boardVO));
	}

	@GetMapping("besetLike")
	public String besetLike(Model model, BoardVO boardVO) throws Exception {		
		// 추천 1개 이상 최신 데이터 5개 항목 가져오기
		boardVO.setBoardType("free");
		List<BoardVO> likeList = boardService.getReadLikeList(boardVO);
		model.addAttribute("likeList", likeList);
		return "web/besetLike";
	}

	
	/**
	 * 첨부 파일 삭제
	 * 
	 * @param priDetails
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@PostMapping("deleteImgFile")
	public ResponseEntity<?> deleteImgFile(@AuthenticationPrincipal PrincipalDetails priDetails, BoardVO boardVO) throws Exception {

		BoardVO getBoard = boardService.getRead(boardVO);
		// 로그인한 유저가 작성자 같거나 관리자계정인 경우 변경 허용
		if (getBoard.getUserId().equals(priDetails.getUser().getUserId()) || priDetails.isWriteAdminAndManagerEnabled()) {

			log.info("1 첨부 파일 삭제 : {} ", boardVO.toString());
			boardVO=boardService.getRead(boardVO);
			
			
			if(boardVO.getFileName()!=null && StringUtils.hasText(boardVO.getFileName())) {
				File file=new File(uploadDirectory+boardVO.getFileName());
				if(file.exists()) {
					file.delete();	
				}
				String fileName=boardVO.getFileName().replace("s_","");
				log.info("2 첨부 파일 삭제 : {} ", fileName);
				File file2=new File(uploadDirectory+fileName);
				if(file2.exists()) {
					file2.delete();	
				}
				
				boardService.deleteImgFile(boardVO);
			}
						
			return ResponseEntity.status(HttpStatus.OK).body("success");
		}
		
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("failed");		
	}
	
	
}
