
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
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
										<li class="nav-item" onclick="location.href='${home}/admin'">
										 <a class="nav-link   ps-0" 
										id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" 
										aria-selected="true">관리자 메인화면</a></li>
										
										<li class="nav-item " onclick="location.href='${home}/admin/member/memberList'">
										<a class="nav-link active" id="profile-tab" 
										data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">회원목록</a></li>
										
										
										<li class="nav-item" onclick="location.href='${home}/admin/member/memberWrite'">
										<a class="nav-link  " id="contact-tab" data-bs-toggle="tab"
												href="#" role="tab" aria-selected="false"> 회원등록</a>
										</li>
<%-- 										<li class="nav-item" onclick="location.href='${home}/admin/smtpUpdate'">
										<a class="nav-link " id="contact-tab" data-bs-toggle="tab"
												href="#" role="tab" aria-selected="false"> SMTP 관리</a>
										</li>	 --%>										
									</ul>

								</div>





								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">



										<div class="row">
											<div class="col-lg-12 grid-margin stretch-card">
												<div class="card">
													<div class="card-body">
														<h4 class="card-title">회원목록</h4>
														<p class="card-description">
															
															
					<div class="row">
			                <div class="col-lg-2 offset-lg-2 ">
			                   <select name="searchType" class="form-control" id="searchType" style="height: 40px">
			                     <option value="all" <c:out value="${pageMaker.searchType eq 'all' ? 'selected' : '' }"/>  >전체</option>
			                     <option value="userId" <c:out value="${pageMaker.searchType eq 'userId' ? 'selected' : '' }"/>  >아이디</option>			                     
			                     <option value="username"  <c:out value="${pageMaker.searchType eq 'username' ? 'selected' : '' }"/> >이름</option>
			                     <option value="email" <c:out value="${pageMaker.searchType eq 'email' ? 'selected' : '' }"/>  >이메일</option>
			                     <option value="phone" <c:out value="${pageMaker.searchType eq 'phone' ? 'selected' : '' }"/> >전화번호</option>
			                     
			                   </select>
			               </div>
			                
			               <div class="col-lg-6">
			                  <input type="search" name="keyword" id="keywordInput"  class="form-control" value="${pageMaker.keyword}" onkeyup="enterkey()"
			                  
			                  style="height: 40px"
			                  >     
			               </div>
			               <div class="col-lg-2 text-left">
			                  <button id="searchBtn" class="btn btn-info btn-rounded btn-fw"  style="height: 40px">검색</button>
			               </div>
			                    			     
     		</div>
 
															
															
														
														<div class="table-responsive">
															<table class="table table-striped">
																<thead>
																	<tr  class="text-center">
																		<th>no.</th>
																		<th>아이디</th>
																		<th>이름</th>
																		<th>이메일</th>
																		<th>전화번호</th>
																		<th>성별</th>
																		<th>회원등급</th>
																		<th>회원권한</th>  
																		<th>주소</th>
																		<th>생년월일</th>
																		<th>등록일</th>																
																	</tr>
																</thead>
																<tbody>
				
														<c:forEach items="${list}" var="row">	
														<c:choose>
															<c:when test="${USER.role eq 'ROLE_ADMIN'}">
																<tr onclick="location.href='memberInfo?uid=${row.uid}'"  class="text-center">
																<td class="py-1">
																			${row.num}
																		</td>
																		<td>${row.userId }</td>
																		 <td>${row.username}</td>
																		<td>${row.email }</td>
																		<td>${row.phone}</td>
																		<td>${row.gender eq 'male' ? '남성' :'여성'}</td>
																		<td>Lv. ${row.level}</td>
																		<td>
																			<c:choose>
		<c:when test="${row.role eq 'ROLE_GUEST'}"><span class="btn-dark p-1" style="width: 70px;display: block;text-align: center;">손님</span></c:when>
		<c:when test="${row.role eq 'ROLE_USER'}"><span class="btn-primary p-1">&nbsp;&nbsp;일반회원&nbsp;&nbsp;</span></c:when>
																				<c:when test="${row.role eq 'ROLE_MANAGER'}"><span class="btn-success p-1">중간관리자</span></c:when>
																				<c:otherwise>
																					<span class="btn-danger p-1">최고관리자</span>
																				</c:otherwise>
																			</c:choose>							
																	  </td>
																	    <td>${row.address}</td>
																	     <td  style="white-space: pre-line;max-width: 150px;line-height: 2">
																	     	${row.birth}</td>
																		<td>${row.createdDate}</td>
																		
																</tr>																
															</c:when>
															<c:otherwise>
																<tr onclick="alert('최고 관리자는 열람할수 없습니다.')"  class="text-center">
																	<td class="py-1">
																				${row.num}
																			</td>
																			<td>${row.role eq 'ROLE_MANAGER' ? row.userId :'---'}</td>
																			 <td>${row.username}</td>
																			<td>${row.role eq 'ROLE_MANAGER' ? row.email : '---'}</td>
																			<td>${row.role eq 'ROLE_MANAGER' ? row.phone : '---'}</td>
																			<td>${row.role eq 'ROLE_MANAGER' ? (row.gender eq 'male' ? '남성' :'여성') : '---'}</td>
																			<td>Lv. ${row.level}</td>
																			<td>
																				<c:choose>
			<c:when test="${row.role eq 'ROLE_GUEST'}"><span class="btn-dark p-1" style="width: 70px;display: block;text-align: center;">손님</span></c:when>
			<c:when test="${row.role eq 'ROLE_USER'}"><span class="btn-primary p-1">&nbsp;&nbsp;일반회원&nbsp;&nbsp;</span></c:when>
																					<c:when test="${row.role eq 'ROLE_MANAGER'}"><span class="btn-success p-1">중간관리자</span></c:when>
																					<c:otherwise>
																						<span class="btn-danger p-1">최고관리자</span>
																					</c:otherwise>
																				</c:choose>							
																		  </td>
																		    <td>${row.role eq 'ROLE_MANAGER' ? row.address : '---'}</td>
																		     <td  style="white-space: pre-line;max-width: 150px;line-height: 2">
																		     	${row.role eq 'ROLE_MANAGER' ? row.birth : '---'}</td>
																			<td>${row.role eq 'ROLE_MANAGER' ? row.createdDate : '---'}</td>
																			
																		</tr>																
																
															</c:otherwise>
														</c:choose>		
													
	
														</c:forEach>
																	
																</tbody>
																	
																<tfoot>
																	<tr>
																		<td colspan="11">
																			${pageMaker.bootStrapPagingSearchHTML2("memberList") }
																		</td>
																	</tr>
																</tfoot>																	
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
				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.html -->


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
          var url ="memberList${pageMaker.makeQuery(1)}";
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

