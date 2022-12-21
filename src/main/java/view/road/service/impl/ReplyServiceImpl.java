package view.road.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.ReplyMapper;
import view.road.model.vo.ReplyVO;
import view.road.service.ReplyService;
import view.road.util.config.PageMakerAndSearch;

@Service
public class ReplyServiceImpl implements ReplyService {

	// ReplyMapper 객체를 의존성 주입시킨다.
	@Autowired
	private ReplyMapper replyMapper;

	// 등록 처리 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public void createBoard(ReplyVO replyVO) throws Exception {
		replyMapper.createBoard(replyVO);
	}

	// 하나의 데이터 가져오기 읽기 처리 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public ReplyVO readBoard(Integer bno) throws Exception {
		return replyMapper.readBoard(bno);
	}

	// 업데이트 처리 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public void updateBoard(ReplyVO replyVO) throws Exception {
		replyMapper.updateBoard(replyVO);
	}

	// 삭제 처리 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public void deleteBoard(Integer rno) throws Exception {
		replyMapper.deleteBoard(rno);
	}

	// 정보 목록 불러오기 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public List<ReplyVO> listAllReplyVO(PageMakerAndSearch pageMaker) throws Exception {
		return replyMapper.listAllReplyVO(pageMaker);
	}

	// rno 번호를 정보 불러오기 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public ReplyVO getRnoInfo(Integer rno) throws Exception {

		return replyMapper.getRnoInfo(rno);
	}

	// 비밀번호와 rno 번호로 삭제처리 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public void removePassowrd(ReplyVO replyVO) throws Exception {
		replyMapper.removePassowrd(replyVO);

	}

	// 비밀번호 가져오기 -> ReplyMapper 로 이동후 처리 된다
	@Override
	public Integer getPasowrdConfirm(ReplyVO replyVO) throws Exception {
		return replyMapper.getPasowrdConfirm(replyVO);
	}

	@Override
	public int replyTotalCount(PageMakerAndSearch pageMaker) throws Exception{
		return replyMapper.replyTotalCount(pageMaker); 
	}

	@Override
	public int updateReply(ReplyVO vo) throws Exception {
		return replyMapper.updateReply(vo); 
	}

}
