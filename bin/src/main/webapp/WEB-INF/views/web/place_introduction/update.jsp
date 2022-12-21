<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
</head>
<body>
	<%@ include file="../include/header.jsp"%>

	<section id="warp">
		<div class="container board-container" >
			
			<div class="row">
			 	<div class="col-xs-12 col-sm-12 col-md-12">						
				<div class="bn-box con">
					<h1 class="warp-title">장소 소개</h1>
									
				</div>	
				</div>
			</div> 
			
			<ul class="board-right-tab" style="float: none; text-align: right; display: block; height: 30px;">
				<li>
					<a class="button right-board" href="/place/introduction/list">목록 보기</a>
				</li>
			</ul>


			<form action="/place/introduction/update" method="post" enctype="multipart/form-data" id="form1" >
				<input type="hidden" name="latitude" id="latitude" value="${boardVO.latitude}">
				<input type="hidden" name="longitude" id="longitude" value="${boardVO.longitude}">
				<input type="hidden" value="${boardVO.bno}" name="bno"> 
				<input type="hidden" name="imgCnt" id="imgCnt" />

				<div class="board-view-header">
					<p>제목</p>
					<h4>
						<input class="board-edit-title" maxlength="50" name="title" id="title" aria-required="true" value="${boardVO.title }">
					</h4>
					<p>
				</div>
				
				
			<div class="board-view-body">								
					<p>
						<input class="form-control tooltipstered winput" min="1" id="place"  maxlength="20" required aria-required="true" 						
							name="place" placeholder="장소이름 입력해주세요."  value="${boardVO.place }" />
					</p>
			
					<p>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9">
							<input type="text" name="zoneCode" id="zoneCode" style="display: none">	
							<input id="address" type="text" name="address" class="form-control tooltipstered" 
							style="border: 1px solid #f5971a;" value="${boardVO.address}"
							readonly="readonly"  placeholder="주소를 입력해 주세요.">		
						</div>
						
						<div class="col-xs-12 col-sm-12 col-md-3">
							<input type="button" onclick="sample5_execDaumPostcode()" 
								style="width: 100%;"
							value="주소 검색" class="btn-black">
						</div>
					</div>
											
					 <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>			
					</p>
	
	
					
					<br>
				
				
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
	            		
					
						<input class="button form-control tooltipstered wsubmit" type="button"   onclick="writeBtn()" value="수정하기" >	
				</div>
			</form>



<form action="boardEditDirect" method="post" id="formDelete">
<input type="hidden" value="${boardVO.bno}" name="bno"> 
</form>

			<script>
			
			
			function writeBtn(){
				const title =$("#title").val();		
				const place =$("#place").val();		
				const address =$("#address").val();
				if(!title){
					alert("제목을 입력해 주세요.");
					$("#title").focus();
					return;	
				}
				
				if(!place){
					alert("장소이름을 입력해 주세요.");
					$("#place").focus();
					return;	
				}
				if(!address){
					alert("주소를 입력해 주세요.");
					$("#address").focus();
					return;	
				}
				$("#form1").submit();
				
			}
			
			
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
			url : "/place/introduction/deleteImgFile",
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
	
	
<script>	
			
			/** 다음 주소 처리 */
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
				mapOption = {
					center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
					level: 5 // 지도의 확대 레벨
				};

			//지도를 미리 생성
			var map = new daum.maps.Map(mapContainer, mapOption);
			//주소-좌표 변환 객체를 생성
			var geocoder = new daum.maps.services.Geocoder();
			//마커를 미리 생성
			var marker = new daum.maps.Marker({
				position: new daum.maps.LatLng(37.537187, 127.005476),
				map: map
			});


			function sample5_execDaumPostcode() {
				new daum.Postcode({
					oncomplete: function(data) {

						var zoneCode = data.zonecode;

						var addr = data.address; // 최종 주소 변수

						// 주소 정보를 해당 필드에 넣는다.
						document.getElementById("address").value = addr;

						document.getElementById("zoneCode").value = zoneCode;

						// 주소로 상세 정보를 검색
						geocoder.addressSearch(data.address, function(results, status) {
							// 정상적으로 검색이 완료됐으면
							if (status === daum.maps.services.Status.OK) {

								var result = results[0]; //첫번째 결과의 값을 활용

								// 해당 주소에 대한 좌표를 받아서
								var coords = new daum.maps.LatLng(result.y, result.x);
								
								$("#latitude").val(result.y);
								$("#longitude").val(result.x);
								
								// 지도를 보여준다.
								mapContainer.style.display = "block";
								map.relayout();
								// 지도 중심을 변경한다.
								map.setCenter(coords);
								// 마커를 결과값으로 받은 위치로 옮긴다.
								marker.setPosition(coords)
							}
						});



					}
				}).open();
			}
			
		</script>
</body>
</html>