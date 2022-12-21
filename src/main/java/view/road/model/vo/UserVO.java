package view.road.model.vo;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import view.road.model.enums.Role;
import view.road.util.config.UserColor;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserVO {

	private Integer num;
	
	private Integer uid;
	
	@NotNull(message="* 아이디를 입력해 해주세요.")
	private String userId;
	
	@NotNull(message="* 유저명을 입력해 주세요.")
	private String username;
		
	@NotNull(message="* 이메일을 입력해 주세요.")
	private String email;
	
	private String phone; // 회원 전화번호
	
	private String membership;
	
	private String gender; // 회원 성별
	
	private String birth; // 생년월일
		
	private String zoneCode;
	
	private String address;
	
	@NotNull(message="* 비밀번호를 입력해 주세요.")
	private String password;
	
	private String passwordCheck;
	
	private String ip;

	private int age;
	
	private Role role;
	
	private int level=1; // 회원등급
		
	private String emailAuthKey;
	
	private String userColor;
		
	private Timestamp  createdDate; // 등록일
	
	private Timestamp  modifiedDate; // 수정일
	
	
	
	public void setUserColor(String userColor){
		this.userColor = UserColor.randomColor();
	}
	
	
	@Builder
	public UserVO(String userId, String username, String email, String phone,  String gender, String birth, String zoneCode, String address,
			 String password, String ip, Role role,Integer level) {
		this.userId=userId;
		this.username = username;
		this.email=email;
		this.phone=phone;
		this.gender=gender;
		this.birth=birth;
		this.zoneCode=zoneCode;
		this.address=address;
		this.password = password;
		this.ip=ip;
		this.role = role;
		this.level=level;
	}
	
	
}

