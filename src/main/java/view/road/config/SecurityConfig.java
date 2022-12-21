package view.road.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import view.road.config.auth.PrincipalDetailsService;
import view.road.util.exception.CustomAuthFailureHandler;

/**
 * 1.securedEnabled
 * 
 * @Secured 애노테이션을 사용하여 인가 처리를 하고 싶을때 사용하는 옵션이다. 기본값은 false 2.prePostEnabled
 * 
 *          @PreAuthorize, @PostAuthorize 애노테이션을 사용하여 인가 처리를 하고 싶을때 사용하는 옵션이다.
 *          기본값은 false 3.jsr250Enabled
 * 
 * @RolesAllowed 애노테이션을 사용하여 인가 처리를 하고 싶을때 사용하는 옵션이다. 기본값은 false
 * 
 *               @Secured, @RolesAllowed 특정 메서드 호출 이전에 권한을 확인한다. SpEL 지원하지 않는다.
 * @Secured 는 스프링에서 지원하는 애노테이션이며, @RolesAllowed는 자바 표준
 * 
 *          @Secured("ROLE_ADMIN") @RolesAllowed("ROLE_ADMIN")
 * 
 */

//구글로그인이 완료된 뒤의 후처리가 필요함. 1.코드 받기(인증) , 2.엑세스토큰(권한), 3.사용자프로필 정보를 가져오기
//4.그 정보를 토대로 회원가입을 자동으로 진행시키기도 함
//4-2 (이메일,전화번호,이름,아이디) 쇼핑몰 -> (집주소),

@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) // secured 어노테이션 활성화
@Configurable
@EnableWebSecurity // 스프링 시큐리티 필터가 스프링 필터체인에 등록이 됩니다.
public class SecurityConfig  {

	@Autowired
	private CustomAuthFailureHandler customFailureHandler;

	@Autowired
	PrincipalDetailsService principalDetailsService;

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	/**
	 *
	 * Spring Secureity 에서 인증은 AuthenticationManager 를 통해 이루어지며
	 * AuthenticationManagerBuilder 가 AuthenticationManager 를 생성합니다.
	 * userDetailsService 를 구현하고 있는 객체로 principalDetailsServicee를 지정해 주며, 비밀번호 암호화를
	 * 위해 passwordEncoder 를 지정해줍니다.
	 */
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		auth.userDetailsService(principalDetailsService).passwordEncoder(passwordEncoder());
//	}
	

	@Bean
	public AuthenticationManager authenticationManagerBean(AuthenticationConfiguration configuration) throws Exception {
		return configuration.getAuthenticationManager();
	}

	@Bean
	public AuthenticationProvider authenticationProvider() {
		var provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(principalDetailsService);
		provider.setPasswordEncoder(passwordEncoder());
		return provider;
	}

	@Bean
	public WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("*");
			}
		};
	}
	
	

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.headers().frameOptions().sameOrigin();

		http.authorizeRequests()

				.antMatchers(HttpMethod.GET, "/board/**" ,"/place/**").permitAll()
				.antMatchers(HttpMethod.POST, "/board/**","/place/**").hasAnyAuthority("ROLE_USER", "ROLE_ADMIN", "ROLE_MANAGER")
				.antMatchers(HttpMethod.DELETE, "/board/**" ,"/place/**").hasAnyAuthority("ROLE_USER", "ROLE_ADMIN", "ROLE_MANAGER")
				.antMatchers(HttpMethod.PUT, "/board/**" ,"/place/**").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER" ,"ROLE_USER")
				.antMatchers("/admin/member/**").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER")
				.antMatchers("/admin/smtpUpdate").hasAnyAuthority("ROLE_ADMIN")
				.antMatchers("/admin", "/admin/", "/admin/main").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER")
			
				
				.antMatchers("/scrap/**").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER" ,"ROLE_USER")
				.antMatchers("/note/**").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER" ,"ROLE_USER")
				.antMatchers("/members/**").hasAnyAuthority("ROLE_ADMIN", "ROLE_MANAGER" ,"ROLE_USER")
				
				
				.antMatchers("/", "/resources/**", "/loginForm/**", "/login/**", "/join/**", "/displayFile","/phoneCertification",
						"/emailAuthentication/send", "/findIdPassword/**","/like/list")
				.permitAll()

				.anyRequest().authenticated() // 그 외 모든 요청은 인증된 사용자만 접근 가능

				.and().formLogin().loginPage("/loginForm").usernameParameter("userId") // 기본값 username
				.passwordParameter("password").loginProcessingUrl("/login") // login 주소가 호출이 되면 시큐리티가 낚아채서 대신 로그인을 //
																			// 진행준다.
				.failureHandler(customFailureHandler) // 로그인 오류 실패 체크 핸들러
				.defaultSuccessUrl("/")
				// .failureUrl("/");

				.and().logout()
				// .logoutRequestMatcher(new AntPathRequestMatcher("/members/logout")) //로그아웃
				// URL 을 설정 없을시 기본값 logout
				.logoutSuccessUrl("/"); // 로그아웃 성공시 이동할 URL 을 설정

		return http.build();
	}

}
