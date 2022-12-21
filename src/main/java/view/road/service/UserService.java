package view.road.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import view.road.model.vo.UserVO;
import view.road.util.config.PageMakerAndSearch;

//interface 의 UserService 부모 객체로   상속 시켜 준다
public interface UserService {

	// 아이디 중복 체크
	public Integer userGet(UserVO userVO) throws Exception;

	// 유저명 중복 체크
	public Integer userGetUsername(UserVO userVO) throws Exception;

	// 유저 가입 생성
	public void userCreate(UserVO userVO) throws Exception;

	// 유저 로그인
	public UserVO userLoginIdPw(UserVO userVO) throws Exception;

	/** 관리자 회원가입 **/
	public void memberJoin(UserVO member, HttpServletRequest requestm, boolean isAdmin) throws Exception;

	// 아이디 중복 검사
	public int idCheck(String email) throws Exception;

	public Integer emailDbCheck(String email) throws Exception;

	// 로그인
	public UserVO memberLogin(UserVO member) throws Exception;

	// 회원수
	public int getTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	// 회원 목록
	public List<UserVO> memberList(PageMakerAndSearch pageMaker) throws Exception;

	public UserVO memberInfo(int uid) throws Exception;

	public void memberDelete(int uid) throws Exception;

	public void memberUpdate(UserVO memberVO, HttpServletRequest request) throws Exception;

	public UserVO findByEmail(String email) throws Exception;

	public void guestUpdateRole(String email) throws Exception;

	public List<UserVO> getManagerList() throws Exception;

	public Integer phoneDbCheck(String phone) throws Exception;

	public Integer usernameDbCheck(String username) throws Exception;

	public Integer idPhoneCheck(UserVO userVO) throws Exception;

	public int findEmailPassword(UserVO userVO) throws Exception;

	public UserVO findByUserId(String userId) throws Exception;


	
}
