package view.road.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.SmtpMapper;
import view.road.model.vo.SmtpVO;
import view.road.service.SmtpService;

@Service
public class SmtpServiceImpl implements SmtpService{

	@Autowired
	private SmtpMapper smtpMapper;

	@Override
	public Integer smtpUpdate(SmtpVO stSmtpVO) throws Exception {
		return smtpMapper.smtpUpdate(stSmtpVO);
	}

	@Override
	public SmtpVO getSmtpInfo(Integer sid) throws Exception {
		return smtpMapper.getSmtpInfo(sid);
	}
	
	
	
}
