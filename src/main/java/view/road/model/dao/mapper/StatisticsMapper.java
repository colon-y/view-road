package view.road.model.dao.mapper;

import java.util.List;
import org.springframework.stereotype.Repository;
import view.road.model.vo.StatisticsVO;
import view.road.model.vo.VisitCountVO;

@Repository
public interface StatisticsMapper {
	
	public List<StatisticsVO> listNewMemberRegistPerDay(StatisticsVO statisticsVO)  throws Exception;

	public List<VisitCountVO> listVisitorStatistics(VisitCountVO visitCountVO)  throws Exception;
	

	
}
