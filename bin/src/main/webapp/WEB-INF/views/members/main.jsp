<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include  file="./include/head.jsp" %>
<style type="text/css">
.text-xs {font-size: 1.2rem;}
.text-gray-800{font-weight: bold;}
.img-box{
 position: relative;
 width: 80px;
 display: inline-block;
}
.img-box img{width: 100%; }
tbody tr td {vertical-align: inherit !important;}
.delete {
    display: flex;
    align-content: space-around;
    justify-content: space-around;
}
</style>
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
		<%@ include file="./include/sidebar.jsp"%>


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

		     <%@ include file="./include/topbar.jsp"%>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">마이페이지</h1>                      
                    </div>
                    

                    <!-- 탑메뉴 -->						
		  			<%@ include file="./include/top_menu.jsp"%>
                    <!-- 탑메뉴 -->
                    

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-12 col-lg-12">
                            <div class="card shadow mb-4">                               
                                <!-- Card Body -->
                                <div class="card-body">
                            
                            
                                                                
                <div class="col-xl-6 col-lg-6">
               <form action="/members" id="searchForm">
                        <div class="mb-3" >
                          <div class="row">
                			<div class="col-xl-4 col-lg-4">                                    
                        	<select name="boardType" class="form-control">
                        		<option value="all">전체</option>
                        		<option value="place_introduction" ${param.boardType eq 'place_introduction' ? 'selected' :''}>장소 소개</option>
                        		<option value="place_reviews" ${param.boardType eq 'place_reviews' ? 'selected' :''}>장소 후기</option>
                        		<option value="qna" ${param.boardType eq 'qna' ? 'selected' :''}>질문과 답변</option>
                        		<option value="free" ${param.boardType eq 'free' ? 'selected' :''}>자유 게시판</option>
                        	</select>
                        	</div>
                        	<div class="col-xl-8 col-lg-8 input-group">
	                            <input type="search" class="form-control bg-light border-0 small" name="keyword"
	                             placeholder="제목 검색" aria-label="Search" aria-describedby="basic-addon2" value="${param.keyword}">
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
                                <table class="table table-bordered" id="dataTable" >
                                    <thead>
                                        <tr class="text-center">
                                            <th>게시판명</th>
                                            <th>이미지</th>
                                            <th width="40%">제목</th>
                                            <th width="20%">날짜</th>
                                            <th>
                                            수정 및 삭제
                                          <!--   <span>
                                            <input type="checkbox" value="all" style="margin-right: 5px;" id="allCheckBox">전체
                                             </span> -->
                                          <!--   <button class="btn btn-danger" onclick="deleteSelect()">선택 삭제</button> -->
                                            </th>                                           
                                        </tr>
                                    </thead>    
                                    <tbody>
                                    <c:if test="${empty myBoardList }">
                                                    <tr>
                                            <td class="text-center" colspan="5">  
                                            	작성한 게시글이  없습니다.
                                            </td>
                                            </tr>
                                    </c:if>
                                    <c:forEach items="${myBoardList}" var="row">
                                        <tr>
                                            <td class="text-center">                                          
                                            <c:choose>
                                            	<c:when test="${row.boardType eq 'place_introduction'}">
                                            		<span class="btn-primary p-1">장소 소개</span>
                                            	</c:when>
                                            	<c:when test="${row.boardType eq 'place_reviews'}">
                                            		<span class="btn-info p-1">장소 후기</span>
                                            	</c:when>   
                                            	<c:when test="${row.boardType eq 'qna'}">
                                            		<span class="btn-success p-1">질문과 답변</span>
                                            	</c:when>  
                                            	<c:when test="${row.boardType eq 'free'}">
                                            		<span class="btn-warning p-1">자유 게시판</span>
                                            	</c:when>                                              	                                            	                                         	                                            
                                            </c:choose>                                            
                                            </td>
                                             
                                            <td class="text-center">
                                           
                                            <div class="img-box text-center">
												<c:choose>
													<c:when test="${empty row.fileName}">
														<img src="/resources/web/images/no_image.png"  alt="${row.title}" class="img-responsive">
													</c:when>
													<c:otherwise>
														<img src="/displayFile?fileName=${row.fileName}"  alt="${row.title}" class="img-responsive">	
													</c:otherwise>
												</c:choose>								
											</div>

                                            </td>
                                            
                                            <td>
                                            <c:choose>
                                            	<c:when test="${row.boardType eq 'place_introduction'}">
                                            		<a href="/place/introduction/read/${row.bno}">${row.title}</a>
                                            	</c:when>
                                            	<c:when test="${row.boardType eq 'place_reviews'}">
                                            		<a href="/place/reviews/read/${row.bno}">${row.title}</a>
                                            	</c:when>   
                                            	<c:when test="${row.boardType eq 'qna'}">
                                            		<a href="/board/qna/read/${row.bno}">${row.title}</a>                                            		
                                            	</c:when>  
                                            	<c:when test="${row.boardType eq 'free'}">
                                            		<a href="/board/free/read/${row.bno}">${row.title}</a>
                                            	</c:when>                                              	                                            	                                         	                                            
                                            </c:choose>             
                                           
                                            </td>
                                            <td class="text-center">
                                            <fmt:formatDate value="${row.createdDate}" pattern="yyyy-MM-dd hh:ss"/>
                                            </td>
                                            <td>
                                              <div class="delete">
                                           <%--  	<input type="checkbox" 	name="bno" class="bno"	value="${row.bno}" >
                                            	 --%>
                  
                                            <c:choose>
                                            	<c:when test="${row.boardType eq 'place_introduction'}">
	                                            	<form action="/place/introduction/boardEditDirect" method="post"> 
	                                            	 <input type="hidden" name="bno" value="${row.bno}">                                           
	                                            	 <button class="btn btn-success" >수정</button>
	                                            	</form>                                            		
                                            	</c:when>
                                            	<c:when test="${row.boardType eq 'place_reviews'}">
	                                            	<form action="/place/reviews/boardEditDirect" method="post">                                            
	                                            	 <input type="hidden" name="bno" value="${row.bno}">
	                                            	 <button class="btn btn-success" >수정</button>
	                                            	</form> 
                                            	</c:when>   
                                            	<c:when test="${row.boardType eq 'qna'}">
	                                            	<form action="/board/qna/boardEditDirect" method="post">  
	                                            	 <input type="hidden" name="bno" value="${row.bno}">                                          
	                                            	 <button class="btn btn-success" >수정</button>
	                                            	</form>                                           		
                                            	</c:when>  
                                            	<c:when test="${row.boardType eq 'free'}">
	                                            	<form action="/board/free/boardEditDirect" method="post">                                            
	                                            	<input type="hidden" name="bno" value="${row.bno}">
	                                            	 <button class="btn btn-success" >수정</button>
	                                            	</form> 
                                            	</c:when>                                              	                                            	                                         	                                            
                                            </c:choose> 
                         	
                                            	<button class="btn btn-danger" onclick="deleteBoard('${row.bno}')">삭제</button>
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

            
            	
 			<%@ include file="./include/footer.jsp" %>
            

        </div>
        <!-- End of Content Wrapper -->


    </div>
    <!-- End of Page Wrapper -->




 <%@ include file="./include/logout_modal.jsp" %>
 <%@ include file="./include/footer_script.jsp" %>



<script>
function deleteBoard(bno){	
	if(confirm("정말 삭제 하시겠습니까?")) {
		$.ajax({
			url:"/members/my/deleteBoard",
			type:"delete",
			data:{bno},
			success:function(res){
				if(res=="success"){
					location.href="/members";
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
		if($("#allCheckBox").is(":checked")) $("input[name=scno]").prop("checked", true);
		else $("input[name=scno]").prop("checked", false);
	});	
	$("select[name='boardType']").on("change", function(){
			$("#searchForm").submit();
	})	
})


function deleteSelect(){
  let chk_val=[];
  $("input[type=checkbox][name=scno]:checked").each(function(i, ival){
	  chk_val.push($(ival).val());  
  })
  if(chk_val.length===0){
	  alert("삭제할 데이터를 선택해 주세요.");
	  return;
  }
  if(confirm("정말 삭제 하시겠습니까?")){
	 	jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url:"/members/scrap/deleteSelect",
			type:"delete",
			data:{scno:chk_val},
			success:function(res){
				console.log(res);
				if(res=="success"){
				location.href="/members/scrap/list";
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
