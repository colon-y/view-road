<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp" %>
<style type="text/css">
#form1 {
	padding-left: 20px;
	padding-right: 20px;
	margin-top: 40px;
	margin-bottom: 40px;
}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
</head>
<body>
	<c:import url="../include/header.jsp" />

	<section id="warp">
		<div class="container board-container" >
		        <ul class="board-left-tab"  id="pageTitle" >
            		<li>장소 후기</li>       
            	</ul>
            	
			<ul class="board-right-tab" style="float: none; text-align: right;display:block;  height: 50px;">
				<li><a class="button right-board" href="/place/reviews/list">목록 보기</a></li>
			</ul>            	
            	
			<div class="panel panel-warning" style="border: 1px solid #dadada;">
				<div class="panel-title box-subject" style="border-bottom: 1px solid #dadada;">장소 후기 글쓰기</div>
				<div class="container boardWriteForm" style="width: 100%;">

					<form name="form1" id="form1" action="/place/reviews/write" enctype="multipart/form-data" method="post">


						<p>
							<input class="form-control tooltipstered winput" 	id="title" min="1" maxlength="50" required aria-required="true" 
							name="title" placeholder="제목을 입력해주세요 (최대 50자)" />
						</p>
						<p class="error">
							<form:errors path="title" />
						</p>


					<p>
						<input class="form-control tooltipstered winput" min="1" id="place"  maxlength="20" required aria-required="true" 						
							name="place" placeholder="장소이름 입력해주세요." />
					</p>


					<p>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9">
							<input type="text" name="zoneCode" id="zoneCode" style="display: none">	
							<input id="address" type="text" name="address" class="form-control tooltipstered" 
							style="border: 1px solid #f5971a;"
							readonly="readonly"  placeholder="주소를 입력해 주세요.">		
						</div>
						
						<div class="col-xs-12 col-sm-12 col-md-3">
							<input type="button" onclick="sample5_execDaumPostcode()" 
								style="width: 100%;"
							value="주소 검색" class="btn-black">
						</div>
					</div>
					 
					 <input type="hidden" name="latitude" id="latitude">
					 <input type="hidden" name="longitude" id="longitude">
					 <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>			
					</p>
	
	
					
					<br>

						<c:choose>
							<c:when test="${empty sessionScope.USER }">

								<p>
									<input class="form-control tooltipstered winput" min="1" maxlength="10" 								
									required aria-required="true" name="username" placeholder="작성자를 입력해주세요 (최대10자)" />
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



						<textarea id="summernote" name="content"></textarea>
					
					    <div style="margin: 20px 0px">	
							<div class="image-container">
							    <img style="width: 250px;" id="preview-image" src="">
							    <input style="display: block;" type="file" id="input-image"  name="uploadfile" accept="image/*" >
							</div>					
						</div>
						 
						<input class="button form-control tooltipstered wsubmit" type="button"
						 onclick="writeBtn()" value="글쓰기" style="color: #fff">	
					
						
						
						<p class="error">
							<form:errors path="content" />
						</p>

					</form>
				</div>
			</div>
		</div>



	</section>


	   <%@ include file="../include/nav-bottom.jsp" %>
	   <%@ include file="../include/footer.jsp" %>
	<script src="/resources/web/js/summernote-ko-KR.js"></script>


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
										onImageUpload : function(files, editor,
												welEditable) {
											sendFile(files[0], editor,
													welEditable);
										}
									}
								});

						function sendFile(file, editor, welEditable) {
							data = new FormData();
							data.append("file", file);
							console.log('image upload:', file);
							$
									.ajax({
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
			
			
		</script>		
		
		
		
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

								$("#latitude").val(result.y);
								$("#longitude").val(result.x);
								
								// 해당 주소에 대한 좌표를 받아서
								var coords = new daum.maps.LatLng(result.y, result.x);
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