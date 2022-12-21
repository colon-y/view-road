package view.road.util.interceptor;

import javax.servlet.http.HttpSession;

public class LoginSessionCheck {

	public static boolean check(HttpSession session) {
		if (session.getAttribute("USER")==null) {
			return true;
		}
		return false;
	}

}
