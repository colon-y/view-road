package view.road;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ApplicationTests {

	@Test
	void contextLoads() {
	}

	
	public static void main(String[] args) {
		 String[] arrayOfStrings = {"One", "Two", "Three", "four", "Five"};

	        String arrayToString = String.join(",", arrayOfStrings);

	        System.out.println(arrayToString);
	}
	
	
}
