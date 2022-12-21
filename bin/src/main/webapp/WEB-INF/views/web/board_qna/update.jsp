<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/head.jsp" %>
	
</head>
<body>
	<%@ include file="../include/header.jsp" %>



	<section id="warp">
		<div class="container board-container" >

           	  <ul class="board-left-tab"  id="pageTitle" >
            		<li>질문과 답변</li>       
            	</ul>
           		
			
			<ul class="board-right-tab" style="float: none; text-align: right;display:block;  height: 30px;">
				<li><a class="button right-board" href="/board/qna/list">목록 보기</a></li>
			</ul>


			<form action="/board/qna/update" method="post">
				<input type="hidden" value="${boardVO.bno}" name="bno"> 
				<input type="hidden" name="imgCnt" id="imgCnt" />

				<div class="board-view-header">
					<p>제목</p>
					<h4>
						<input class="board-edit-title" maxlength="50" name="title" aria-required="true" value="${boardVO.title }">
					</h4>
					<p>
				</div>
				
				<div class="board-view-body">
					<p>내용</p>
					<textarea id="summernote" name="content">${boardVO.content}</textarea>
					
					<input class="button form-control tooltipstered wsubmit" type="submit" value="수정하기" >	
				</div>
			</form>



		</div>

	</section>


	   <%@ include file="../include/nav-bottom.jsp" %>
	   <%@ include file="../include/footer.jsp" %>
	   <script src="/resources/web/js/summernote-ko-KR.js"></script>
				<script>
				$('.toolbar_unit:last-child').css('display', 'none');
				$('.toolbar_unit:first-child').css('display', 'none');
				$(document).ready(
						function() {
							$('#summernote').summernote(
									{
										tabsize : 4,
										height : 500,
										lang : 'ko-KR',
										callbacks : {
											onImageUpload : function(files,
													editor, welEditable) {
												sendFile(files[0], editor,
														welEditable);
											}
										}
									});

							function sendFile(file, editor, welEditable) {
								data = new FormData();
								data.append("file", file);
								console.log('image upload:', file);
								$.ajax({
									url : "/summernote/upload",
									data : data,
									cache : false,
									contentType : false,
									processData : false,
									type : 'POST',
									success : function(data) {
										var image = $('<img>').attr('src',
												'' + data);
										$('#summernote').summernote(
												"insertNode", image[0]);
										$("#imgCnt").val("1");

										//console.log(data);
									},
									error : function(jqXHR, textStatus,
											errorThrown) {
										console.log(textStatus + " "
												+ errorThrown);
									}
								});
							}

						});
				
				dateFormat();
			function dateFormat(){
				var moments = document.getElementsByClassName('moment');
				for (var i = 0; i < moments.length; ++i) {
				    var item = moments[i];  
				    item.innerHTML = moment(item.textContent, "YYYY-MM-DD hh:mm:ss").fromNow();
				}
			}	
				
			</script>
</body>
</html>