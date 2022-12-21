<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <c:import url="../include/header.jsp"/>
 <c:import url="../include/errorCss.jsp"/>
</head>
<body>


<div id="clouds">
            <div class="cloud x1"></div>
            <div class="cloud x1_5"></div>
            <div class="cloud x2"></div>
            <div class="cloud x3"></div>
            <div class="cloud x4"></div>
            <div class="cloud x5"></div>
        </div>
        <div class='c'>
            <div class='_404'style="font-size: 80px; height: 150px; ;">이메일 인증</div>
            <hr>
            <div class='_1' style="margin-top: 50px; font-size: 3em">${msg}</div>
            
            <a class='btn' href='/loginForm' style="margin-top: 100px; padding: 25px">로그인 페이지</a>
        </div>


 	
</body>
</html>
