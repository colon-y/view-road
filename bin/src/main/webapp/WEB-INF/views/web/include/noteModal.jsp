<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="modal fade" id="noteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
			        <h4 class="modal-title" id="myModalLabel"><i class="far fa-paper-plane" ></i> 쪽지 보내기</h4>			        
			      </div>			      			      
			   <div class="modal-body">				
						<div class="text-left">
							<span>받는 회원</span>
							<input type="text" class="form-control" id="note-username" readonly="readonly">
							<input type="hidden" class="form-control" id="note-uid" readonly="readonly">
						</div>
						<div class="text-left mtb-20">
							<span>제목</span>			    
							<input type="text" class="form-control" id="note-title" maxlength="200" >
						</div>				    
						<div class="text-left mtb-20">
							<span>내용</span>			    
							<textarea class="form-control" id="note-textarea" maxlength="500"></textarea>
						</div>						
						<div class="text-center mtb-20">
							<button type="button" class="btn btn-primary" id="note-send-btn">보내기</button>	
						</div>									    					
			     </div>
			   </div>
		</div>
	</div>