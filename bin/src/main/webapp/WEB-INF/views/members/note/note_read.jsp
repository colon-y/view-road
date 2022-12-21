<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include  file="../include/head.jsp" %>
<link href="/resources/members/css/chat.css" rel="stylesheet">
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
		<%@ include file="../include/sidebar.jsp"%>


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
			<input type="hidden" id="group" value="${param.group}">	
				
            <!-- Main Content -->
            <div id="content">

		     <%@ include file="../include/topbar.jsp"%>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3  text-gray-800">쪽지 함</h1>                      
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
                 			<h2>받은쪽지함</h2>
<!--                  			<div>
                 				<button class="btn btn-info mr-3" >개별 쪽지함</button>
                 				<button class="btn btn-default">유저별 쪽지함</button>
                 			</div> -->
                 		</div>                   


            		   			<input type="hidden" id="sendId" value="${noteInfo.sendId}">
            		   			<input type="hidden" id="sendName" value="${noteInfo.sendName}">
            		   			
           						<div class="table-responsive">
                                <table class="table" id="dataTable" >           				
           							<tbody>
           								<tr>
									      <td class="table-info text-center" >
									       <button onclick="noteShow(this)" class="btn btn-primary show-on-btn">전체쪽지 내용보기</button>
									       
									      
									      </td>
									      <td>
									      
									    <span id="noteShowText"><span class="text-primary">'전체쪽지 내용보기'</span> 버튼 클릭시 전체 읽음 처리로 변경됩니다.</span>  
<div class="container" id="message-container">
<h3 class="text-center">메시지</h3>
<div class="messaging">
      <div class="inbox_msg">
              
        <div class="mesgs">
          <div class="msg_history">
			
			 	
             <!-- 메시지 내용 -->
          </div>
          
          
          <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" class="write_msg" placeholder="내용을 입력해 주세요." />
              <button class="msg_send_btn" type="button" id="msg_send_btn"  >
              <i class="far fa-paper-plane" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
      </div>
 
    </div>
    
    </div>									      
									      
									      
									     
									      </td>									     
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
									      <td>${noteInfo.content}</td>									   
									    </tr>
									    <tr>
									    <td class="table-info text-center">보낸날짜</td>
									      <td>${noteInfo.sendDate}</td>					
									    </tr>
									     <tr>
										     <td class="text-center" colspan="2">
										     	<button class="btn btn-dark"	onclick="history.back()">이전화면</button>
										     	<button class="btn btn-primary noteModal"  data-target="#noteModal" data-toggle="modal">답장하기</button>
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
                <!-- /.container-fluid -->



            </div>
            <!-- End of Main Content -->

            
            	
 			<%@ include file="../include/footer.jsp" %>
            

        </div>
        <!-- End of Content Wrapper -->


    </div>
    <!-- End of Page Wrapper -->



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
						<div class="text-left">
							<span>받는 회원</span>
							<input type="text" class="form-control" id="note-username" readonly="readonly" >
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
							<button type="button" class="btn btn-primary"  id="note-send-btn">보내기</button>	
						</div>									    					
			     </div>
			   </div>
		</div>
	</div>
	
	

 <%@ include file="../include/logout_modal.jsp" %>
 <%@ include file="../include/footer_script.jsp" %>
 <script src="/resources/members/js/note_read.js"></script>

</body>
</html>
