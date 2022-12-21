package view.road.config.auth;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.UserMapper;
import view.road.model.enums.Role;
import view.road.model.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

//시큐리티 설정에서 loginProcessingUrl("/login");
/// login 요청이 오면 자동으로 UserDetailService 타입으로 IoC 되어 있는 loadUserByUsername 함수가 실행
@Service
@Slf4j
public class PrincipalDetailsService implements UserDetailsService{

	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private HttpSession session;
	
	//시큐리티 session = Authentication(내부 UserDetails) = UserDetails
	//함수 종료시 @AuthenticationPrincipal 어노테이션이 만들어진다
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		UserVO userEntitiy=userMapper.findByUserId(userId);		
		if (userEntitiy == null) {
	            throw new UsernameNotFoundException("등록된 회원이 아닙니다.");
	            
	    }else {		
			log.info("* userEntitiy   : {} ", userEntitiy.toString());			
			if(userEntitiy.getRole().equals(Role.ROLE_ADMIN) ) {
				session.setAttribute("isAdmin", true);	
			}else session.setAttribute("isAdmin", false);
			
			session.setAttribute("USER", userEntitiy);
			return new PrincipalDetails(userEntitiy);
		}
	}
	
	
	
	
	
	
}



