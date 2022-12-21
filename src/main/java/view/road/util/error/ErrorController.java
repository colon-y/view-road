package view.road.util.error;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//@Controller
@RequestMapping(value = "/error")
public class ErrorController {
	
	@RequestMapping("/404")
	public String error404(HttpServletRequest request) {
		return "error/404";
	}

	@RequestMapping("/400")
	public String error400(HttpServletRequest request) {
		return "error/400";
	}
	
	
	public String error500(HttpServletRequest request) {
		return "error/500";
	}

	@RequestMapping("/default")
	public String errorDefault(HttpServletRequest request) {
		return "error/default";
	}

}
