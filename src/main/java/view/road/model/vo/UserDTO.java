package view.road.model.vo;



import view.road.model.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {


	private long uid;
	private String username;
	private String password;
	private String email;
	private Role role;
	

	@Builder
	public UserDTO(String username, String password, String email, Role role) {
		this.username = username;
		this.password = password;
		this.email = email;
		this.role = role;
	}
	
	
//	public UserVO toEntitiy() {		
//		return UserVO.builder()
//				.username(username)
//				.password(password)
//				.email(email)
//				.role(role)
//				.build();						
//	}
	
}

