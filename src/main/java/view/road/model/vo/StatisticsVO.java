package view.road.model.vo;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class StatisticsVO {

	private String startDate;
	private String endDate;
	private String createdDate;
	private String currentMonth;
	private int cnt;
	
	/**
	 * 마지막 날짜
	 * @param month
	 * @return
	 */
	public String getLastDay(String month) {
		LocalDate date= LocalDate.parse(month+"-01");
		LocalDate lastDate = date.withDayOfMonth(date.lengthOfMonth());
		return lastDate.toString()+" 23:59:59";				
	}
	
	
}
