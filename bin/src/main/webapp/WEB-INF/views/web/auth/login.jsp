<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<link href="/resources/web/css/login.css" rel="stylesheet">
</head>
<body>

<div class="login-page">
	<h1><a href="/" >
		<span class="span">
				<img src="/resources/web/images/logo.png" >
		</span>뷰로드
		</a>
	</h1>	
	
  <div class="form">
  	<h5 style="font-size: 15px;color:#e91e63; text-align: left;">${param.exception}</h5>	
    <form class="login-form" name="signup" method="post"  id="loginForm" action="/login">  
        
	  <input type="text" check="1" id="userId"  name="userId"  placeholder="아이디" required>	
	  	      
	  <input  type="password" id="password" name="password" placeholder="비밀번호" required>  
	                        
      <button type="submit">로그인</button>
      

      <p class="message" style="display: flex;justify-content: space-between;">
       <span>
      	<a href="/findIdPassword/findId"> 아이디 찾기 </a>/ 
      	<a href="/findIdPassword/findPassword"> 비밀번호 찾기</a>
      	</span> 
      	<a href="/">돌아가기
      </a>
      </p>
      <p class="message" style="display: flex;justify-content: space-between;"> 
      <span>계정이 없습니까? <a href="/join/register">회원가입</a></span>
      </p>

    </form>
  </div>
</div>




</body>
</html>