<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include  file="../include/head.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
<style type="text/css">
.text-xs {font-size: 1.2rem;}
.text-gray-800{font-weight: bold;}
</style>
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
		
		<%@ include file="../include/sidebar.jsp"%>


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

		     <%@ include file="../include/topbar.jsp"%>


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">회원정보 수정</h1>                      
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
                                        
														<form class="forms-sample" id="frm1" method="post" action="/members/profile/updateMember">
														
															<div class="form-group row">
																<label for="userId" class="col-sm-3 col-form-label">아이디</label>
																<div class="col-sm-9">
																	<input type="text" class="form-control" id="userId" name="userId"
																	 value="${memberInfo.userId}" placeholder="아이디" ${type eq 'update' ? 'readonly="readonly"' : ''} 
																	 readonly="readonly"
																	 autocomplete="off"
																	 > 
																	 <span class="mt-3" id="idCheck" style="color: green; 
																	 position:relative; top: 10px; display: none;">사용 가능한 아이디입니다.</span>
																</div>
															</div>														
														
															<div class="form-group row">
																<label for="email" class="col-sm-3 col-form-label">이메일</label>
																<div class="col-sm-9">
																	<input type="email" class="form-control" id="email" name="email"
																	 value="${memberInfo.email}" placeholder="이메일" ${type eq 'update' ? 'readonly="readonly"' : ''} 
																	  readonly="readonly"
																	 autocomplete="off"
																	 > 
																	 <span class="mt-3" id="emailCheck" 
																	 style="color: green; position:relative; top: 10px; display: none;">사용 가능한 이메일입니다.</span>
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
																<label for="username" class="col-sm-3 col-form-label">닉네임 <span class="text-danger">(필수)</span></label>

																<div class="col-sm-9">
																	<input type="text"
																	check="0"
																	 class="form-control" id="username" name="username" placeholder="회원이름" value="${memberInfo.username}">
																</div>

																<div class="col-sm-3 mt-2"></div>																	
																<div class="col-sm-9 mt-2">		
																	<p class="usernameValidation" ></p>
																</div>
															</div>




															<div class="form-group row">
																<label for="gender" class="col-sm-3 col-form-label">성별</label>
																<div class="col-sm-9">
																	<input type="radio" name="gender"
																	 value="male" ${memberInfo.gender eq 'male' ? 'checked' : ''} /> 남성 
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

<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn btn-primary btn-black" ><br>
<div id="map" style="width:300px;height:300px;margin-top:10px;display:none; border: none; padding: 5px 10px;"></div>
																</div>
															</div>
															

															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">생년월일 </label>
																<div class="col-sm-9">
																	<input type="date" name="birth"  class="form-control"		value="${memberInfo.birth}"  > 																														
																</div>
															</div>




															<div class="form-group row">
																<label for="phone" class="col-sm-3 col-form-label">전화번호 
																<span class="text-danger">(필수)</span></label>
																<div class="col-lg-6 col-sm-6">
																	<input type="text" class="form-control" 
																	check="0"
																	name="phone" id="phone" placeholder="전화번호" max="13" maxlength="13"
																	  oninput="autoHyphen(this)" value="${memberInfo.phone}">
																</div>	
																<div class="col-lg-3 col-sm-3">  
																<input type="button"  class="btn btn-primary" 
																 onclick="phoneCertification()" id="phoneCertification-btn" value="휴대폰 번호 인증">
																</div>
																
																
																<div class="col-sm-3 mt-2"></div>																	
																<div class="col-sm-9 mt-2">		
																	<p class="phoneValidation" ></p>
																</div>
															</div>


					

			


															<div class="form-group row text-center">
																<div class="col-sm-12">
														
													<button type="button" class="btn btn-info me-2 join_button">수정하기</button>

																	<button type="button" class="btn btn-dark" 
																	onclick="location.href='/members/profile'">이전화면</button>
																	
																	<input type="hidden" id="id-check-result" value="false">
																	<input type="hidden" id="email-check-result" value="false">
																	<input type="hidden" name="type" id="type" value="${type}"> 
																	<input type="hidden" name="uid" value="${empty memberInfo.uid  ?  '0' :memberInfo.uid}">
																	
																</div>
															</div>

														</form>

                                        
                                        
                                   
                                </div>
                            </div>
                        </div>

                  
                  
                    </div>

       
       
       
    <div id="phoneValidation" style="display: none;"></div>

                </div>
                <!-- /.container-fluid -->



            </div>
            <!-- End of Main Content -->

            
            	
 			<%@ include file="../include/footer.jsp" %>
            

        </div>
        <!-- End of Content Wrapper -->


    </div>
    <!-- End of Page Wrapper -->




 <%@ include file="../include/logout_modal.jsp" %>
 <%@ include file="../include/footer_script.jsp" %>

<script>
const autoHyphen = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}
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
    
 

    
const usernameValidation = $('.usernameValidation');  
const phoneValidation = $('.phoneValidation');
const username = $('#username');    
const oriUsername = '${memberInfo.username}';  
const phone = $('#phone');
const oriPhone = '${memberInfo.phone}';  

const checkedValueColor = "#4CAF50";
const usedValueColor = "#ff1744";
const defaultColor = "#aaa";

$(function(){
	
	$('#phone').on('keyup', function() {
		phone.removeClass("checkedValue");
		phone.removeClass("usedValue");
		phone.attr("check", "1");

		if (phone.val() == "") {
			phoneValidation.text("휴대폰 번호를 입력해 주세요.");
			phoneValidation.css("color", usedValueColor);
			return;
		}
		
		
		if(phone.val().length<13){
			phoneValidation.text("휴대폰 번호를 입력해 주세요.");
			phoneValidation.css("color", usedValueColor);
			return;
		}
		
		const patternPhone = /01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/;	  
	    if(!patternPhone.test(phone.val())){
		    phoneValidation.text("핸드폰 번호를 확인 해주세요.");
			phoneValidation.css("color", usedValueColor);
	        return;
	    }  
		
	    
		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				phone: phone.val()
			},
			url: "/join/phoneDbCheck",
			success: function(result) {
				//console.log(result);

				var d = parseInt($.trim(result));

				if (d == 0) {

					if (phone.val() == "") {
						phoneValidation.text("휴대폰 번호를 입력해 주세요.");
						phoneValidation.css("color", usedValueColor);
					} else {
						// 중복 없음
						phone.addClass("checkedValue");
						phone.attr("check", "0");						
						phoneValidation.text("등록 가능한 번호입니다.");
						phoneValidation.css("color", checkedValueColor);
					}

				} else if (d > 0) {
					
					if(oriPhone!=phone.val()){
						phone.addClass("usedValue");
						phoneValidation.text("이미 사용중인 번호입니다.");
						phoneValidation.css("color", usedValueColor);
					}else{
						phone.addClass("checkedValue");
						phone.attr("check", "0");						
						phoneValidation.text("등록 가능한 번호입니다.");
						phoneValidation.css("color", checkedValueColor);
					}
				}
			}
		});

	});
		

	$('#username').on('keyup', function() {
		username.removeClass("checkedValue");
		username.removeClass("usedValue");
		username.attr("check", "1");
		if (username.val() == "") {
			usernameValidation.text("닉네임을 입력해주세요.");
			usernameValidation.css("color", usedValueColor);
			return;
		}		

		$.ajax({
			type: "POST",
			dataType: "text",
			data: {
				username: username.val()
			},
			url: "/join/usernameDbCheck",
			success: function(result) {

				var d = parseInt($.trim(result));

				if (d == 0) {
					if (username.val() == "") {
						usernameValidation.text("닉네임을 입력해주세요.");
						usernameValidation.css("color", usedValueColor);
					} else {
						// 중복 없음
						username.addClass("checkedValue");
						username.attr("check", "0");						
						usernameValidation.text("등록 가능한 닉네임 입니다.");
						usernameValidation.css("color", checkedValueColor);
					}

				} else if (d > 0) {
					if(oriUsername!=username.val()){
						// 중복 있음
						username.addClass("usedValue");
						usernameValidation.text("이미 사용중인 닉네임 입니다.");
						usernameValidation.css("color", usedValueColor);	
					}else{
						username.addClass("checkedValue");
						username.attr("check", "0");						
						usernameValidation.text("등록 가능한 닉네임 입니다.");
						usernameValidation.css("color", checkedValueColor);
					}

				}
			}
		});

		
	});
	
	
	
	
	$(".join_button").on("click", function(){
		const username = $("#username");
		const phone = $("#phone");
		const address=$("#address");
		const password=$("#password");
		const pwck_input=$("#pwck_input");
		
		if(password.val()){//비밀번호 값이 존재할 경우			
			if(password.val()!=pwck_input.val()){
				alert("비밀번호화 비밀번호 확인이 일치하지 않습니다.");
				return;
			}			
		}
		
		
		if(parseInt(username.attr("check"))!=0){
			alert("닉네임을 확인해 주세요.");
			username.focus();
			return;
		}
		
		if(!address.val()){
			alert("주소를 확인해 주세요.");
			address.focus();
			return;
		}

		
		
		if(parseInt(phone.attr("check"))!=0){
			alert("전화번호를 확인해 주세요.");
			phone.focus();
			return;
		}
		
		if(oriPhone!=phone.val()){	
			if(!phone.attr("readonly")){
				alert("휴대폰 번호를 인증해 주세요.");
				return;
			}
		}
					
		$("#frm1").submit();		
		
	});
	
});




	
/*전화번호 인증*/
function phoneCertification() {
	const phone = $("#phone");
	if (!phone.val()) {
		alert("전화번호를 입력해 주세요.");
		phone.focus();
		return;
	}
	
	if(parseInt(phone.attr("check"))!=0){
		alert("전화번호를 확인해 주세요.");
		phone.focus();
		return;
	}
	
	window.open("/phoneCertification", "auth_popup", "width=450,height=640,scrollbar=yes");
}

</script>
</body>
</html>
