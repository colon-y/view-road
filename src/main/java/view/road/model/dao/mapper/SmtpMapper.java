package view.road.model.dao.mapper;

import org.springframework.stereotype.Repository;

import view.road.model.vo.SmtpVO;


@Repository
public interface SmtpMapper {

	public Integer smtpUpdate(SmtpVO stSmtpVO)  throws Exception;

	public SmtpVO getSmtpInfo(Integer sid) throws Exception;
	
	
}
