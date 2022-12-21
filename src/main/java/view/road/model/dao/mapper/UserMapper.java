package view.road.model.dao.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import view.road.model.vo.UserVO;
import view.road.util.config.PageMakerAndSearch;

@Repository
public interface UserMapper {

	// 아이디 중복 체크 -> mapper.xml 로 이동후 sql 문 처리
	public Integer userGet(UserVO userVO) throws Exception;

	// 유저명 중복 체크 -> mapper.xml 로 이동후 sql 문 처리
	public Integer userGetUsername(UserVO userVO) throws Exception;

	// 유저 가입 생성 -> mapper.xml 로 이동후 sql 문 처리
	public void userCreate(UserVO userVO) throws Exception;

	// 유저 로그인 -> mapper.xml 로 이동후 sql 문 처리
	public UserVO userLoginIdPw(UserVO userVO) throws Exception;

	/** 관리자 */
	// 회원가입
	public void memberJoin(UserVO member);

	// 아이디 중복 검사
	public int idCheck(String email);

	public int emailDbCheck(String email) throws Exception;

	// 로그인
	public UserVO memberLogin(UserVO member);

	public int getTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public List<UserVO> memberList(PageMakerAndSearch pageMaker) throws Exception;

	public UserVO memberInfo(int uid) throws Exception;

	public void memberDelete(int uid) throws Exception;

	public void memberUpdate(UserVO memberVO) throws Exception;

	public UserVO findByUserId(String userId);

	public UserVO findByEmail(String email) throws Exception;

	public void guestUpdateRole(String email) throws Exception;

	public List<UserVO> getManagerList() throws Exception;

	public Integer phoneDbCheck(String phone)  throws Exception;

	public Integer usernameDbCheck(String username) throws Exception;

	public Integer idPhoneCheck(UserVO userVO) throws Exception;

	public int findEmailPassword(UserVO userVO) throws Exception;

	public int updatePassword(UserVO userVO) throws Exception;
	
	

}
