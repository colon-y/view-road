package view.road.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.LikeMapper;
import view.road.model.vo.LikeVO;
import view.road.service.LikeService;

@Service
public class LikeServiceImpl implements LikeService {

	// LikeMapper 객체를 의존성 주입시킨다.
	@Autowired
	private LikeMapper likeMapper;

	// 목록 처리 -> LikeMapper 로 이동후 처리
	@Override
	public int likeList(LikeVO likeVO) throws Exception {
		return likeMapper.likeList(likeVO);
	}

	// 삽입 처리 -> LikeMapper 로 이동후 처리
	@Override
	public void insert(LikeVO likeVO) throws Exception {
		likeMapper.insert(likeVO);
	}

	// 삭제 처리 -> LikeMapper 로 이동후 처리
	@Override
	public void delete(LikeVO likeVO) throws Exception {
		likeMapper.delete(likeVO);
	}

	@Override
	public boolean exitLike(LikeVO likeVO) throws Exception {
		return likeMapper.exitLike(likeVO)>0?true:false;
	}

}
