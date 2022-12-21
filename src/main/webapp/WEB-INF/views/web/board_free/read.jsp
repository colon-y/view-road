<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp" %>
<style type="text/css">
.board-list-right{	width: 160px;}
</style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

 <section id="warp">
   		<input type="hidden" id="USER_userId" value="${sessionScope.USER.userId}">
 		<input type="hidden" id="USER_uid" value="${sessionScope.USER.uid}">
 		<input type="hidden" id="USER_username" value="${sessionScope.USER.username}">
 		<input type="hidden" id="bno" value="${boardVO.bno}">
 		<input type="hidden" id="board_uid" value="${boardVO.uid}">
 		<input type="hidden" id="board_username" value="${boardVO.username}">
 		<input type="hidden" id="board_userId" value="${boardVO.userId}">
 		<input type="hidden" id="isAdmin" value="${isAdmin}">
 		<input type="hidden" id="page" value="${param.page}">
 		<input type="hidden" id="board_url" value="/place/reviews">
 		<input type="hidden" id="board_type" value="place_reviews">
 		       
        <div class="container read-container" >
     
           	<div class="row">
			 	<div class="col-xs-12 col-sm-12 col-md-12">						
				<div class="bn-box con">
					<h1 class="warp-title">자유게시판					
					<input type="hidden" name="latitude" id="latitude" value="${boardVO.latitude}">
					<input type="hidden" name="longitude" id="longitude" value="${boardVO.longitude}">
					</h1>				
				</div>	
				</div>
			</div> 
    
            	<ul class="board-right-tab" style="margin-top: 0px;">             	
            		<li>
            		
            		<a class="button right-board" href="/board/free/list">목록 보기</a></li>
     			    <c:if test="${not empty USER and (USER.role eq 'ROLE_ADMIN') or (USER.role eq 'ROLE_MANAGER') }">
							<li style="margin-right: 10px">
								<a class="button right-board" href="/board/free/write">글쓰기</a>
							</li>	
					</c:if>           		            	            
            	</ul>
            	
      
             	<div class="board-view-header" style="margin-top: 65px">
		            <div class="sub_wrap" style="margin-top: 0px">
		            	 <p>
		            		<span>
		            		<i class="fa fa-user"></i> 
		            		<strong class="logined">${boardVO.username}</strong>
		            		</span>
		            		            		
		            		<span><i class="fa fa-calendar"></i>
		            			<fmt:formatDate value="${boardVO.createdDate}" pattern="yyyy-MM-dd"/>            		 
		            		</span>
		            		
		            		<span>
		            			<i class="fas fa-hourglass-end"></i>
		            			${boardVO.customDate()}
		            		</span>
		            	 </p>
		            		
		            		<c:if test="${not empty boardVO.fileName}">
			            		<p class="mtb-20">
			            			<img src="/displayFile?fileName=${boardVO.fileName}" class="img-responsive img-rounded mxw-300" >
			            		</p>
		            		</c:if>
		            		
							<h4>${boardVO.title}</h4>
		      
		      			<form method="post" action="/board/free/boardEditDirect"  id="directForm"> 
				      		    <input type="hidden" value="${boardVO.bno}" name="bno">
				      			<input type="hidden"  name="boardPassword" id="formPw">		            	
				            	<p>
								<span id="topLikeCount" >
									<img class="board-star-img" src="/resources/web/images/star_grey.png">0
								</span>
								<span><i class="fa fa-eye"></i> 조회 ${boardVO.viewCnt}</span>
								<span><i class="fa fa-comments"></i> 
									<a href="#boardComment" onclick="return false;" id="boardComment2">댓글 0</a>
								</span>
				
								<c:if test="${not empty USER and not empty  boardVO.userId }">				
									<span>
										<a href="#" onclick="return false;"  id="boardScrap" data-bno="${boardVO.scrapCnt ==1 ? -1:boardVO.bno}">
										${boardVO.scrapCnt ==1 ? '<i class="fas fa-check"></i>' :'<i class="fas fa-fw fa-thumbtack"></i>'}스크랩</a>				
									</span> 					
									
		  							<c:if test="${USER.userId ne  boardVO.userId }">								
										<span data-toggle="modal" data-target="#noteModal" class="noteModal">
											<a href="#" onclick="return false;">
											<i class="far fa-paper-plane" ></i> 쪽지보내기</a>				
										</span> 
									</c:if>
															 	      					
								    <c:if test="${ (USER.userId  eq  boardVO.userId )	or  isAdmin}">													
											 <span class="editBoardLoginedUser" style="cursor: pointer;"><a>수정</a></span>
									    	 <span class="deleteBoardLoginedUser" style="cursor: pointer;"><a>삭제</a></span>					         
									 </c:if> 
						      	</c:if>
						      	
					     		 </p>
			     		   </form>	            	
						</div>
				</div>

      
            
            	<div class="board-view-body">
            		<div class="board-view-desc">
            		${boardVO.content }        		            		
            		</div>
            		
            		
            	 	<p class="addThumb col-xs-12">
			            <a id="boardThumb"  href="#" >	
			            		
		            		<c:choose>
		            			<c:when test="${boardVO.myLikeCnt>0 }">
		            				 <img class="board-star-img" src="/resources/web/images/star.png">
									 <span style="color: #999; display: inline;">추천 취소</span> 
								 	<input type="hidden" id="likeCount" value="${boardVO.likeCnt}">
		            			</c:when>
		            			<c:otherwise>
		            				<img class="board-star-img" src="/resources/web/images/star_grey.png"> 
									<span style="color: #999;">추천</span>     
									<input type="hidden" id="likeCount" value="${boardVO.likeCnt}">
		            			</c:otherwise>
		            		</c:choose>         			            	
			            </a>      			          	     
            		</p>
            		
            		
            		<div  style="text-align: center;width:100%; height:auto; display:inline-block; margin-bottom:15px"></div>
				</div>
				
	
	   ﻿<%@  include file="replyForm.jsp" %>
	    
    
                                 <!-- 댓글 리스트 뷰 panel-footer-->
      <div class="panel-footer board board-view-comment"id="replyList"></div>	
          
     		
			
			
		<ul class="board-left-tab">
			<li>&nbsp;</li>		
		</ul>
			
		 <div class="board-container pt-0 mt-0"></div>


			</div>
        </section>
	
	<%@ include file="../include/noteModal.jsp" %>
	


<script>

$(document).ready(function(){
	//쪽지 보내기
	$(".noteModal").on("click", function(){
			$("#note-title").val("");
			$("#note-textarea").val("");
			$("#note-uid").val($("#board_uid").val());
			$("#note-username").val($("#board_username").val());				
	});
	
	$("#note-send-btn").on("click", function(){
		const receiveId =$("#note-uid").val();
		const title =$("#note-title").val();
		const content=$("#note-textarea").val();
		if(!content){			
			tWarning("내용을 입력해 주세요.");
			$("#note-textarea").focus();
			return;
		}
		$.ajax({
			url:"/note/send",
			type:"post",
			data:{receiveId,title,content},
			success:function(res){
				console.log("res");
				if(res==="success"){
					tSuccess("전송 처리 되었습니다.");
					$("#noteModal").modal("hide");
				}
			},
			error:function(error){
				tError("에러  : ",error);
				$("#noteModal").modal("hide");	
			}			
		})					
	});
	
	
	
	//추천 like 불러오기
	 getLike();
	 //댓글 불러오기
	 replyList(1);
	
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
						url: "/board/free/removeDirect",
						data: {
							bno: '${boardVO.bno}'
						},
						success: function (result) {		
							if ($.trim(result) == "SUCCESS") {
								alert("삭제되었습니다.");
								location.href="/board/free/list";
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
								url: "/board/free/remove",
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
	$('#boardThumb').click(function (e) {
		e.preventDefault();
		
		const uid='${sessionScope.USER.uid}';
		if(!uid){
			alert("로그인후 이용 가능합니다.")
			return; 
		}
		
		$.ajax({
			type: "POST",
			dataType: "text",
			data:{
				bno:'${boardVO.bno}',
				uid:uid
			},
	        url: "/like/update",
	        success:function(result){	        	
	        	let cnt =Number($("#likeCount").val());
	        	console.log(" result : ", result,  cnt);
	        	let html ='';
	        	if(Number(result)===1){
	        		cnt=cnt+1;
	        		html +='<img class="board-star-img" src="/resources/web/images/star.png">';
	        		html +='<div style="color: #999; display: inline;">추천 취소</div> ';
	        		html +='<input type="hidden" id="likeCount" value="'+cnt+'">';
	        		
	        	}else if(Number(result)===0){
	        		cnt=cnt-1;	        		
	        		html +='<img class="board-star-img" src="/resources/web/images/star_grey.png">'; 
	        		html +='<span style="color: #999;">추천</span>';     
	        		html +='<input type="hidden" id="likeCount" value="'+cnt+'">';		        		
	        	}
	        	$('#boardThumb').html(html);
	        	$("#topLikeCount").html("<img class='board-star-img' src='/resources/web/images/star_grey.png'>"+cnt+"</span>");
	        	
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

let page='${param.page}';
getInList(page);
function getInList(page){
	if(page==undefined || page==""){
		page=1;
	}
	$.ajax({
		type: "GET",
		dataType: "html",
		data:{
			bno:'${boardVO.bno}',
			page:page
		},
        url: "/board/free/inlist",
        success: function (result) {
        	$(".board-container").html(result);
    		$(".board-paging li a").on("click", function(e){
				e.preventDefault();
				getInList(e.target.dataset.page);
			})
        },
        error:function(result){
		  console.log( "error :  " ,result);
		  
        }        
	});	
}

function getLike(){
	$.ajax({
		type: "GET",
		data:{bno:'${boardVO.bno}'},
        url: "/like/list",
        success: function (res) {			
        	$("#topLikeCount").html("<img class='board-star-img' src='/resources/web/images/star_grey.png'><i class='topLikeCount-i'>"+res+"</i></span>");
        },
        error:function(result){
        	console.log(result);
        }        
	});	
}




//댓글 불러오기
function replyList(page){
	if(page=="" || page==undefined){
		page=1;
	}
	var bno='${boardVO.bno}';
	var sessionCheck='${sessionScope.USER.username }';
	$.get("/board/replies/all/"+bno +"?page="+page+"&boardType=board_free", function(data){
		//console.log(data);
		
		$("#replyList").html(data);
		
		if(sessionCheck!=""){
			$("#clicktoshow1").val(sessionCheck);
		}
		dateFormat();
		
		var replyCount=$("#replyListSize").val();
		$("#boardComment2").text(replyCount);
		
		if(replyCount>0){
			$("#replyList").show();
			
			$(".reply-pagination li a").on("click", function(e){
				e.preventDefault();
				replyList(e.target.dataset.page);
			})
		}else{
			$("#replyList").hide();
		}
		
	});
		
}

//댓글 폼 열기
function updateReplyForm(rno){
	$("#comment-board-"+rno).hide();
	$("#reply-textarea-div-"+rno).show();	
}
function updateCancle(rno){
	replyList(1);
}
//댓글 업데이트 하기
function updateReply(rno){
	const content=$("#reply-textarea-"+rno).val();
	if(!content){
		alert("내용을 입력해 주세요.");
		$("#reply-textarea-"+rno).foucs();
		return;
	}
	$.ajax({
		url:"/board/replies/update",
		type:"put",
		data:{
			rno,
			content
		},
		success:function(res){
			if ($.trim(res)=="success") {					
				replyList(1);
			}
		},
		error:function(error){
			console.log("에러 : ", error);
		}
	})
}


//로그인 한 유저 댓글 삭제
function replyDelete(rno){

	if (confirm("정말 삭제하시겠습니까?") == true) {
		$.ajax({
			type: "DELETE",
			url: "/board/replies/delete/" + rno,
			success: function (result) {
				if ($.trim(result) == "SUCCESS") {					
					replyList(1);
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
    
    
    
	   <%@ include file="../include/nav-bottom.jsp" %>
	   <%@ include file="../include/footer.jsp" %>
	  
	
	


</body>
</html>



