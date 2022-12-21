<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp" %>
<style type="text/css">
#form1 {padding-left: 20px;padding-right: 20px;margin-top: 40px;margin-bottom: 40px;}

</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	
	<section id="warp">
		<div class="container board-container" >
		
            	<ul class="board-left-tab"  id="pageTitle" >
            		<li>질문과 답변</li>       
            	</ul>
            	
			<ul class="board-right-tab" style="float: none; text-align: right;display:block;  height: 50px;">
				<li><a class="button right-board" href="/board/qna/list">목록 보기</a></li>
			</ul>            	
            	
			<div class="panel panel-warning" style="border: 1px solid #dadada;">
				<div class="panel-title box-subject" style="border-bottom: 1px solid #dadada;">질문과 답변 글쓰기</div>
				<div class="container boardWriteForm" style="width: 100%;">


					<form name="form1" id="form1" action="/board/qna/write" enctype="multipart/form-data" method="post">


						<p>
							<input class="form-control tooltipstered winput" min="1" maxlength="50" required aria-required="true" name="title" placeholder="제목을 입력해주세요 (최대 50자)" />
						</p>
						<p class="error">
							<form:errors path="title" />
						</p>


						<c:choose>
							<c:when test="${empty sessionScope.USER }">

								<p>
									<input class="form-control tooltipstered winput" min="1" maxlength="10" required aria-required="true" name="username" placeholder="작성자를 입력해주세요 (최대10자)" />
								</p>
								<p class="error">
									<form:errors path="username" />
								</p>

								<p>
									<input type="password" class="form-control tooltipstered winput" min="4" maxlength="4" required aria-required="true" name="boardPassword" placeholder="비밀번호를 입력해주세요 (4자)" />
								</p>
								<p class="error">
									<form:errors path="boardPassword" />
								</p>

							</c:when>
							<c:otherwise>
								<p>
									<input type="hidden" name="uid" value="${sessionScope.USER.uid }" >
								</p>
								<p>
									<input class="form-control tooltipstered winput" readonly="readonly" name="username" value="${sessionScope.USER.username }" /> <input type="hidden" name="userId"
										value="${sessionScope.USER.userId }" />
								</p>
							</c:otherwise>
						</c:choose>

						<input type="hidden" name="imgCnt" id="imgCnt" />



						<textarea id="summernote" name="content" required ></textarea>
					
						
						<c:if test="${not empty USER}">
							<input class="button form-control tooltipstered wsubmit" type="submit" value="글쓰기" style="color: #fff">	
						</c:if>	
						   
						
						<p class="error">
							<form:errors path="content" />
						</p>

					</form>
				</div>
			</div>
		</div>


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
										onImageUpload : function(files, editor,welEditable) {sendFile(files[0], editor,welEditable);
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
											var image = $('<img>').attr('src','' + data);
											$('#summernote').summernote("insertNode", image[0]);
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
		</script>
	</section>


	
	   <%@ include file="../include/nav-bottom.jsp" %>
	   <%@ include file="../include/footer.jsp" %>	
	   <script src="/resources/web/js/summernote-ko-KR.js"></script>

</body>
</html>