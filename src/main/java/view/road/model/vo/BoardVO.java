package view.road.model.vo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import view.road.util.config.Time;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BoardVO {

	private long bno;  //아이디
	
	private Integer num; 
	
	@Size(max=50, message="* 제목은 1~50 글자 사이로 입력해 주세요.")
	@NotNull(message="* 제목을 입력해 해주세요.")
	private String title;
	
	private String place="";
		
	@NotNull(message="* 내용을 입력해 해주세요.")
	private String content;
	
	private Integer uid; //유저 pk
	
	private String boardType; //유저 아이디
	
	private String userId; //유저 아이디
	
	//@Size(max=10, message="* 작성자명을 1~12 글자 사이로 입력해 주세요.")
	//@NotNull(message="* 작성자명을 입력해 해주세요.")
	private String username;
	
/*	@Size(min=4, max=4, message="* 비밀번호 4자리로 입력해 주세요.")
	@NotNull(message="* 비밀번호를 입력해 해주세요.")
*/
	private String boardPassword;
	
	private String ip;	//아이피
	
	private Integer viewCnt;  //조회수
	
	private Integer replyCnt; //답변수
	
	private Integer likeCnt; // 추천
	
	private Integer myLikeCnt; // 내가 추천여부

	private String birth; // 생년월일
	
	private String zoneCode;
	
	private String address="";

	private String fileName;
	
	private int scrapCnt; 
		
	private Integer imgCnt; //이미지 가 등록되었는지 확인
	
	private String latitude;
	
	private String longitude;

	private String customDate;
	
	private String createdDateString;
	
	private Timestamp  createdDate; // 등록일
	
	private Timestamp  modifiedDate; // 수정일
	
	//xss 제목과 작성자  스크립트 제거 처리를 한다.
	public void setting() {
		this.title=cleanXSS(this.title);
		//this.boardWriter=cleanXSS(this.username);
	}
	
	//xss 스크립트 제거
	private String cleanXSS(String value) {
		 value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		 value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		 value = value.replaceAll("'", "&#39;");
		 value = value.replaceAll("eval\\((.*)\\)", "");
		 value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		 value = value.replaceAll("script", "");
		 return value;
	}

	
	public void setCustomDate(String customDate) {
		if(this.createdDate!=null) {
			this.customDate = Time.calculateTime(this.createdDate);	
		}else {
			this.customDate = customDate;
		}
		
	}
	
	public String getCustomDate() {
		if(this.createdDate!=null) {
			return Time.calculateTime(this.createdDate);	
		}
		return this.customDate;
	}
	
	
	
	public void setCreatedDateString(String createdDateString) {
		if(this.createdDate!=null) {
			SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
			this.createdDateString = SDF.format(createdDate);
		}else {
			this.createdDateString = createdDateString;
		}
	}
	
	public String getCreatedDateString() {
		if(this.createdDate!=null) {
			SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
			String toDayFormat = SDF.format(createdDate);
			return toDayFormat;	
		}
		return this.createdDateString;
	}
	
	
	
	public String customDate() {
		return Time.calculateTime(this.createdDate);
	}

}
