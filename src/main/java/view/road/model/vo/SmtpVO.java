package view.road.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SmtpVO {

	private Integer sid;
	
	private String emailName; //이메일발송자명
	
	private String host;  //SMTP주소
	
	private String username;   //SMTP유저명
	
	private String password;   //SMTP비밀번호
	
	private Timestamp  createdDate; // 등록일
	
	private Timestamp  modifiedDate; // 수정일
	

	
}
