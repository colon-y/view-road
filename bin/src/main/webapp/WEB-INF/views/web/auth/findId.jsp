<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<link href="/resources/web/css/login.css" rel="stylesheet">
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


<div class="login-page">
	<h1><a href="/">
	<span class="span">
			<img src="/resources/web/images/logo.png" >
	</span>
	뷰로드</a></h1>	
	
  <div class="form">
  	<h5  class="login-page-form-error" >${param.exception}</h5>
  		
    <form class="login-form" name="signup" method="post"  id="loginForm" action="/login">  
    	
    	<h2 class="login-page-form-title">아이디 찾기</h2>    	    
    <p>
      <input type="text"  id="phone"  name="phone"  placeholder="휴대전화 번호를 입력해 주세요."  oninput="autoHyphen(this)" maxlength="13">	
      <button type="button" onclick="findPhoneId()">휴대전화 번호로 찾기</button>
    </p>	 
   
    <hr>
     <p>
      <input type="email"  id="email"  name="email"  placeholder="이메일을 입력해 주세요." >	
      <button type="button" onclick="findEmailID()">이메일로 찾기</button>
    </p>		
    	
      <p class="message" style="display: flex;justify-content: space-between;">
      	<a href="/findIdPassword/findPassword">비밀번호 찾기</a>       
      	<a href="/loginForm">돌아가기</a> 
      </p>

    </form>
  </div>
</div>




<script src="/resources/web/js/common.js"></script>
<script src="/resources/web/js/find-id-and-password.js"></script>



</body>
</html>