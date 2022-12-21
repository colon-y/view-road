package view.road.model.dao.mapper;

import org.springframework.stereotype.Repository;

import view.road.model.vo.VisitCountVO;

@Repository
public interface VisitCounterMapper {

    public int insertVisitor(VisitCountVO vo) throws Exception ;
      
    
}
