package view.road.config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import view.road.model.vo.VisitCountVO;
import view.road.service.VisitCounterService;
import view.road.util.config.IpAddress;

@Slf4j
@Component
public class VisitCounter implements HttpSessionListener{
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private VisitCounterService visitCounterService;
	
    @Override
    public void sessionCreated(HttpSessionEvent arg0){    	
    	
        // HttpSession session = arg0.getSession();
        //WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
        //등록되어있는 빈을 사용할수 있도록 설정해준다
    	log.info("sessionCreated 실행 , {} ");
    
    	
        VisitCountVO vo = new VisitCountVO();
        vo.setVisitAgent(request.getHeader("User-Agent"));
        vo.setVisitIp(IpAddress.getIP(request));
        vo.setVisitRefer(request.getHeader("referer"));        
        try {
			visitCounterService.insertVisitor(vo);
		} catch (Exception e) {	
			log.info("세션 생성 오류  {}", e.getMessage());
			e.printStackTrace();
		}       
    }
    
    
    @Override
    public void sessionDestroyed(HttpSessionEvent arg0){    	
    }
    
   
}