package view.road.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.LikeVO;
import view.road.service.LikeService;

// 추천곡을 적어주세요! url
@Controller
@RequestMapping("/like/")
public class LikeController {

	@Autowired
	private LikeService likeService;

	@GetMapping("list")
	@ResponseBody
	public ResponseEntity<?> likeList(LikeVO likeVO, Model model, HttpServletRequest request) throws Exception {
		int likeCount =likeService.likeList(likeVO);		
		return ResponseEntity.status(HttpStatus.OK).body(likeCount);
	}

	
	@PostMapping("update")
	public ResponseEntity<?> likeUpdate(LikeVO likeVO, HttpServletResponse response, HttpServletRequest request) throws Exception {

		if (likeService.exitLike(likeVO)) {
			likeService.delete(likeVO);
			return ResponseEntity.status(HttpStatus.OK).body(0);
			
		} else {
			System.out.println(" 좋아요 처리");
			likeService.insert(likeVO);
			return ResponseEntity.status(HttpStatus.OK).body(1);
		}
	}


}
