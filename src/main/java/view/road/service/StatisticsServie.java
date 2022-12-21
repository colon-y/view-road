package view.road.service;

import java.util.List;

import view.road.model.vo.StatisticsVO;
import view.road.model.vo.VisitCountVO;

public interface StatisticsServie {

	
	public List<StatisticsVO> listNewMemberRegistPerDay(StatisticsVO statisticsVO)  throws Exception;

	public List<VisitCountVO> listVisitorStatistics(VisitCountVO visitCountVO) throws Exception;
	
	
	
}
