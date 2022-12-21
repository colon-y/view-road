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
		<div class="container board-container" >
			<ul class="board-left-tab" style="visibility: hidden;">
				<li><a class="clicked" href="#">&nbsp;</a></li>
			</ul>
			<ul class="board-right-tab">
				<li><a class="button right-board" href="/board/write">글쓰기</a></li>
			</ul>


			<form action="/board/update"   action="/board/write"  method="post"  >
			
<input type="hidden" value="${boardVO.bno}" name="bno">
<input type="hidden" name="imgCnt" id="imgCnt" />

				<div class="board-view-header">					
					<p class="clientIp" style="display: none">${boardVO.ip}</p>
					<p style="display: none">
						<input name="bid" value="35540">
					</p>
					<p>
						<span><strong>${boardVO.username }</strong><span class="userIp">.***</span></span>
<span class="moment"><fmt:formatDate value="${boardVO.createdDate}"  pattern="yyyy-MM-dd hh:mm:ss"/></span>
					</p>
					<h4>
<input class="board-edit-title" maxlength="50" name="title" aria-required="true" value="${boardVO.title }">
					</h4>
					<p>
						<span>
<img class="board-star-img" src="/resources/web/images/star_grey.png">${boardVO.likeCnt}</span><span>조회 ${boardVO.viewCnt}</span>
				</div>
				<div class="board-view-body">
					<textarea id="summernote" name="content">${boardVO.content}</textarea>

					<p class="addThumb">
						<a><input type="submit" value="수정하기"> </a>
					</p>

					
				</div>
			</form>



			<script>
				$('.toolbar_unit:last-child').css('display', 'none');
				$('.toolbar_unit:first-child').css('display', 'none');
				$(document).ready(
						function() {
							$('#summernote').summernote(
									{
										tabsize : 4,
										height : 300,
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

		</div>

	</section>


	<c:import url="../include/nav-bottom.jsp" />
	<c:import url="../include/footer.jsp" />
	<script src="/resources/web/js/summernote-ko-KR.js"></script>
</body>
</html>