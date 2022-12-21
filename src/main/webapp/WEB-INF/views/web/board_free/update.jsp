<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
</head>
<body>
	<%@ include file="../include/header.jsp"%>

	<section id="warp">
		<div class="container board-container" >
			<ul class="board-left-tab" id="pageTitle">
				<li>자유게시판</li>
			</ul>
			<ul class="board-right-tab" style="float: none; text-align: right; display: block; height: 30px;">
				<li>
					<a class="button right-board" href="/board/free/list">목록 보기</a>
				</li>
			</ul>


			<form action="/board/free/update" method="post" enctype="multipart/form-data" >

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
					
					
					<c:choose>
						<c:when test="${not empty boardVO.fileName}">
							<p style="margin-top: 10px; position: relative;">
	            				<img src="/displayFile?fileName=${boardVO.fileName}" >            				
	            				<button type="button" class="btn-delete" onclick="imgDelete('${boardVO.bno}')">첨부파일삭제</button>
	            			</p>
						</c:when>
						<c:otherwise>
		         			<div style="margin: 20px 0px">	
									<div class="image-container">
									    <img style="width: 250px;" id="preview-image" src="">
									    <input style="display: block;" type="file" id="input-image"  name="uploadfile" accept="image/*" >
									</div>					
							</div>						
						</c:otherwise>
					</c:choose>
	            		
					
						<input class="button form-control tooltipstered wsubmit" type="submit" value="수정하기" >	
				</div>
			</form>



<form action="boardEditDirect" method="post" id="formDelete">
<input type="hidden" value="${boardVO.bno}" name="bno"> 
</form>

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
				function dateFormat() {
					var moments = document.getElementsByClassName('moment');
					for (var i = 0; i < moments.length; ++i) {
						var item = moments[i];
						item.innerHTML = moment(item.textContent,
								"YYYY-MM-DD hh:mm:ss").fromNow();
					}
				}
				
function imgDelete(bno){
	if(confirm("첨부파일 삭제 하시겠습니까?")){
		
		$.ajax({
			url : "/board/free/deleteImgFile",
			data :{
				bno:bno
			},
			type : 'POST',
			success : function(data) {	
				console.log(data);
				if(data==="success"){
					$("#formDelete").submit();
				}
				
			},
			
			error : function(jqXHR, textStatus,errorThrown) {
				console.log(textStatus + " "+ errorThrown);
			}
		});
	}
}		


function readImage(input) {

    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {

        // 이미지 파일인지 검사 (생략)

        // FileReader 인스턴스 생성
        const reader = new FileReader()

        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview-image")
            previewImage.src = e.target.result
        }

        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
}

// input file에 change 이벤트 부여
const inputImage = document.getElementById("input-image")
inputImage.addEventListener("change", e => {
    readImage(e.target)
})

			</script>

		</div>

	</section>


	<%@ include file="../include/nav-bottom.jsp"%>
	<%@ include file="../include/footer.jsp"%>
	<script src="/resources/web/js/summernote-ko-KR.js"></script>
</body>
</html>