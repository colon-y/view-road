package view.road.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import view.road.model.vo.StatisticsVO;
import view.road.model.vo.VisitCountVO;
import view.road.service.StatisticsServie;

@Controller
@RequestMapping("/admin/statistics/")
public class AdminStatisticsController {

	@Autowired
	private StatisticsServie statisticsServie;

	
	/**
	 * 
	 * 새회원가입 수
	 * @return
	 */
	@GetMapping("/newMemberRegist")
	public String newMemberRegistPerDay(Model model) throws Exception {
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String currentMonth = sdf.format(cal.getTime());
		
		model.addAttribute("menuName", "통계관리");
		model.addAttribute("currentMonth", currentMonth);
		return "admin/statistics/new_member_regist";
	}

	
	@ResponseBody
	@PostMapping("/listNewMemberRegistPerDay")
	public ResponseEntity<?> listNewMemberRegistPerDay(StatisticsVO statisticsVO, Model model) throws Exception {
		List<StatisticsVO> list = statisticsServie.listNewMemberRegistPerDay(statisticsVO);
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}

	
	
	/**
	 * 방문자수
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("/visitorStatistics")
	public String visitorStatistics(Model model) throws Exception {
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String currentMonth = sdf.format(cal.getTime());
		
		model.addAttribute("menuName", "통계관리");
		model.addAttribute("currentMonth", currentMonth);
		return "admin/statistics/visitor_statistics";
	}

	
	@ResponseBody
	@PostMapping("/listVisitorStatistics")
	public ResponseEntity<?> listVisitorStatistics(VisitCountVO visitCountVO, Model model) throws Exception {
		List<VisitCountVO> list = statisticsServie.listVisitorStatistics(visitCountVO);
		return ResponseEntity.status(HttpStatus.OK).body(list);
	}



	
	
	
	
	
	

}
