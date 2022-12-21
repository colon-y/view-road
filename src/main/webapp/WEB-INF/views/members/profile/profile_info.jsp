<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include  file="../include/head.jsp" %>
<style type="text/css">
.text-xs {
 	   font-size: 1.2rem;
}
.form-control:disabled, .form-control[readonly] {
    background-color: #fff;
    opacity: 1;
    border: none;
    font-weight: bold;
    outline: none;
}
.form-control:disabled:focus, .form-control[readonly]:focus {
   outline: none !important;
   box-shadow: none;
}
.text-gray-800{font-weight: bold;}
</style>
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
                        <h1 class="h3  text-gray-800">회원정보 보기</h1>                      
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
                                    
                                    
           			<form class="forms-sample" id="frm1" method="post" action="/members/profile/memberDelete">
           			
                    <div class="form-group row">
                      <label for="email" class="col-sm-3 col-form-label">아이디:</label>
                      <div class="col-sm-9">                      
                        <input type="email" class="form-control" id="userId" name="userId"   value="${memberInfo.userId}"
                        	 placeholder="아이디" 
                             readonly="readonly">
                      </div>
                    </div>           			
           			
                    <div class="form-group row">
                      <label for="email" class="col-sm-3 col-form-label">이메일:</label>
                      <div class="col-sm-9">                      
                        <input type="email" class="form-control" id="email" name="email"   value="${memberInfo.email}"
                        	 placeholder="이메일" 
                             readonly="readonly">
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="username" class="col-sm-3 col-form-label">닉네임:</label>
                      
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="username" name="username" 
                        	placeholder="회원이름" value="${memberInfo.username}" readonly="readonly">
                      </div>
                      
                    </div>
     
                    <div class="form-group row">
                      <label for="gender" class="col-sm-3 col-form-label">성별:</label>
                      <div class="col-sm-9">
                        	
                        	<input type="text" class="form-control"
                        		value="${memberInfo.gender eq 'male'? '남성' : '여성'}"
                        		readonly="readonly">
                        	 
                      </div>
                    </div>
     
     
     													<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">우편번호:</label>
																<div class="col-sm-9">
							<input  type="text" name="zoneCode"   readonly="readonly" class="form-control" value="${memberInfo.zoneCode}">
																</div>
															</div>


															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">주소:</label>
																<div class="col-sm-9">
						<input  type="text" class="form-control"  readonly="readonly" value="${memberInfo.address}"  >																	


																</div>
															</div>
															

															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">생년월일:</label>
																<div class="col-sm-9">
	<input  type="text" class="form-control"  readonly="readonly" value="${memberInfo.birth}"  >																				
																</div>
															</div>

     
     
     
                    <div class="form-group row">
                      <label for="phone"  class="col-sm-3 col-form-label">전화번호:</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="전화번호"
                        value="${memberInfo.phone}" readonly="readonly" >
                        
                      </div>
                    </div>
     
   
   		
   
                    
                    
                    <div class="form-group row">
                      <label for="createdDate" class="col-sm-3 col-form-label">등록일:</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="createdDate"  name="createdDate" value="${memberInfo.createdDate}"  readonly="readonly">
                      </div>
                    </div>


                   <div class="form-group row">
                     <label for="createdDate" class="col-sm-3 col-form-label">수정일:</label>
                     <div class="col-sm-9">
                       <input type="text" class="form-control" id="createdDate"  name="createdDate" value="${memberInfo.modifiedDate}"  readonly="readonly">
                     </div>
                   </div>

				<div class="form-group row text-center">
					<div class="col-sm-12">
					<button type="button" class="btn btn-info me-2" 
					onclick="memberUpdate()">수정화면</button>					
                    <button type="button" class="btn btn-danger me-2" onclick="memberDelete()">탈퇴하기</button>
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
function memberDelete(){
	if(confirm("정말 탈퇴 하시겠습니까?")){
		$("#frm1").submit();
	}
}

function memberUpdate(){
	$("#frm1").attr("action", "${pageContext.request.contextPath}/members/profile/updateForm");
	$("#frm1").submit();
}

$(function(){
	const msg='${msg}';
	if(msg!=""){
		console.log("msg ",msg);
		alert(msg);
	}
})
</script>
</body>
</html>
