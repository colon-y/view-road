package view.road.config.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import view.road.model.enums.Role;
import view.road.model.vo.UserVO;
import lombok.Getter;

//시큐리티가 login 주소 요청이 오면 낚아채서 로그인을 진행시킨다
//로그인을 진행이 완료가 되면 시큐리티  session을 만들어 줍니다. (security ContectHolder) 세션 정보 저장
//오브젝트 => Authentication 타입 객체
//Authentication 안에 User 정보가 있어야 함.
//User 오브젝트타입 => UserDetails 타입 객체

//Security Session => Authentication   => UserDetails
@Getter
public class PrincipalDetails implements UserDetails {

	private static final long serialVersionUID = 1L;

	private UserVO user; // 콤포지션

	private Map<String, Object> attributes;

	// 일반로그인
	public PrincipalDetails(UserVO user) {
		this.user = user;
	}

//	//OAuth 로그인
//	public PrincipalDetails(UserVO user, Map<String, Object> attributes) {
//		this.user=user;
//		this.attributes=attributes;
//	}
//		

	/**
	 * 사용자에게 부여된 권한을 반환합니다. null을 반환할 수 없습니다.
	 */
	// 해당 User 의 권한을 리턴하는 곳!!
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<>();
		collect.add(new GrantedAuthority() {
			private static final long serialVersionUID = 1L;

			@Override
			public String getAuthority() {
				return user.getRole().getKey();
			}
		});
		return collect;
	}

	/**
	 * 사용자를 인증하는 데 사용된 암호를 반환합니다.
	 */
	@Override
	public String getPassword() {
		return user.getPassword();
	}

	/**
	 * 사용자를 인증하는 데 사용된 사용자 이름을 반환합니다. null을 반환할 수 없습니다.
	 */
	@Override
	public String getUsername() {
		return user.getUsername();
	}

	/**
	 * 사용자의 계정이 만료되었는지 여부를 나타냅니다. 만료된 계정은 인증할 수 없습니다.
	 */
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	/**
	 * 사용자가 잠겨 있는지 또는 잠금 해제되어 있는지 나타냅니다. 잠긴 사용자는 인증할 수 없습니다.
	 */
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	/**
	 * 사용자의 자격 증명(암호)이 만료되었는지 여부를 나타냅니다. 만료된 자격 증명은 인증을 방지합니다.
	 */
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	/**
	 * 사용자가 활성화되었는지 비활성화되었는지 여부를 나타냅니다. 비활성화된 사용자는 인증할 수 없습니다.
	 */
	@Override
	public boolean isEnabled() {
		// 우리 사이트 1년동안 회원이 로그인을 안하면!! 휴먼 계정으로 하기로 함.
		// 현재시간-로긴시간=>1년을 초과하면 return false;
		return true;
	}

	public boolean isWriteEnabled() {
		if (user.getRole().equals(Role.ROLE_GUEST))
			return false;
		else
			return true;
	}

	public boolean isWriteAdminAndManagerEnabled() {
		if (user.getRole().equals(Role.ROLE_ADMIN) || user.getRole().equals(Role.ROLE_MANAGER))
			return true;
		else
			return false;
	}
	
	


}
