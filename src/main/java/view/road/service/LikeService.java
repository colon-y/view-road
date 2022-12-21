package view.road.service;

import view.road.model.vo.LikeVO;

//interface 의 LikeService 부모 객체로   상속 시켜 준다
public interface LikeService {
	// 목록 처리
	public int likeList(LikeVO likeVO) throws Exception;

	// 등록 처리
	public void insert(LikeVO likeVO) throws Exception;

	// 삭제 처리
	public void delete(LikeVO likeVO) throws Exception;

	public boolean exitLike(LikeVO likeVO) throws Exception;

}
