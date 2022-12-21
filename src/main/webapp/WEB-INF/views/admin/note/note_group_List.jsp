<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

										<li class="nav-item " onclick="location.href='${home}/admin/note/receiveList'">
										<a class="nav-link " id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab"
											aria-selected="false"
										>개별 쪽지함</a></li>


										<li class="nav-item" onclick="location.href='${home}/admin/note/adminGroupMessgeList'">
										<a class="nav-link active " id="contact-tab" data-bs-toggle="tab" href="#" role="tab" aria-selected="false"> 
										유저별쪽지함</a>
										</li>

									</ul>
								</div>





								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">




                    <div class="row">
      
                        <div class="col-xl-12 col-lg-12">
                            <div class="card shadow mb-4">                                     
                                <div class="card-body">
                 		
                        		<div class="mb-5" id="note-head">
										<h2>유저별 전체관리 (${totalCount})</h2>
								</div>
								
                <div class="col-xl-12 col-lg-12">
       
		<form action="/admin/note/adminGroupMessgeList" id="searchForm">
							<div class="mb-3">
								<div class="row">
									<div class="col-xl-4 col-lg-4" style="width: 15%">
										<select name="searchType" class="form-control">
											<option value="all">전체</option>
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
                                <table class="table table-bordered table-hover" id="dataTable" >
                                    <thead>
                                       <tr class="text-center">
											<th width="15%">보낸이</th>
											<th width="15%">받는이</th>
											<th>제목</th>
											<th width="10%">등록일</th>
											<th width="10%">읽은 시간</th>
                                            <th width="10%">
	                                            <span style="margin-right: 15px;">
	                                            	<input type="checkbox" value="all" style="margin-right: 5px;" id="allCheckBox">전체
	                                             </span>
	                                            <button class="btn btn-danger" onclick="deleteSelectGroup()">선택 삭제</button>
                                            </th>                                           
                                        </tr>
                                    </thead>    
                                    <tbody>
                                    <c:if test="${empty adminGroupMessgeList }">
                                           <tr>
	                                            <td class="text-center" colspan="6">  
	                                            	 데이터가 없습니다.
	                                            </td>
                                            </tr>
                                    </c:if>
                                    <c:forEach items="${adminGroupMessgeList}" var="row">
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
	                                            	${empty row.title ? row.content: row.title}
												</div>	
	                                         </td>
                             
                             
                                            <td class="align-middle" style="text-align: center;"> 
                       								<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd" />
												   <span class="text-center ml-3">(${row.customSendDate()})</span>
                                            </td>
                                            <td class="text-center align-middle" >
                                             <c:choose>
                                             	<c:when test="${row.readCnt ==0}">                                             	  
                                             		<span class="badge badge-danger badge-counter">${row.totCnt} +</span>
                                             		<span class="${row.readCnt==0?'notRead':''}" 
                                             		onclick="location.href='/admin/note/read/${row.noteId}?sendId=${row.sendId}&receiveId=${row.receiveId}'">
                                             		
                                             		읽지않음</span>
                                             	</c:when>
                                             	<c:otherwise>
                                             		 <fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd"/>
                                             		 <span class="text-center">(${row.customReadDate()})</span>
                                             	</c:otherwise>
                                             </c:choose>
                                            </td>
                                            
                                            <td class="align-middle">
                                            	<div class="delete" style=" display: flex; justify-content: space-evenly;">
                                            		<input type="checkbox" 	name="sendId" class="sendId"	value="${row.sendId}" >
                                            		<button class="btn btn-danger" style="top: 7px;position: relative;"
                                            		onclick="deleteGroupNote('${row.sendId}', '${row.sendName}')">삭제</button>
                                            	</div>                                            
                                            </td>                                        
                                        </tr>
                                     </c:forEach>
                                    </tbody>
                                </table>
                                
                                
                                <div class="flex justify-content-center">
                               		 ${pagination}
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
$(document).ready(function(){    

	
    $("#searchBtn").on("click",
        function(event){         
          var url ="list${pageMaker.makeQuery(1)}";
          url +="&searchType="+searchType()+"&keyword="+keywordInput();
          self.location =url;   
    });
});
 
function searchType(){
    return $("#searchType").val();
}
 
function keywordInput(){
    return $("#keywordInput").val();
}
function enterkey() {
	if (window.event.keyCode == 13) {
		 $("#searchBtn").click();
    }
}

</script>
</body>
</html>

