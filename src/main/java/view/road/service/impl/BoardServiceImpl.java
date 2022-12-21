package view.road.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.BoardMapper;
import view.road.model.vo.BoardVO;
import view.road.service.BoardService;
import view.road.util.config.PageMakerAndSearch;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	/** 등록 처리 */
	@Override
	public void register(BoardVO boardVO) throws Exception {
		boardMapper.register(boardVO);
	}

	/** 한개의 정보 가져오기 - 읽기 처리 */
	@Override
	public BoardVO getRead(BoardVO boardVO) throws Exception {
		return boardMapper.getRead(boardVO);
	}

	/** 목록 처리 */
	@Override
	public List<BoardVO> getReadList(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.getReadList(pageMaker);
	}

	// 삭제 처리
	@Override
	public void remove(BoardVO boardVO) throws Exception {
		boardMapper.remove(boardVO);
	}

	/** 업데이트 처리 */
	@Override
	public void boardUpdate(BoardVO boardVO) throws Exception {
		boardMapper.boardUpdate(boardVO);
	}

	/** 비밀번호 확인 처리 */
	@Override
	public Integer passwordConfirm(BoardVO boardVO) throws Exception {
		return boardMapper.passwordConfirm(boardVO);
	}

	/** 전체 개수 가져오기 */
	@Override
	public Integer boardTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.boardTotalCount(pageMaker);
	}

	/** 조회수 증가 처리 */
	@Override
	public void viewCntAdd(BoardVO boardVO) throws Exception {
		boardMapper.viewCntAdd(boardVO);
	}

	/** 상세보기의 목록 처리 */
	@Override
	public List<BoardVO> getReadLikeList(BoardVO boardVO) throws Exception {
		return boardMapper.getReadLikeList(boardVO);
	}

	/** 조회수 많은 것 가져오기 */
	@Override
	public List<BoardVO> bestViewList() throws Exception {
		return boardMapper.bestViewList();
	}

	/** 댓글 많은것 목록 가져오기 */
	@Override
	public List<BoardVO> bestCommentList() throws Exception {
		return boardMapper.bestCommentList();
	}

	@Override
	public void deleteImgFile(BoardVO boardVO) throws Exception {
		boardMapper.deleteImgFile(boardVO);		
	}

	@Override
	public List<BoardVO> getMainQnaList() throws Exception {
		return boardMapper.getMainQnaList();
	}

	@Override
	public List<BoardVO> getMainfreeList() throws Exception {
		return boardMapper.getMainfreeList();
	}

	@Override
	public Integer galleryMosaicListTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.galleryMosaicListTotalCount(pageMaker);
	}

	@Override
	public List<BoardVO> galleryMosaicList(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.galleryMosaicList(pageMaker) ;
	}

	@Override
	public List<BoardVO> dailyBestList() throws Exception {
		return boardMapper.dailyBestList();
	}

	@Override
	public List<BoardVO> weeklyBestList() throws Exception {
		return boardMapper.weeklyBestList();
	}

	@Override
	public List<BoardVO> monthlyBestList() throws Exception {
		return boardMapper.monthlyBestList();
	}

	@Override
	public int myBoardTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.myBoardTotalCount(pageMaker);
	}

	@Override
	public List<BoardVO> myBoardList(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.myBoardList(pageMaker);
	}

	@Override
	public List<BoardVO> mainBestList(String orderType) throws Exception {
		return boardMapper.mainBestList(orderType);
	}

	@Override
	public List<BoardVO> mapList(PageMakerAndSearch pageMaker) throws Exception {
		return boardMapper.mapList(pageMaker);
	}

}
