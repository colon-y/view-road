<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:import url="../include/head.jsp" />
</head>
<body>
	<c:import url="../include/header.jsp" />


 <section id="warp">
        <p style="display:none" class="session_uid">${sessionScope.USER.userId }</p>
        <p style="display:none" class="session_nickname">${sessionScope.USER.username }</p>            
        <div class="container"  >
            	<ul class="board-left-tab" style="visibility: hidden;">
					<li>&nbsp;</li>            					
			    </ul>
            	<ul class="board-right-tab">
            	
            	
          			<c:choose>
						<c:when test="${not empty USER}">
							<li><a class="button right-board" href="/board/write">글쓰기</a></li>	
						</c:when>
						<c:otherwise>
							<li><button class="button form-control tooltipstered wsubmit" 
		style="color: #fff;background-color: #607d8b;opacity: .8;
					    border: 1px solid #ef352d;margin: 0px !important;padding-bottom:30px;font-weight: normal;
								">로그인후 글작성이 가능합니다
							 	</button>
							 </li>					
						</c:otherwise>
					</c:choose>
            		            	
            	
            	</ul>
            	
      
      
             	<div class="board-view-header">
            		<p style="display:none" class="author_id">${boardVO.bno}</p>
            		<p class="bid" style="display:none">${boardVO.bno}</p>
            		<p class="clientIp" style="display:none">${boardVO.ip}</p><p>
            		<span><strong class="logined">${boardVO.username}</strong>
            		</span>
            		<span class="moment1"><fmt:formatDate value="${boardVO.createdDate}"  pattern="yyyy-MM-dd hh:mm:ss"/></span></p>
					<h4>${boardVO.title}</h4>
      
      			<form method="post" action="/board/boardEditDirect"  id="directForm"> 
      			 <input type="hidden" value="${boardVO.bno}" name="bno">
      			<input type="hidden"  name="boardPassword" id="formPw">
            	<p style="display: inline;">
					<span id="topLikeCount" style="display: inline;">
					<img class="board-star-img" src="/resources/web/images/star_grey.png">0</span>
<span style="display: inline;">조회 ${boardVO.viewCnt}</span>
			<span style="display: inline;"><a href="#boardComment" onclick="return false;" id="boardComment2">댓글 0</a></span>
      
         
		      <c:choose>
		      	<c:when test="${not empty  boardVO.userId }">	      					
					<c:if test="${ (USER.userId  eq  boardVO.userId )or  isAdmin}">						
							
							 <span class="editBoardLoginedUser" style="cursor: pointer;"><a>수정</a></span>
					    	 <span class="deleteBoardLoginedUser" style="cursor: pointer;"><a>삭제</a></span>					         
					 </c:if> 
		      	</c:when>
		      	 <c:otherwise>
		      	 	<span class="editBoard" data-toggle="modal" data-target="#boardModal" style="cursor: pointer;">
		      	 	<a>수정</a>
		      	 	</span>
					<span class="deleteBoard" data-toggle="modal" data-target="#boardModal" style="cursor: pointer;">
					<a>삭제</a>
					</span>							
		      	 </c:otherwise>	     			      
		      </c:choose>
	     			   </p>
	     			    </form>	            	
				</div>


            
            
            	<div class="board-view-body">
            		<div class="board-view-desc">
            		${boardVO.content }        		            		
            		</div>
            		
            		
            		<p class="addThumb col-xs-12">
            <a id="boardThumb">
            <img class="board-star-img" src="/resources/web/images/star_grey.png"> 추천            
            </a>
            
            
            			<a href="/board/list">목록보기</a>            		
            		</p>
            		<div id="boardViewInsideAd" style="text-align: center;width:100%; height:auto; display:inline-block; margin-bottom:15px"></div>
				</div>
				
	
				
	<c:if test="${ (USER.role eq 'ROLE_MANAGER') or  (USER.role eq 'ROLE_ADMIN') }">
		﻿<%@ include file="replyForm.jsp" %>
	</c:if>
    
    
    
             
                 
                        
                    <!-- 댓글 리스트 뷰 panel-footer-->
      <div class="panel-footer board board-view-comment" style="margin-top: -30px;background-color:white; text-align:left; 
      padding: 15px 0 15px 0;" id="replyList">
  
      </div>	
      
      
      		<!-- Modal -->
			<div class="modal fade" id="boardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
			      </div>
			      
			   <div class="modal-body">
		     	<form action="javascript:void(0);">
				      	<input name="replyPassword" class="board-edit-input" maxlength="4" placeholder="비밀번호를 입력해주세요." type="password">
				      	<input class='board-edit-submit' value='수정' type='submit' id="modalSubmit">
			   	</form>
			      	<p class="board-edit-tip"></p>
			      	<p class="editType" style="display: none"></p>
			      </div>
			    </div>
			  </div>
		</div>
			
			
			
			
			
			<ul class="board-left-tab" style="margin-top: 40px;visibility: hidden;" >
<li>&nbsp;</li>
		
		</ul>
	<div class="board-container" style="padding-top:0px; max-width:1200px;">
			
		
		<c:import url="/board/inlist" />
	            	
	 </div>
			
<script>

$(document).ready(function(){
	
	//추천 like 불러오기
	 getLike();
	 //댓글 불러오기
	 replyList();

	 
	
	$('.board-edit-input').focusin(function() {
		$(this).css("border", "1px solid #607d8b");
	});

	$('.board-edit-input').focusout(function() {
		$(this).css("border", "1px solid #ececec");
	});

	
//////////////////////////////
	//로그인 후 게시판 작성한 한 유저
//////////////////////////////
	
		$('.editBoardLoginedUser').click(function(){	
			var sId ='${sessionScope.USER.userId}';
			var bId='${boardVO.userId}';
			var isAdmin='${isAdmin}';
			if(sId != bId && isAdmin=="false") {			
				alert("관리자 또는 글작성자만 게시글만 삭제 가능합니다.");	
				return;
				
			}else {		
				$("#directForm").submit();
			}
		});

		
		$('.deleteBoardLoginedUser').click(function(){
			var sId ='${sessionScope.USER.userId}';
			var bId='${boardVO.userId}';
			var isAdmin='${isAdmin}';
			if(sId != bId && isAdmin=="false") {
				alert("관리자 또는 글작성자만 게시글만 삭제 가능합니다.");	
				return;
			}else {					
				if (confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						type: "POST",
						dataType: "text",
						url: "/board/removeDirect",
						data: {
							bno: '${boardVO.bno}'
						},
						success: function (result) {		
							if ($.trim(result) == "SUCCESS") {
								alert("삭제되었습니다.");
								location.href="/board/list";
							} else 
								alert(msg);
						}
					});
				}			
			}			
		});

//////////////////////////////
			//비밀번호로 게시판 작성한  유저
//////////////////////////////

		var modal = $('#boardModal');
		var tip = $('.board-edit-tip');
		var title = $('.modal-title');
		var body = $('.modal-body');
		var editType = $('.editType');
		
		$('.editBoard').click(function() {
			editType.text("1");
			title.text("게시글 수정");
			$("#modalSubmit").val("수정");
			$(".board-edit-input").val("");
			tip.empty();
			tip.append("<p class='board-edit-tip'>* 작성 시 입력하신 비밀번호를 입력해주세요.</p>");
		});

		$('.deleteBoard').click(function() {
			editType.text("2");
			title.text("게시글 삭제");
			$("#modalSubmit").val("삭제");
			$(".board-edit-input").val("");
			tip.empty();
			tip.append("<p class='board-edit-tip'>* 작성 시 입력하신 비밀번호를 입력해주세요.</p>");
		});
		
		
		
		
		

		$('.board-edit-submit').click(function() {
			var boardPassword = $('.board-edit-input').val();
			var type = $('.editType').text();
			var section = $('#editType').text();

			if(boardPassword==""){
				alert("비밀번호를 입력해 주세요.");
				$('.board-edit-input').focus();
				return;
			}
			
			if(type=='1'){				
				$.ajax({
					url:"/board/passwordConfirm",
					type:"post",
					dataType:"text",
					data:{
						bno:'${boardVO.bno}',
						boardPassword:boardPassword			
					},
					success:function(result){	
						console.log(result);
						var re= $.trim(result);	
						if(re==0){
							alert("비밀번호가 일치하지 않습니다.");
							$('.board-edit-input').val("");
							return;
						}
						
						if(re==1){
							$("#directForm").attr("action", "/board/boardEdit");
							$("#formPw").val(boardPassword);
							$("#directForm").submit();
						}
						
					},error:function(result){
						console.log(result);
						
					}
				});									
				
			}
			
			
			if(type=='2'){
				$.ajax({
					url:"/board/passwordConfirm",
					type:"post",
					dataType:"text",
					data:{
						bno:'${boardVO.bno}',
						boardPassword:boardPassword			
					},
					success:function(result){	
						console.log(result);
						var re= $.trim(result);	
						if(re==0){
							alert("비밀번호가 일치하지 않습니다.");
							return;
						}
						
						if(re==1){
							$.ajax({
								type: "POST",
								dataType: "text",
								url: "/board/remove",
								data: {
									bno: '${boardVO.bno}',
									boardPassword:boardPassword
								},
								success: function (result) {		
									if ($.trim(result) == "SUCCESS") {
										alert("삭제되었습니다.");
										location.href="/board/list";
									} else 
										alert(msg);
								}
							});
						}
						
					},error:function(result){
						console.log(result);
						
					}
				});									
				
				
			}
			
			
		});	

		
//////////////////////////////
//////////////////////////////
		
	// 추천/추천취소 버튼 클릭 시 이벤트 
	$('#boardThumb').click(function () {
		$.ajax({
			type: "POST",
			dataType: "text",
			data:{
				bno:'${boardVO.bno}'				
			},
	        url: "/board/likeUpdate",
	        success:function(result){
	        	if($.trim(result)=="SUCCESS"){
	        		//목록 갱신	        		
	        		getLike();
	        	}
	        	
	        }, error: function (result) {
	        	console.log(result);
	        }
		});
	});
		

	
//////////////////////////////
//////////////////////////////댓글 



  //댓글 등록
  $("#clicktoshow3").on("click", function(e){
	   var sessionCheck='${sessionScope.USER.userId}';
		console.log(sessionCheck);
	   var bno ='${boardVO.bno}';
	   var content=$("#submitbtn").val();

		   
	  if(content==""){
		  alert("내용을 입력해 주세요.");
		  return;
	  }
		
	   if(sessionCheck==""){
		   var username=$("#clicktoshow1").val();
		   var replyPassword=$("#clicktoshow2").val();
		   
		   if(username==""){
			   alert("작성자를 입력해 주세요.");
			   return;
		   }
		   
		   if(replyPassword==""){
			   alert("비밀번호를 입력해 주세요.");
			   return;
		   }
	   }
	  
	  
		$.ajax({
			url:"/board/replies/create",
	        type:"post",
			data :{
				bno:  bno,
				content: content,
				username:username,
				replyPassword:replyPassword
			},
			dataType:'text',		
			success:function(result){
				if(result=="success"){
					replyList();
					alert("등록 되었습니다.");
					$("#submitbtn").val("");
					$("#clicktoshow1").val("");
					$("#clicktoshow2").val("");
					
				}else{
					console.dir(result);	
				}
			},
			error:function(result){
				console.dir(result);
			}
		});
	  
  });










	$('.board-view-desc img').css('cursor', 'pointer');
	$('.board-view-desc img').click(function() {
		var url = $(this).attr('src');

		if (url.indexOf("http") != -1) {
			window.open(url, '_blank');
		} else { 

			window.open("/"+url, '_blank');
		}
	});




	$("#modalSubmit2").on("click", function(){
		var rno=$("#modalRno").val();
		var replyPassword=$("#modalPassword").val();		
		if(replyPassword==""){
			alert("비밀번호를 입력해 주세요.");
			return;
		}
		$.ajax({
			url:"/board/replies/removePassowrd/"+rno,
			type:"post",
			dataTye:"text",
			data:{
				rno:rno,
				replyPassword:replyPassword
			},
			success:function(result){
				if($.trim(result)=="SUCCESS"){
					alert("삭제 했습니다.");
					location.reload();
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					$("#modalPassword").val("");
				}
			},
			error:function(result){
				alert("비밀번호가 일치하지 않습니다.");
				$("#modalPassword").val("");
			}			
		});
		
		
		
	});

});



function getLike(){
	$.ajax({
		type: "POST",
		dataType: "html",
		data:{
			bno:'${boardVO.bno}'
		},
        url: "/board/likeList",
        success: function (result) {
        	$('#boardThumb').html(result);
        	var count =$("#likeCount").val();
        	if(count==""){
        		count=0;
        	}
        	//console.log(count);
        	$("#topLikeCount").html("<img class='board-star-img' src='/resources/web/images/star_grey.png'>"+count+"</span>");
        },
        error:function(result){
        	//console.log(result);
        }        
	});
	
}

//댓글 불러오기

function replyList(){
	var bno='${boardVO.bno}';
	var sessionCheck='${sessionScope.USER.username }';
	$.get("/board/replies/all/"+bno, function(data){
		//console.log(data);
		$("#replyList").html(data);
		
		if(sessionCheck!=""){
			$("#clicktoshow1").val(sessionCheck);
		}
		dateFormat();
		
		var replyCount=$("#replyListSize").val();
		$("#boardComment2").html("댓글 "+replyCount);
	});
		
}


//
	//로그인 한 유저 댓글 삭제
function replyDelete(rno){

	if (confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type: "POST",
			dataType: "text",
			url: "/board/replies/" + rno,
			success: function (result) {
				if ($.trim(result) == "SUCCESS") {
					alert("삭제되었습니다.");
					replyList();
				}
			}, error: function (d) {
				alert(d.error);
			}
		});
	}
}

//비밀번호로 댓글 삭제
function deleteComment(rno){
	$("#modalRno").val(rno);
}



			
			
</script>


			</div>
        </section>



	<c:import url="../include/nav-bottom.jsp" />
	<c:import url="../include/footer.jsp" />
	<script>


dateFormat1();
function dateFormat(){
	var moments = document.getElementsByClassName('moment');
	for (var i = 0; i < moments.length; ++i) {
	    var item = moments[i];  
	    item.innerHTML = moment(item.textContent, "YYYY-MM-DD hh:mm:ss").fromNow();
	}
}	

function dateFormat1(){
	var moments = document.getElementsByClassName('moment1');
	for (var i = 0; i < moments.length; ++i) {
	    var item = moments[i];  
	    item.innerHTML = moment(item.textContent, "YYYY-MM-DD hh:mm:ss").fromNow();
	}
}
    </script>
    
    
      		<!-- Modal -->
		<div class="modal fade" id="boardModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">댓글 삭제</h4>
		      </div>
		      
		   <div class="modal-body">
	     	<form action="javascript:void(0);">
			      	<input name="replyPassword" class="board-edit-input"  id="modalRpw" maxlength="4" placeholder="비밀번호를 입력해주세요." type="password">
			      	<input type="hidden" id="modalRno" />
			      	<input class='' value='삭제' type='button' id="modalSubmit2">
		   	</form>

		      </div>
		    </div>
		  </div>
	</div>
</body>
</html>



