package view.road.service;

import java.util.List;

import view.road.model.vo.BoardVO;
import view.road.util.config.PageMakerAndSearch;


public interface BoardService {

	//등록
	public void register(BoardVO boardVO) throws Exception;	
	
	//읽기
	public BoardVO getRead(BoardVO boardVO) throws Exception;		
	
	//목록
	public List<BoardVO> getReadList(PageMakerAndSearch pageMaker) throws Exception;	
	
	//삭제
	public void remove(BoardVO boardVO) throws Exception;	
	
	//변경
	public void boardUpdate(BoardVO boardVO) throws Exception;	
	
	//비밀번호 확인
	public Integer passwordConfirm(BoardVO boardVO) throws Exception;
	
	//전체 게시판 갯수
	public Integer boardTotalCount(PageMakerAndSearch pageMaker) throws Exception;
	
	//조회수 증가
	public void viewCntAdd(BoardVO boardVO) throws Exception;
	
	//읽기 상세보기의 목록 처리
	public List<BoardVO> getReadLikeList(BoardVO boardVO) throws Exception;
	
	//조회수가 높은것 5 개 목록 가져오기
	public List<BoardVO> bestViewList() throws Exception;
	
	//글수가 높은것 5개 목록을 가져오
	public List<BoardVO> bestCommentList() throws Exception;

	public void deleteImgFile(BoardVO boardVO) throws Exception;

	public List<BoardVO> getMainQnaList() throws Exception;

	public List<BoardVO> getMainfreeList() throws Exception;

	public Integer galleryMosaicListTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public List<BoardVO> galleryMosaicList(PageMakerAndSearch pageMaker) throws Exception;

	public List<BoardVO> dailyBestList() throws Exception;

	public List<BoardVO> weeklyBestList() throws Exception;

	public List<BoardVO> monthlyBestList() throws Exception;

	public int myBoardTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public List<BoardVO> myBoardList(PageMakerAndSearch pageMaker) throws Exception;

	public List<BoardVO> mainBestList(String orderType) throws Exception;

	public List<BoardVO> mapList(PageMakerAndSearch pageMaker) throws Exception;
	
	
	
	
	
}
