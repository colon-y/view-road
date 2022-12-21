package view.road.model.vo;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotNull;

import view.road.util.config.IpAddress;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReplyVO {

	private Integer rno;  //댓글 아이디
	
	private Integer bno;  	// 게시판 아이디
	
	private Integer num; 
	
	@NotNull(message = "* 내용을 입력해 주세요.")
	private String content;	 //내용
	
	private int uid; //유저 pk
	
	private String userId;	 //유저 아이디
	
	private String username;	 // 작성자명
	
	private String replyPassword; //패스워드
	
	private String birth; // 생년월일
	
	private String zoneCode;
	
	private String address;
	
	private String ip; // 아이피
	
	private String type; // 아이피
	
	private Timestamp  createdDate; // 등록일

	private Timestamp  modifiedDate; // 수정일
	
	public void cleanXssSetting() {
		this.content=cleanXSS(this.content);
		//this.replyWriter=cleanXSS(this.replyWriter);
	}
	
	public static ReplyVO setting(ReplyVO replyVO, HttpSession session, HttpServletRequest request) {	
		UserVO user = (UserVO) session.getAttribute("USER");
		if (user != null) {
			// 로그인 한 유저가 댓글을 작성한 경우
			replyVO.setUserId(user.getUserId());
			replyVO.setUsername(user.getUsername());
			replyVO.setUid(user.getUid());
			replyVO.setIp(IpAddress.getIP(request));
			if(replyVO.getType()==null){
				replyVO.cleanXssSetting();	
			}			
		}else {
			replyVO=null;
		}
		return replyVO;
	}
	
	private String cleanXSS(String value) {
	         //You'll need to remove the spaces from the html entities below
		 value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		 value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		 value = value.replaceAll("'", "&#39;");
		 value = value.replaceAll("eval\\((.*)\\)", "");
		 value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		 value = value.replaceAll("script", "");
		 return value;
	}

	
}



