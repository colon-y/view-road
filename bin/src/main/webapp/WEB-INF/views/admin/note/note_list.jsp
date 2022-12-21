<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<style type="text/css">
a{
text-decoration: none;
}
.table td img {
	width: 80px;
	height: auto;
	border-radius: 1%
}
.td-title{
max-width: 460px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;

}
.board-paging li a{
color: #fff !important;
}
.btn-warning, .btn-danger{
padding: 8px 8px !important;
}
</style>
</head>
<body>
	<div class="container-scroller">


		<%@ include file="../include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">

			<%@ include file="../include/right_setting.jsp"%>

			<%@ include file="../include/left_menu.jsp"%>


			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-sm-12">
							<div class="home-tab">

								<div class="d-sm-flex align-items-center justify-content-between border-bottom">
									<ul class="nav nav-tabs" role="tablist">
										<li class="nav-item" onclick="location.href='${home}/admin'"><a class="nav-link   ps-0" id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview"
											aria-selected="true"
										>관리자 메인화면</a></li>

										<li class="nav-item " onclick="location.href='${home}/admin/note/receiveList'"><a class="nav-link active" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab"
											aria-selected="false"
										>개별 쪽지관리</a></li>


										<li class="nav-item" onclick="location.href='${home}/admin/note/adminGroupMessgeList'">
										<a class="nav-link  " id="contact-tab" data-bs-toggle="tab" href="#" role="tab" aria-selected="false"> 
										유저별 쪽지관리</a>
										</li>

									</ul>
								</div>





								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">





										<div class="row">

											<!-- Area Chart -->
											<div class="col-xl-12 col-lg-12">
												<div class="card shadow mb-4">
													<!-- Card Body -->
													<div class="card-body">

														<div class="mb-5" id="note-head">
															<h2>개별쪽지 전체관리 (${totalCount})</h2>
														</div>
														<div class="col-xl-12 col-lg-12">

															<form action="/admin/note/receiveList" id="searchForm">
																<div class="mb-3">
																	<div class="row">
																		<div class="col-xl-4 col-lg-4" style="width: 15%">
																			<select name="searchType" class="form-control">
																				<option value="all">전체</option>
																				<option value="hide" ${param.searchType eq 'hide' ? 'selected' :''}>숨김처리</option>
																				<option value="sendName" ${param.searchType eq 'sendName' ? 'selected' :''}>보낸이</option>
																				<option value="receiveName" ${param.searchType eq 'receiveName' ? 'selected' :''}>받는이</option>
																				<option value="title" ${param.searchType eq 'title' ? 'selected' :''}>제목</option>																				
																			</select>
																		</div>
																		<div class="col-xl-8 col-lg-8 input-group" style="width: 30%">
																			<input type="search" class="form-control bg-light border-0 small" 
																			name="keyword" placeholder="검색어를 입력해 주세요." aria-label="Search" aria-describedby="basic-addon2"
																				value="${param.keyword}">
																			
																			<div class="input-group-append">
																				<button class="btn btn-primary" type="submit">
																					<i class="fas fa-search fa-sm"></i>
																				</button>
																			</div>
																		</div>
																	</div>

																</div>
															</form>
														</div>

														<div class="table-responsive">
															<table class="table table-bordered table-hover" id="dataTable">
																<thead>
																	<tr class="text-center">
																		
																		<th width="15%">보낸이</th>
																		<th width="15%">받는이</th>
																		<th>제목</th>
																		<th width="10%">등록일</th>
																		<th width="10%">읽은 시간</th>
																		<th width="10%">
																		<span style="margin-right: 10px;"> 
																		<input type="checkbox" value="all" 
																		style="margin-right: 5px;" id="allCheckBox">전체
																		</span>
																			<button class="btn btn-warning"  onclick="hideSelect()">선택숨김</button>
																			<button class="btn btn-danger" onclick="deleteRealSelect()">선택삭제</button>
																		</th>
																	</tr>
																</thead>
																<tbody>
																	<c:if test="${empty receiveList }">
																		<tr>
																			<td class="text-center" colspan="6">데이터가 없습니다.</td>
																		</tr>
																	</c:if>
																	<c:forEach items="${receiveList}" var="row">	
																	
																	<tr>
																	
																	  <td class="text-left align-middle" style="vertical-align: inherit;">
																			<a href="/admin/member/memberInfo?uid=${row.sendId}"> 
																			 <span class="userColor ${row.userColor}">${fn:substring(row.sendName,0,1)}
																			 </span>
																			 <span><small>[${row.sendName}]</small></span>
																			 </a>
																	   </td>
	
																		<td class="text-left align-middle" style="vertical-align: inherit;">
																		 <a href="/admin/member/memberInfo?uid=${row.receiveId}"> 
																			 <span class="userColor ${row.userColor}">${fn:substring(row.receiveName,0,1)}
																			 </span>
																			 <span><small>[${row.receiveName}]</small></span>
																			</a>
																	   </td>																	
																		
																	
																	<td onclick="location.href='/admin/note/read/${row.noteId}?sendId=${row.sendId}&receiveId=${row.receiveId}&group=1'" class="align-middle">
																		<div class="td-title">
																		
																		<c:if test="${row.remove >0}">
																		<span class="text-danger">[삭제처리 되었습니다.]</span>
																		</c:if>
																		${empty row.title ? row.content: row.title}																				
																		</div>																				
																	</td>

																	   
																	   
																			<td class="align-middle">
																				<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd" />
																				<span class="text-center ml-3">(${row.customSendDate()})</span>
																			</td>
																			<td class="text-center align-middle">
																			  <c:choose>
																					<c:when test="${row.readCnt ==0}">
																						<span class="${row.readCnt==0?'notRead':''}" 
																						onclick="location.href='/admin/note/read/${row.noteId}?sendId=${row.sendId}&receiveId=${row.receiveId}&group=1	'">읽지않음</span>
																					</c:when>
																					<c:otherwise>
																						<fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd" />
																						<span class="text-center ml-3">(${row.customReadDate()})</span>
																					</c:otherwise>
																				</c:choose>
																		</td>

																			<td class="align-middle">
																				<div class="delete" style=" display: flex; justify-content: space-evenly;">
																					<input type="checkbox" name="noteId" class="noteId mr-3"
																					style="margin-right: 15px;"
																					 value="${row.noteId}">
																					<button class="btn btn-warning ml-3" onclick="hideNote('${row.noteId}')" 
																					style="top: 7px;position: relative;">숨김처리</button>
																					
																				<button class="btn btn-danger ml-3" onclick="deleteRealNote('${row.noteId}')" 
																					style="top: 7px;position: relative;">삭제</button>
																				</div>
																			</td>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>


															<div class="flex justify-content-center">${pagination}</div>
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
				</div>


				<%@ include file="../include/footer.jsp"%>


				<!-- partial -->
			</div>
			<!-- main-panel ends -->



		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->


	<%@ include file="../include/footer_script.jsp"%>



<script>
function hideNote(noteId){	
	if(confirm("정말 숨김처리 하시겠습니까?")) {
		$.ajax({
			url:"/admin/note/hideNote",
			type:"delete",
			data:{noteId},
			success:function(res){
				if(res=="success"){
					location.href="/admin/note/receiveList";
				}
			},
			error:function(error){
				console.log("error : ", error);
			}
		});			
	}	
}



function deleteRealNote(noteId){	
	if(confirm("정말 삭제처리 하시겠습니까?")) {
		$.ajax({
			url:"/admin/note/deleteRealNote",
			type:"delete",
			data:{noteId},
			success:function(res){
				if(res=="success"){
					location.href="/admin/note/receiveList";
				}
			},
			error:function(error){
				console.log("error : ", error);
			}
		});			
	}	
}

$(function(){
	$("#allCheckBox").on()	
	$("#allCheckBox").click(function() {
		if($("#allCheckBox").is(":checked")) $("input[name=noteId]").prop("checked", true);
		else $("input[name=noteId]").prop("checked", false);
	});	
	$("select[name='boardType']").on("change", function(){
			$("#searchForm").submit();
	});	
	
	$("select[name=searchType]").on("change", function(){
		const thisValue=$(this).val();
		console.log(thisValue);
		if(thisValue==="hide"){
			$("#searchForm").submit();	
		}
		
	});
})


function hideSelect(){
  let chk_val=[];
  $("input[type=checkbox][name=noteId]:checked").each(function(i, ival){
	  chk_val.push($(ival).val());  
  })
  if(chk_val.length===0){
	  alert("숨김처리할 데이터를 선택해 주세요.");
	  return;
  }
    console.log(chk_val);
  if(confirm("정말 숨김처리 하시겠습니까?")){
	 	jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url:"/admin/note/hideSelect",
			type:"delete",
			data:{noteId:chk_val},
			success:function(res){
				console.log(res);
				if(res=="success"){
				location.href="/admin/note/receiveList";
				}
			},
			error:function(error){
				console.log("error : ", error);
			}
		});			
  }		
}


function deleteRealSelect(){
	  let chk_val=[];
	  $("input[type=checkbox][name=noteId]:checked").each(function(i, ival){
		  chk_val.push($(ival).val());  
	  })
	  if(chk_val.length===0){
		  alert("삭제할 데이터를 선택해 주세요.");
		  return;
	  }
	    console.log(chk_val);
	  if(confirm("정말 삭제처리 하시겠습니까?")){
		 	jQuery.ajaxSettings.traditional = true;
			$.ajax({
				url:"/admin/note/deleteRealSelect",
				type:"delete",
				data:{noteId:chk_val},
				success:function(res){
					console.log(res);
					if(res=="success"){
					location.href="/admin/note/receiveList";
					}
				},
				error:function(error){
					console.log("error : ", error);
				}
			});			
	  }		
}
</script>

</body>
</html>

