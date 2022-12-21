package view.road.util.config;

import java.util.Random;

public class UserColor {
	
	public static final String[] COLOR = {
			"profile_color_0","profile_color_1","profile_color_2", 
			"profile_color_3","profile_color_4","profile_color_5",
			"profile_color_6","profile_color_7","profile_color_8", "profile_color_9"
	};
	
	public static String randomColor() {
		return UserColor.COLOR[new Random().nextInt(10)];
	}
	
	
	
}
