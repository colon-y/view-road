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
public class LikeVO {

	private Integer bno; // 게시판번호

	private int uid; //유저 pk
	
	private Timestamp  createdDate; // 등록일
}
