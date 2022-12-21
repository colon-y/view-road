package view.road.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import view.road.model.dao.mapper.NoteMapper;
import view.road.model.vo.NoteVO;
import view.road.service.NoteService;
import view.road.util.config.PageMakerAndSearch;

@Service
public class NoteServiceImpl implements NoteService {

	
	@Autowired
	private NoteMapper noteMapper;

	@Override
	public int insertNote(NoteVO noteVO) throws Exception {			
		return noteMapper.insertNote(noteVO);
	}

	@Override
	public int noteReceiveTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return noteMapper.noteReceiveTotalCount(pageMaker);
	}

	@Override
	public List<NoteVO> listNoteReceive(PageMakerAndSearch pageMaker) throws Exception {
		return noteMapper.listNoteReceive(pageMaker);
	}

	@Override
	public int deleteNote(NoteVO noteVO) throws Exception {
		return noteMapper.deleteNote(noteVO);
	}

	@Override
	public int deleteNote(Map<String, Object> map) throws Exception {
		return noteMapper.deleteNote(map);
	}

	@Override
	public NoteVO readNote(NoteVO noteVO) throws Exception {		
		return noteMapper.readNote(noteVO);
	}

	@Override
	public void updateReadCnt(NoteVO noteVO) throws Exception {
		noteMapper.updateReadCnt(noteVO);				
	}

	@Override
	public List<NoteVO> messageList(NoteVO noteVO) throws Exception {
		return noteMapper.messageList(noteVO);	
	}

	@Override
	public int updateTotalReadCnt(NoteVO noteVO) throws Exception {
		return noteMapper.updateTotalReadCnt(noteVO);	
	}

	@Override
	public void deleteMyNote(NoteVO noteVO) throws Exception {
		 noteMapper.deleteMyNote(noteVO);			
	}

	
	@Override
	public List<NoteVO> groupMessgeList(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.groupMessgeList(pageMaker);		
	}

	@Override
	public int groupMessgeListTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.groupMessgeListTotalCount(pageMaker);		
	}

	@Override
	public int deleteGroupNote(NoteVO noteVO) throws Exception {
		return  noteMapper.deleteGroupNote(noteVO);				
	}

	@Override
	public int noticeCount(NoteVO noteVO) throws Exception {
		return  noteMapper.noticeCount(noteVO);		
	}

	@Override
	public List<NoteVO> notificationMessage(NoteVO noteVO) throws Exception {
		return  noteMapper.notificationMessage(noteVO);	
	}

	@Override
	public int noteReceiveAdminTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.noteReceiveAdminTotalCount(pageMaker);	
	}

	@Override
	public List<NoteVO> listNoteAdminReceive(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.listNoteAdminReceive(pageMaker);	
	}

	@Override
	public void deleteRealNote(NoteVO noteVO) throws Exception {
		  noteMapper.deleteRealNote(noteVO);			
	}

	@Override
	public int adminGroupMessgeListTotalCount(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.adminGroupMessgeListTotalCount(pageMaker);	
	}

	@Override
	public List<NoteVO> adminGroupMessgeList(PageMakerAndSearch pageMaker) throws Exception {
		return  noteMapper.adminGroupMessgeList(pageMaker);	
	}
	
	
	


	
}
