package view.road.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VisitCountVO extends StatisticsVO {
	
	 private Integer visitId;
     private String visitIp;
     private String visitRefer;
     private String visitAgent;
     private Timestamp visitTime;
     private int cntIp;
     
}

