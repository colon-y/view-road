<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<style type="text/css">
.table th, .table td {
    line-height: 2;
    white-space: inherit;

}
</style>
</head>
<body>
	<div class="container-scroller">


		<%@ include file="../include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_settings-panel.html -->


			<%@ include file="../include/right_setting.jsp"%>

			<!-- partial -->
			<!-- partial:partials/_sidebar.html -->


			<%@ include file="../include/left_menu.jsp"%>

			<input type="hidden" id="group" value="${group}">	
			<input type="hidden" id="sendId" value="${sendId}"> 
			<input type="hidden" id="receiveId" value="${receiveId}"> 
			<input type="hidden" id="sendName" value="${sendName}">
			
			
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-sm-12">
							<div class="home-tab">
								<div class="d-sm-flex align-items-center justify-content-between border-bottom">
									<ul class="nav nav-tabs" role="tablist">
										<li class="nav-item" onclick="location.href='${home}/admin'">
										<a class="nav-link  ps-0" id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview"
											aria-selected="true"
										>관리자 메인화면</a></li>

										<li class="nav-item" onclick="location.href='${home}/admin/note/receiveList'"><a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab"
											aria-selected="false"
										>개별 쪽지함</a></li>


										<li class="nav-item" onclick="location.href='${home}/admin/note/adminGroupMessgeList'">
										<a class="nav-link  " id="contact-tab" data-bs-toggle="tab" href="#" role="tab"
											aria-selected="false"
										> 유저별 쪽지함</a></li>
									</ul>

								</div>



								<div class="tab-content tab-content-basic">


									<div class="row">

										<!-- Area Chart -->
										<div class="col-xl-12 col-lg-12">
											<div class="card shadow mb-4">
												<!-- Card Body -->
												<div class="card-body">

													<div class="mb-5" id="note-head">
														<h2>쪽지 내용보기</h2>
								
													</div>


													

													<div class="table-responsive">
														<table class="table" id="dataTable">
															<tbody>
																<tr>
																	<td class="table-info text-center">
																		<button onclick="noteShow(this)" class="btn btn-primary show-on-btn">전체쪽지 내용보기</button>


																	</td>
																	<td>
																	
																	<span id="noteShowText">
																	
																	<span class="text-primary">'전체쪽지 내용보기'
																	</span> </span>
																	
																		<div class="container" id="message-container">
																			<h3 class="text-center"></h3>
																			<div class="messaging">
																				<div class="inbox_msg">

																					<div class="mesgs">
																						<div class="msg_history">


																							<!-- 메시지 내용 -->
																						</div>


												<!-- 										<div class="type_msg">
																							<div class="input_msg_write">
																								<input type="text" class="write_msg" placeholder="내용을 입력해 주세요." />
																								<button class="msg_send_btn" type="button" id="msg_send_btn">
																									<i class="far fa-paper-plane" aria-hidden="true"></i>
																								</button>
																							</div>
																						</div> -->
																					</div>
																				</div>

																			</div>

																		</div></td>
																</tr>
																<tr>
																	<td class="table-info text-center" width="15%">보낸이</td>
																	<td>${noteInfo.sendName}</td>
																</tr>
																<tr>
																	<td class="table-info text-center">제목</td>
																	<td>${noteInfo.title}</td>
																</tr>
																<tr>
																	<td class="table-info text-center">내용</td>
																	<td>
																	<div>
																	${noteInfo.content}
																	</div>
																	
																	</td>
																</tr>
																<tr>
																	<td class="table-info text-center">보낸날짜</td>
																	<td>${noteInfo.sendDate}</td>
																</tr>
																<tr>
																	<td class="text-center" colspan="2">
																		<button class="btn btn-dark" onclick="history.back()">이전화면</button>	
																		
																		
														<button class="btn btn-primary noteModal"  data-target="#noteModal" 
														onclick="noteModal()"
														data-toggle="modal">메시지 보내기</button>																
																
																	</td>
																</tr>
															</tbody>
														</table>
													</div>




												</div>
											</div>
										</div>

									</div>




								</div>


							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->


				<%@ include file="../include/footer.jsp"%>


				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>





	<!-- Modal -->
	<div class="modal fade" id="noteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			       <h4 class="modal-title text-left" id="myModalLabel"><i class="far fa-paper-plane" ></i> 쪽지 보내기</h4>		
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
			       	        
			      </div>			      			      
			   <div class="modal-body">				
						<div class="text-left mb-3">
							<span>받는 회원 선택</span>
							<!-- <input type="text" class="form-control" id="note-username" readonly="readonly" >
							<input type="hidden" class="form-control" id="note-uid" readonly="readonly"> -->
							<select name="note-uid" id="note-uid" class="form-control mb-3">
								<option value="${noteInfo.sendId}">${noteInfo.sendName}</option>
								<option value="${noteInfo.receiveId}">${noteInfo.receiveName}</option>
							</select>							
						</div>
						<div class="text-left mtb-20 mb-3">
							<span>제목</span>			    
							<input type="text" class="form-control" id="note-title" maxlength="200" >
						</div>				    
						<div class="text-left mtb-20 mb-3">
							<span>내용</span>			    
							<textarea class="form-control" id="note-textarea" maxlength="500"></textarea>
						</div>						
						<div class="text-center mtb-20">
							<button type="button" class="btn btn-primary"  id="note-send-btn">보내기</button>	
						</div>									    					
			     </div>
			   </div>
		</div>
	</div>
	

	<%@ include file="../include/footer_script.jsp"%>
   <script src="/resources/admin/js/note/note_read.js"></script>

<script>
function noteModal(){
	
}
</script>

</body>
</html>

