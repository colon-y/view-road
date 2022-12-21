package view.road.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import view.road.util.config.Time;

@Getter
@Setter
@ToString
public class NoteVO{
	
	private long noteId;  //쪽지PK
	
	private long receiveId;  //받는사람PK
	
	private long sendId;  //보내는사람PK
	
	private String sendName; //보낸사람 이름
	
	private String receiveName; //받는 사람이름
		
	private String title; //제목
	
	private String content; //내용

	private int readCnt; //읽은 횟수
	
	private int totCnt; //유저그릅 읽지 않은 횟수
		
	private Timestamp  sendDate; // 보낸날짜
	
	private Timestamp  readDate; // 읽은날짜
		
	private long myId;
	
	private long otherId;
	
	private String remove; //삭제 여부
	
	private String userColor;
	

	

	
	public void setTitle(String title) {
		String value=title;	
		System.out.println(" title : "+title);
		if(title==null || title.equals("")){
			value=this.content;
			if(value!=null&&value.length()>100) {				
				value=value.substring(0,100);				
			}					
		}else {				 
			 value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			 value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
			 value = value.replaceAll("'", "&#39;");
			 value = value.replaceAll("eval\\((.*)\\)", "");
			 value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
			 value = value.replaceAll("script", "");
		}		 
		this.title=value;
	}
	
	public void setContent(String content) {
		 String value=content;		 
		 value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		 value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		 value = value.replaceAll("'", "&#39;");
		 value = value.replaceAll("eval\\((.*)\\)", "");
		 value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		 value = value.replaceAll("script", "");		 
		 this.content=value;
	}
	
	
	public String customSendDate() {
		return Time.calculateTime(this.sendDate);
	}
	
	public String customReadDate() {
		return Time.calculateTime(this.readDate);
	}
	
}


