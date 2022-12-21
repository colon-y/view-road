package view.road.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.BoardVO;
import view.road.service.BoardService;
import view.road.util.config.PageMakerAndSearch;


@Controller
@RequestMapping("/place/")
public class PlaceMapController {

	@Autowired
	private BoardService boardService;
	
	

	@Value("${kakao.appkey}")
	private String KAKAO_APP_KEY;
	
	@GetMapping("map")
	public String map(PageMakerAndSearch pageMaker, Model model, String convertToggle) throws Exception {
		System.out.println(" convertToggle  : " +convertToggle);
		if(convertToggle==null || convertToggle.equals("") || convertToggle.equals("true")) {
			model.addAttribute("convertToggle", null);
		}else{
			model.addAttribute("convertToggle", "false");
		}
		model.addAttribute("KAKAO_APP_KEY", KAKAO_APP_KEY);
		return "web/place_map/map_list";
	}

	@GetMapping("mapList")
	@ResponseBody
	public ResponseEntity<?> mapList(PageMakerAndSearch pageMaker) throws Exception {			
		
		Integer totalCount = boardService.galleryMosaicListTotalCount(pageMaker);
		pageMaker.setDisplayPageNum(10);
		pageMaker.setTotalCount(totalCount);
		List<BoardVO> list = boardService.galleryMosaicList(pageMaker);
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("pageMaker", pageMaker); 
		map.put("totalCount", totalCount); 
		map.put("list", list);				
		return ResponseEntity.status(HttpStatus.OK).body(map);
	}
	
	
	
}
