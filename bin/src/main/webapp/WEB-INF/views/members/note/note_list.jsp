<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include  file="../include/head.jsp" %>

</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
		<%@ include file="../include/sidebar.jsp"%>


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

		     <%@ include file="../include/topbar.jsp"%>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3  text-gray-800">쪽지함</h1>                      
                    </div>
                    

                    <!-- 탑메뉴 -->						
		  			<%@ include file="../include/top_menu.jsp"%>
                    <!-- 탑메뉴 -->
                    

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-12 col-lg-12">
                            <div class="card shadow mb-4">                               
                                <!-- Card Body -->
                                <div class="card-body">
                 		
                 		<div class="mb-5" id="note-head" >
                 			<h2>받은쪽지함(${totalCount})</h2>
                 			<div>
                 				<button class="btn btn-info mr-3"  onclick="location.href='/members/note/receiveList'">개별 쪽지함</button>
                 				<button class="btn btn-default"  onclick="location.href='/members/note/groupMessgeList'">유저별 쪽지함</button>
                 			</div>
                 		</div>                   
                <div class="col-xl-6 col-lg-6">
                 
               <form action="/members/note/receiveList" id="searchForm">
                        <div class="mb-3" >
                          <div class="row">
                			<div class="col-xl-4 col-lg-4">                                    
                        	<select name="searchType" class="form-control">
                        		<option value="all">전체</option>
                        		<option value="sendName" ${param.searchType eq 'sendName' ? 'selected' :''}>보낸이</option>
                        		<option value="title" ${param.searchType eq 'title' ? 'selected' :''}>제목</option>                        		
                        	</select>
                        	</div>
                        	<div class="col-xl-8 col-lg-8 input-group">
	                            <input type="search" class="form-control bg-light border-0 small" name="keyword"
	                             placeholder="검색어를 입력해 주세요." aria-label="Search" aria-describedby="basic-addon2" value="${param.keyword}">
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
                                            <th>제목</th>
                                            <th width="15%">보낸이</th>
                                            <th width="15%">등록일</th>
                                            <th width="15%">읽은 시간</th>
                                            <th width="15%">
	                                            <span style="margin-right: 15px;">
	                                            	<input type="checkbox" value="all" style="margin-right: 5px;" id="allCheckBox">전체
	                                             </span>
	                                            <button class="btn btn-danger" onclick="deleteSelect()">선택 삭제</button>
                                            </th>                                           
                                        </tr>
                                    </thead>    
                                    <tbody>
                                    <c:if test="${empty receiveList }">
                                           <tr>
	                                            <td class="text-center" colspan="5">  
	                                            	 데이터가 없습니다.
	                                            </td>
                                            </tr>
                                    </c:if>
                                    <c:forEach items="${receiveList}" var="row">
                                        <tr>
                                            <td onclick="location.href='/members/note/read/${row.noteId}?sendId=${row.sendId}'" class="align-middle">  
	                                            <div class="td-title">                                                                                   	
	                                            	${empty row.title ? row.content: row.title}
												</div>	
	                                         </td>
                                             <td class="text-center align-middle" style="height: 70px;vertical-align: inherit;">                                                                                     	
                                            	<span class="userColor ${row.userColor}">${fn:substring(row.sendName,0,1)}                                            	
                                            	</span>
                                            	
                                            	<p><small>[${row.sendName}]</small></p>
                                             </td>
                                            <td class="align-middle"> <fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd hh:mm:ss"/>
                                            <p class="text-center">${row.customSendDate()}</p>
                                            </td>
                                            <td class="text-center align-middle" >
                                             <c:choose>
                                             	<c:when test="${row.readCnt ==0}">                                             	  
                                             		<span class="${row.readCnt==0?'notRead':''}" 
                                             		onclick="location.href='/members/note/read/${row.noteId}?sendId=${row.sendId}'">읽지않음</span>
                                             	</c:when>
                                             	<c:otherwise>
                                             		 <fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd hh:mm:ss"/>
                                             		  <p class="text-center">${row.customReadDate()}</p>
                                             	</c:otherwise>
                                             </c:choose>
                                            </td>
                                            
                                            <td class="align-middle">
                                            	<div class="delete">
                                            		<input type="checkbox" 	name="noteId" class="noteId"	value="${row.noteId}" >
                                            		<button class="btn btn-danger" onclick="deleteNote('${row.noteId}')">삭제</button>
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
                <!-- /.container-fluid -->



            </div>
            <!-- End of Main Content -->

            
            	
 			<%@ include file="../include/footer.jsp" %>
            

        </div>
        <!-- End of Content Wrapper -->


    </div>
    <!-- End of Page Wrapper -->




 <%@ include file="../include/logout_modal.jsp" %>
 <%@ include file="../include/footer_script.jsp" %>


<script>
function deleteNote(noteId){	
	if(confirm("정말 삭제 하시겠습니까?")) {
		$.ajax({
			url:"/members/note/deleteNote",
			type:"delete",
			data:{noteId},
			success:function(res){
				if(res=="success"){
					location.href="/members/note/receiveList";
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
})


function deleteSelect(){
  let chk_val=[];
  $("input[type=checkbox][name=noteId]:checked").each(function(i, ival){
	  chk_val.push($(ival).val());  
  })
  if(chk_val.length===0){
	  alert("삭제할 데이터를 선택해 주세요.");
	  return;
  }
    console.log(chk_val);
  if(confirm("정말 삭제 하시겠습니까?")){
	 	jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url:"/members/note/deleteSelect",
			type:"delete",
			data:{noteId:chk_val},
			success:function(res){
				console.log(res);
				if(res=="success"){
				location.href="/members/note/receiveList";
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
