package view.road.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.VisitCounterMapper;
import view.road.model.vo.VisitCountVO;
import view.road.service.VisitCounterService;

@Service
public class VisitCounterServiceImpl implements VisitCounterService {

	@Autowired
	private VisitCounterMapper counterMapper;
	
	@Override
    public int insertVisitor(VisitCountVO vo) throws Exception {
    	return counterMapper.insertVisitor(vo);
    }
    
	
}
