<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
<style>
 .vali-message{
  color: green;  
  font-weight: bold;
  font-size:13px;  
  position:relative; 
  top: 10px;
}
</style>
</head>
<body>
	<div class="container-scroller">


		<%@ include file="../include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">


			<%@ include file="../include/right_setting.jsp"%>

			<%@ include file="../include/left_menu.jsp"%>

			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-sm-12">
							<div class="home-tab">
								
								<div class="d-sm-flex align-items-center justify-content-between border-bottom">
									<ul class="nav nav-tabs" role="tablist">
										<li class="nav-item" onclick="location.href='${home}/admin'">
										 <a class="nav-link    ps-0" 
										id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" 
										aria-selected="true">관리자 메인화면</a></li>
										
										<li class="nav-item" onclick="location.href='${home}/admin/member/memberList'"><a class="nav-link" id="profile-tab" 
										data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">회원목록</a></li>
										
										
										<li class="nav-item" onclick="location.href='${home}/admin/member/memberWrite'">
										<a class="nav-link active " id="contact-tab" data-bs-toggle="tab"
												href="#" role="tab" aria-selected="false"> 회원등록</a>
										</li>
									
<%-- 										<li class="nav-item" onclick="location.href='${home}/admin/smtpUpdate'">
										<a class="nav-link " id="contact-tab" data-bs-toggle="tab"
												href="#" role="tab" aria-selected="false"> SMTP 관리</a>
										</li> --%>											
									</ul>

								</div>





								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">



										<div class="row">
											<div class="col-md-6 offset-md-3 grid-margin stretch-card">
												<div class="card">
													<div class="card-body">
														<h4 class="card-title text-center">${type eq 'update' ? '회원수정' : '회원등록'}</h4>
														<p class="card-description"></p>

														<form class="forms-sample" id="frm1" method="post" action="memberDelete">
														
															<div class="form-group row">
																<label for="userId" class="col-sm-3 col-form-label">아이디 <span class="text-danger">(필수)</span></label>
																<div class="col-sm-9">
																	<input type="text" class="form-control" id="userId" name="userId"
																	 value="${memberInfo.userId}" placeholder="아이디" ${type eq 'update' ? 'readonly="readonly"' : ''} 
																	 check="0"
																	 autocomplete="off"> 
																	 <span class="mt-3 vali-message" id="idCheck"></span>
																</div>
															</div>														
														
															<div class="form-group row">
																<label for="email" class="col-sm-3 col-form-label">이메일<span class="text-danger">(필수)</span></label>
																<div class="col-sm-9">
																	<input type="email" class="form-control"
																	check="0"
																	 id="email" name="email"
																	 value="${memberInfo.email}" placeholder="이메일" ${type eq 'update' ? 'readonly="readonly"' : ''} 																	 
																	 autocomplete="off"> 
																	 <span class="mt-3 vali-message" id="emailCheck" ></span>
																</div>
															</div>


															<div class="form-group row">
																<label for="password" class="col-sm-3 col-form-label">비밀번호</label>

																<div class="col-sm-9">
																	<input type="password" 
																	 autocomplete="off"
																	class="form-control" id="password" name="password" placeholder="비밀번호" value="">
																</div>
															</div>


															<div class="form-group row">
																<label for="pwck_input" class="col-sm-3 col-form-label">비밀번호 확인</label>

																<div class="col-sm-9">
																	<input type="password" class="form-control" id="pwck_input" name="pwck_input" placeholder="비밀번호 확인" value="">
																</div>
															</div>




															<div class="form-group row">
																<label for="username" class="col-sm-3 col-form-label">닉네임<span class="text-danger">(필수)</span></label>

																<div class="col-sm-9">
																	<input type="text" class="form-control" 
																	check="0"
																	id="username" name="username" placeholder="닉네임" value="${memberInfo.username}">
																	
																	<span class="usernameValidation vali-message" ></span>
																</div>															  
															</div>

	

															<div class="form-group row">
																<label for="gender" class="col-sm-3 col-form-label">성별</label>
																<div class="col-sm-9">
																	<input type="radio" name="gender"
																	 value="male" ${ ( empty memberInfo.gender  )  or(memberInfo.gender eq 'male') ? 'checked' : ''} /> 남성 
																	 <input type="radio" name="gender" value="female"
																		${memberInfo.gender eq 'female'? 'checked' : ''} /> 여성

																</div>
															</div>

															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">우편번호</label>
																<div class="col-sm-9">
							<input  id="zoneCode" autocomplete="off" type="text" name="zoneCode" class="form-control tooltipstered" min="1"  
									required aria-required="true" placeholder="우편번호"  value="${memberInfo.zoneCode}"  readonly="readonly">
																</div>
															</div>


															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">주소</label>
																<div class="col-sm-9">
<input check="1" id="address" type="text" name="address" class="form-control tooltipstered" min="1"  
autocomplete="off" readonly="readonly" value="${memberInfo.address}"
required aria-required="true" placeholder="주소" style="width: 80%;display: inline-block;">																	

<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn-black" style="background: #8bc34a; border: none;
 padding: 5px;border-radius: 3px;color: #fff;" ><br>
<div id="map" style="width:300px;height:300px;margin-top:10px;display:none; border: none;    padding: 5px 10px;"></div>
																</div>
															</div>
															

															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">생년월일 </label>
																<div class="col-sm-9">
																	<input type="date" name="birth" id="birth"  class="form-control"
																			value="${memberInfo.birth}"  > 																														
																</div>
															</div>




															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">전화번호<span class="text-danger">(필수)</span></label>
																<div class="col-sm-9">
																	<input type="text" class="form-control"
																	check="0"
																	 name="phone" id="phone" placeholder="전화번호" 
																	   oninput="autoHyphen(this)"  maxlength="13"
																	   value="${memberInfo.phone}">
																	   
																	 <span class="phoneValidation vali-message" ></span>
																</div>
															</div>


															<div class="form-group row">
																<label for="level" class="col-sm-3 col-form-label">회원등급</label>
																<div class="col-sm-9">																	
																	<select name="level" id="level" class="form-control">																	
																		<c:forEach begin="1" end="10" step="1" var="num">
																			<option value="${num}" ${memberInfo.level eq num ? 'selected' :'' } >Lv. ${num}</option>
																		</c:forEach>
																	</select>
																	
																</div>
															</div>

															<div class="form-group row">
																<label for="level" class="col-sm-3 col-form-label">회원권한</label>
																<div class="col-sm-9">																	
																	<select name="role" id="role" class="form-control">																																			
				<option value="ROLE_GUEST" ${memberInfo.role eq "ROLE_GUEST" ? 'selected' :'' } >손님</option>
				<option value="ROLE_USER" ${memberInfo.role eq "ROLE_USER" ? 'selected' :'' } >일반회원</option>
				<option value="ROLE_MANAGER" ${memberInfo.role eq "ROLE_MANAGER" ? 'selected' :'' } >중간관리자</option>
				<option value="ROLE_ADMIN" ${memberInfo.role eq "ROLE_ADMIN" ? 'selected' :'' } >최고관리자</option>																		
																	</select>

																	
																</div>
															</div>


															<div class="form-group row text-center">
																<div class="col-sm-12">
														
													<button type="button" class="btn btn-info me-2 join_button">${type eq 'update' ? '수정하기' : '등록하기'}</button>

																	<button type="button" class="btn btn-dark" onclick="location.href='${home}/admin/member/memberList'">목록으로</button>
																	
																	<input type="hidden" id="id-check-result" value="false">
																	<input type="hidden" id="email-check-result" value="false">
																	<input type="hidden" name="type" id="type" value="${type}"> 
																	<input type="hidden" name="uid" value="${empty memberInfo.uid  ?  '0' :memberInfo.uid}">
																	<input type="hidden" id="oriUsername" value="${memberInfo.username}">
																	<input type="hidden" id="oriPhone" value="${memberInfo.phone}">
																</div>
															</div>

														</form>


													</div>
												</div>
											</div>




										</div>






									</div>
								</div>


							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->

				<%@ include file="../include/footer.jsp"%>


				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->


	<%@ include file="../include/footer_script.jsp"%>

	<script src="${home}/resources/admin/js/admin_join.js" ></script>

<script>

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
            	var zoneCode=data.zonecode;
            	
            	
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

