<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
</head>
<body>

<div class="loading-dim-layer">
		<div class="loading-klover-dimBg"></div>
		<div id="loading-klover-layer" class="loading-pop-layer">
			<div class="loading-pop-container">
				<div class="loading-pop-conts">						
				<div class="loading">
				      <span></span>   
				      <span></span>
				      <span></span>
				</div>						
				</div>			
			</div>
		</div>
</div> 

<div class="klover-dim-layer">
		<div class="klover-dimBg"></div>
		<div id="klover-layer" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">		
 					<p class="ctxt mb20">
						이메일 인증 번호를 입력해 주세요.<br> 
						<input id="emailAuthKey"  name="emailAuthKey" type="password" class="form-control" required aria-required="true">
					</p>
					<div class="btn-r text-center" style="text-align: center;">
						<a href="#" class="btn-auth btn-layerClose">닫기</a> 
						<a href="#" class="btn-auth" onclick="emailAuthentication(); return false;">확인</a>
					</div>
				</div>			
			</div>
		</div>
</div>


	<section id="warp">
		<div class="container" id="sectionContainer">
			<h1>
				<a href="/"> 
				<span class="register"><img src="/resources/web/images/logo.png"></span> 뷰로드
				</a>
			</h1>

			<div class="panel panel-warning">
				<div class="panel-title">
					<h3 class="signupTitle">정확한 회원정보를 입력하여 주십시오.</h3>
					<form name="signup" method="post" id="loginForm" onsubmit="return registerSubmit();" autocomplete="off">
						<table id="loginTable">
							<tbody>
								<tr>
									<td class="td-left">
										<p class="userIdValidation">아이디를 입력해주세요.</p>
									</td>
								</tr>
								<tr>
									<td>
										<input check="1" id="userId" type="text" autocomplete="off"
										 name="userId" class="form-control tooltipstered" min="4" maxlength="12" 
										 required aria-required="true" placeholder="영문 또는 숫자 4자이상 12자 이하" >
									 </td>
								</tr>

								<tr>
									<td class="td-left">
										<p class="emailValidation">이메일을 입력해주세요.</p>
									</td>
								</tr>
								<tr>
									<td>
									<input check="1" id="email" type="text"  name="email" autocomplete="off" 									
									class="form-control tooltipstered" min="1" maxlength="30" required aria-required="true" placeholder="최대 30자"> 
									
									<input type="button" onclick="emailKeySend()" id="emailKeySendBtn" value="이메일 인증" class="btn-black"> 
									<input type="hidden" name="emailState" id="emailState">
									</td>
								</tr>


								<tr>
									<td class="td-left">
										<p class="usernameValidation" style="margin-top: 20px;">닉네임을 입력해주세요.</p>
									</td>
								</tr>
								<tr>
									<td>
										<input check="0" id="username" type="text" 
										name="username" class="form-control tooltipstered" min="1" maxlength="10" 
										required aria-required="true" placeholder="최대 10자">
									</td>
								</tr>


								<!--						
							   <tr>
									<td class="td-left">
										<p class="membershipValidation">회원구분을 선택해 주세요.</p>
									</td>
								</tr>
								
 															
								<tr>
									<td style="text-align: left;">
										<input type="radio" name="membership" value="user" checked="checked"> <span style="font-size: 14px;color: #555">일반</span> 
										<input type="radio" name="membership" value="manager"> <span style="font-size: 14px;color: #555">중간관리자</span> 
									</td>
								</tr> -->



								<tr>
									<td class="td-left">
										<p class="genderValidation">성별을 선택해 주세요.</p>
									</td>
								</tr>

								<tr>
									<td class="gender">
										<input type="radio" name="gender" value="male" checked="checked"><span>남성</span> 
										<input type="radio" name="gender" value="female"> <span>여성</span>
									</td>
								</tr>



								<tr>
									<td class="td-left">
									<p class="addressValidation" >주소를 입력해 주세요.</p> 
									<input type="text" name="zoneCode" id="zoneCode" placeholder="우편번호" class="form-control tooltipstered" readonly="readonly" >																		 
									<input check="1" id="address" type="text" name="address" class="form-control tooltipstered" min="1" 
									autocomplete="off" readonly="readonly" required aria-required="true" placeholder="주소">
										
									 <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" class="btn-black"><br>
									<div id="map"></div>

									</td>
								</tr>

								<tr>
									<td class="td-left">
										<p class="birthValidation mt-20" >생년월일을 입력해 주세요.</p>
									</td>
								</tr>
								<tr>
									<td><input type="date" check="1"
									 class="form-control" autocomplete="off" name="birth" id="birth" placeholder="생년월일"></td>
								</tr>


								<tr>
									<td class="td-left">
										<p class="phoneValidation mt-20" id="phoneValidation" >휴대폰 번호를 입력해 주세요.</p>
									</td>
								</tr>
								<tr>
									<td>
										<input type="text" class="form-control" autocomplete="off" name="phone"  check="1"
										id="phone" placeholder="휴대폰 번호" 
										oninput="autoHyphen(this)" maxlength="13">										
									 	<input type="button" onclick="phoneCertification()" id="phoneCertification-btn" value="휴대폰 번호 인증" class="btn-black">
									 </td>
								</tr>



								<tr>
									<td class="td-left">
										<p check="1" class="passwordValidation">비밀번호를 입력해주세요.</p>
									</td>
								</tr>
								<tr>
									<td><input id="password" type="password" 
									size="17" autocomplete="off" maxlength="20" name="password" class="form-control tooltipstered" 
									minlength="4" required aria-required="true"
										placeholder="최소 4자"
									></td>
								</tr>
								<tr>
									<td class="td-left">
										<p check="1" class="passwordReValidation">비밀번호를 재확인해주세요.</p>
									</td>
								</tr>
								<tr>
									<td><input id="passwordCheck" type="password" 
									size="17" autocomplete="off" maxlength="20" name="password" class="form-control tooltipstered" min="1" required aria-required="true"
										placeholder="비밀번호가 일치해야합니다."
									></td>
								</tr>
								
								<tr>
									<td style="width: 100%; text-align: center; colspan: 2;">
										<input type="button" value="가입하기" id="signupBtn1" class="button form-control tooltipstered signupBtn1" onclick="registerSubmit()">
									</td>
								</tr>
								<tr>
									<td class="joinTd"><a href="/loginForm" class="button form-control tooltipstered signupBtn1"> 돌아가기</a></td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>




	</section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/resources/web/js/common.js"></script>
<script src="/resources/web/js/register.js"></script>




</body>
</html>