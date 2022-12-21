package view.road.service;

import java.util.List;

import view.road.model.vo.ReplyVO;
import view.road.util.config.PageMakerAndSearch;

//interface 의 ReplyService 부모 객체로   상속 시켜 준다
public interface ReplyService {
	// 등록 처리
	public void createBoard(ReplyVO replyVO) throws Exception;

	// 상세보기 읽기 처리
	public ReplyVO readBoard(Integer rno) throws Exception;

	// 업데이트 처리 메서드
	public void updateBoard(ReplyVO replyVO) throws Exception;

	// 삭제 처리
	public void deleteBoard(Integer rno) throws Exception;

	// 목록 처리
	public List<ReplyVO> listAllReplyVO(PageMakerAndSearch pageMaker) throws Exception;

	// 한개의 정보 불러오기 처리
	public ReplyVO getRnoInfo(Integer rno) throws Exception;

	// 비밀번호 와 tbl_reply 의 아이번호를 확인 후 삭제 처리
	public void removePassowrd(ReplyVO replyVO) throws Exception;

	// 의 비밀번호 확인 처리
	public Integer getPasowrdConfirm(ReplyVO replyVO) throws Exception;

	public int replyTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public int updateReply(ReplyVO vo) throws Exception;

}
