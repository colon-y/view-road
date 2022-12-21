package view.road.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.BoardVO;
import view.road.service.BoardService;
import view.road.util.config.PageMakerAndSearch;

@Controller
@RequestMapping("/place/")
public class PlaceGalleryMosaicController {

	@Autowired
	private BoardService boardService;
	
	
	
	
	// 목록
	@GetMapping("/gallery")
	public String gallery(@AuthenticationPrincipal PrincipalDetails priDetails, PageMakerAndSearch pageMaker,
			BoardVO boardVO, Model model) throws Exception {		
		// 전체 tbl_board 갯수를 구한다.
		Integer totalCount = boardService.galleryMosaicListTotalCount(pageMaker);

		// 20개의 목록이 출력이 나오도록 처리한다.
		pageMaker.setPerPageNum(30);
		// 페이징은 3개씩 보이도록 처리한다.
		pageMaker.setDisplayPageNum(3);
		// pageMaker 에 전체 갯수를 저장후 계산 처리한다.
		pageMaker.setTotalCount(totalCount);

		List<BoardVO> list = boardService.galleryMosaicList(pageMaker);

		String pagination = pageMaker.bootStrapPagingSearchHTML4("/place/gallery");

		model.addAttribute("pagination", pagination); // 페이징 String 담는다
		model.addAttribute("pageMaker", pageMaker); // 페이지 메이커 객체를 담는다.
		model.addAttribute("totalCount", totalCount); // 전체 개수를 구한 totalcount 를 담는다.
		model.addAttribute("list", list); // 목록처리한 List<BoardVO> 객체를 담는다.
		return "web/place_gallery/gallery_mosaic";
	}


	
	@GetMapping("/galleryList")
	public String galleryList(@AuthenticationPrincipal PrincipalDetails priDetails, PageMakerAndSearch pageMaker,
			BoardVO boardVO, Model model) throws Exception {		
		// 전체 tbl_board 갯수를 구한다.
		Integer totalCount = boardService.galleryMosaicListTotalCount(pageMaker);

		// 20개의 목록이 출력이 나오도록 처리한다.
		pageMaker.setPerPageNum(30);
		// 페이징은 3개씩 보이도록 처리한다.
		pageMaker.setDisplayPageNum(3);
		// pageMaker 에 전체 갯수를 저장후 계산 처리한다.
		pageMaker.setTotalCount(totalCount);

		List<BoardVO> list = boardService.galleryMosaicList(pageMaker);

		String pagination = pageMaker.bootStrapPagingSearchHTML4("/place/galleryList");

		model.addAttribute("pagination", pagination); // 페이징 String 담는다
		model.addAttribute("pageMaker", pageMaker); // 페이지 메이커 객체를 담는다.
		model.addAttribute("totalCount", totalCount); // 전체 개수를 구한 totalcount 를 담는다.
		model.addAttribute("list", list); // 목록처리한 List<BoardVO> 객체를 담는다.
		return "web/place_gallery/gallery_list";
	}

	
	
	
	
}
