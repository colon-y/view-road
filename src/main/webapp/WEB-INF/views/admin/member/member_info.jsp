<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
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
			<!-- partial:partials/_settings-panel.html -->


			<%@ include file="../include/right_setting.jsp"%>

			<!-- partial -->
			<!-- partial:partials/_sidebar.html -->


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
										 <a class="nav-link    ps-0" 
										id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" 
										aria-selected="true">관리자 메인화면</a></li>
										
										<li class="nav-item" onclick="location.href='${home}/admin/member/memberList'"><a class="nav-link" id="profile-tab" 
										data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">회원목록</a></li>
										
										
										<li class="nav-item" onclick="location.href='${home}/admin/member/memberWrite'">
										<a class="nav-link active " id="contact-tab" data-bs-toggle="tab"
												href="#" role="tab" aria-selected="false"> 회원등록</a>
										</li>
									</ul>

								</div>


								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">



										<div class="row">
										<div class="col-md-6 offset-md-3 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title text-center">회원정보</h4>
                  <p class="card-description">
                  
                  
                  </p>
                  <form class="forms-sample" id="frm1" method="post" action="memberDelete">
                    <div class="form-group row">
                      <label for="email" class="col-sm-3 col-form-label">이메일</label>
                      <div class="col-sm-9">                      
                        <input type="email" class="form-control" id="email" name="email"   value="${memberInfo.email}"
                        	 placeholder="이메일" 
                             readonly="readonly">
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="username" class="col-sm-3 col-form-label">회원이름</label>
                      
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" name="username" 
                        	placeholder="회원이름" value="${memberInfo.username}" readonly="readonly">
                      </div>
                      
                    </div>
     
                    <div class="form-group row">
                      <label for="gender" class="col-sm-3 col-form-label">성별</label>
                      <div class="col-sm-9">
                        	
                        	<input type="text" class="form-control"
                        		value="${memberInfo.gender eq 'male'? '남성' : '여성'}"
                        		readonly="readonly">
                        	 
                      </div>
                    </div>
     
     
     													<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">우편번호</label>
																<div class="col-sm-9">
							<input  type="text" name="zoneCode"   readonly="readonly" class="form-control" value="${memberInfo.zoneCode}">
																</div>
															</div>


															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">주소</label>
																<div class="col-sm-9">
						<input  type="text" class="form-control"  readonly="readonly" value="${memberInfo.address}"  >																	


																</div>
															</div>
															

															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">생년월일 </label>
																<div class="col-sm-9">
	<input  type="text" class="form-control"  readonly="readonly" value="${memberInfo.birth}"  >																				
																</div>
															</div>

     
     
     
                    <div class="form-group row">
                      <label for="phone"  class="col-sm-3 col-form-label">전화번호</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="전화번호"
                        value="${memberInfo.phone}" readonly="readonly" >
                        
                      </div>
                    </div>
     
                     <div class="form-group row">
                      <label for="phone"  class="col-sm-3 col-form-label">회원등급</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="전화번호"
                        value="Lv. ${memberInfo.level}" readonly="readonly"  >
                       
                      </div>
                    </div>
     
   													<div class="form-group row">
																<label for="level" class="col-sm-3 col-form-label">회원권한</label>
																<div class="col-sm-9">																	

																<div readonly="readonly"  class="form-control">
																	<c:choose>
																		<c:when test="${memberInfo.role eq 'ROLE_GUEST'}">손님</c:when>
																		<c:when test="${memberInfo.role eq 'ROLE_USER'}">일반회원</c:when>
																		<c:when test="${memberInfo.role eq 'ROLE_MANAGER'}">중간관리자</c:when>
																		<c:otherwise>
																			최고관리자
																		</c:otherwise>
																	</c:choose>					
																	</div>
																				
																</div>
															</div>
   
                    
                    
                    <div class="form-group row">
                      <label for="createdDate" class="col-sm-3 col-form-label">등록일</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="createdDate"  name="createdDate" value="${memberInfo.createdDate}"  readonly="readonly">
                      </div>
                    </div>


                   <div class="form-group row">
                     <label for="createdDate" class="col-sm-3 col-form-label">수정일</label>
                     <div class="col-sm-9">
                       <input type="text" class="form-control" id="createdDate"  name="createdDate" value="${memberInfo.modifiedDate}"  readonly="readonly">
                     </div>
                   </div>

				<div class="form-group row text-center">
					<div class="col-sm-12">
					<button type="button" class="btn btn-info me-2" 
					onclick="memberUpdate()">수정화면</button>					
                    <button type="button" class="btn btn-danger me-2" onclick="memberDelete()">삭제하기</button>
                    <button  type="button" class="btn btn-dark" onclick="location.href='/admin/member/memberList'">목록</button>
                    <input type="hidden" name="type" value="update">
                    <input type="hidden" name="uid" value="${memberInfo.uid }">
                    </div>
                </div>    
                    
                  </form>
           
           
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
function memberDelete(){
	if(confirm("정말 삭제 하시겠습니까?")){
		$("#frm1").submit();
	}
}

function memberUpdate(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/admin/member/memberWrite");
	$("#frm1").submit();
}
</script>
</body>
</html>

