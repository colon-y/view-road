package view.road.service;

import java.util.List;
import java.util.Map;

import view.road.model.vo.NoteVO;
import view.road.util.config.PageMakerAndSearch;


public interface NoteService {

	public int insertNote(NoteVO noteVO) throws Exception;
	
	public int noteReceiveTotalCount(PageMakerAndSearch pageMaker) throws Exception;
	
	public List<NoteVO> listNoteReceive(PageMakerAndSearch pageMaker) throws Exception;
	
	public int deleteNote(NoteVO noteVO) throws Exception;

	public int deleteNote(Map<String, Object> map) throws Exception;

	public NoteVO readNote(NoteVO noteVO) throws Exception;

	public void updateReadCnt(NoteVO noteVO) throws Exception;

	public List<NoteVO> messageList(NoteVO noteVO) throws Exception;

	public int updateTotalReadCnt(NoteVO noteVO) throws Exception;

	public void deleteMyNote(NoteVO noteVO) throws Exception;

	public List<NoteVO> groupMessgeList(PageMakerAndSearch pageMaker) throws Exception;

	public int groupMessgeListTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public int deleteGroupNote(NoteVO noteVO) throws Exception;

	public int noticeCount(NoteVO noteVO) throws Exception;

	public List<NoteVO> notificationMessage(NoteVO noteVO) throws Exception;

	public int noteReceiveAdminTotalCount(PageMakerAndSearch pageMaker) throws Exception;

	public List<NoteVO> listNoteAdminReceive(PageMakerAndSearch pageMaker) throws Exception;

	public void deleteRealNote(NoteVO noteVO)  throws Exception;

	public int adminGroupMessgeListTotalCount(PageMakerAndSearch pageMaker)  throws Exception;

	public List<NoteVO> adminGroupMessgeList(PageMakerAndSearch pageMaker)  throws Exception;
	
	


	
}
