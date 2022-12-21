package view.road.model.dao.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import view.road.model.vo.ReplyVO;
import view.road.util.config.PageMakerAndSearch;

@Repository
public interface ReplyMapper {

	// tbl_reply 테이블의 등록 처리이다 -> mapper.xml 로 이동후 sql 문 처리
	public void createBoard(ReplyVO replyVO) throws Exception;

	// tbl_reply 테이블의 상세정보 처리 -> mapper.xml 로 이동후 sql 문 처리
	public ReplyVO readBoard(Integer rno) throws Exception;

	// tbl_reply 테이블의 업데이트 처리 -> mapper.xml 로 이동후 sql 문 처리
	public void updateBoard(ReplyVO replyVO) throws Exception;

	// tbl_reply 테이블의 삭제 처리 -> mapper.xml 로 이동후 sql 문 처리
	public void deleteBoard(Integer rno) throws Exception;

	// tbl_reply 테이블의 목록 처리 -> mapper.xml 로 이동후 sql 문 처리
	public List<ReplyVO> listAllReplyVO(PageMakerAndSearch pageMaker) throws Exception;

	// tbl_reply 테이블이 한개의 정보 불러오기 처리 -> mapper.xml 로 이동후 sql 문 처리
	public ReplyVO getRnoInfo(Integer rno) throws Exception;

	// tbl_reply 의 비밀번호 와 tbl_reply 의 아이번호를 확인 후 삭제 처리 -> mapper.xml 로 이동후 sql 문 처리
	public void removePassowrd(ReplyVO replyVO) throws Exception;

	// tbl_reply 의 비밀번호 확인 처리 -> mapper.xml 로 이동후 sql 문 처리
	public Integer getPasowrdConfirm(ReplyVO replyVO) throws Exception;

	public int replyTotalCount(PageMakerAndSearch pageMaker)  throws Exception;

	public int updateReply(ReplyVO vo)  throws Exception;
	
	
}
