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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import view.road.config.auth.PrincipalDetails;
import view.road.model.vo.ScrapVO;
import view.road.service.ScrapService;
import view.road.util.config.PageMakerAndSearch;

@Controller
@RequestMapping("/members/scrap")
public class MembersScrapController {

	
	@Autowired
	private ScrapService scrapService;
	
	@GetMapping("list")
	public String listScrap(PageMakerAndSearch pageMaker, @AuthenticationPrincipal PrincipalDetails principalDetails,  Model model)  throws Exception{
		
		pageMaker.setUid(principalDetails.getUser().getUid());	
		pageMaker.setPerPageNum(10);
		int totalCount=scrapService.scrapTotalCount(pageMaker);
		pageMaker.setTotalCount(totalCount);
		
		List<ScrapVO>  scrapList=scrapService.listScrap(pageMaker);
		String pagination = pageMaker.bootStrapPagingSearchHTML4("/members/scrap/list");
		model.addAttribute("scrapList", scrapList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pagination", pagination); 
		model.addAttribute("pageMaker", pageMaker);	
		model.addAttribute("menuName", "scrap");
		return "members/scrap/scrap_list";
	}
	
	
	@DeleteMapping("deleteScrap")
	public ResponseEntity<?> deleteScrap(ScrapVO scrapVO, @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		scrapVO.setUid(principalDetails.getUser().getUid());
		scrapService.deleteScrap(scrapVO);
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	@DeleteMapping("deleteSelect")
	public ResponseEntity<?> deleteSelect(@RequestParam List<Integer>  scno, ScrapVO scrapVO,  @AuthenticationPrincipal PrincipalDetails principalDetails) throws Exception{
		scrapVO.setUid(principalDetails.getUser().getUid());
		for(Integer no : scno) {
			scrapVO.setScno(no);
			scrapService.deleteScrap(scrapVO);
		}
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
	
	
}
