<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<c:set var="URL" value="${pageContext.request.requestURL}" />
<c:set var="URI" value="${pageContext.request.requestURI}" />
				
	<input type="hidden" id="role" value="${USER.role}" >
	<input type="hidden" id="NOTICE_COUNT_SETINTERVAL" value="5000" >
				
	<header class="navbar-fixed-top">

	<div style="background: #fff">
	<div class="topTitle">
		<div>
		<span class="span">
			<img src="/resources/web/images/logo.png" >
		</span>
			<a href="/"><span class="first">뷰</span><span>로</span><span>드</span></a>
		</div>
	

	<ul id="loginUl">
	<c:choose>
		<c:when test="${empty sessionScope.USER }">
		<li class="m-login" style="width: auto;  display: inline-block; float: right; margin-top: -2px" id="navli">		  
		  <a href="/join/register" style="width: 100%; text-align: right; margin-left: 0px;"class="nav-title">회원가입</a>						
		</li>
		<li class="m-login" style="width: auto;  display: inline-block; float: right; margin-top: -2px" id="navli">		  
		  <a href="/loginForm" style="width: 100%; text-align: right; margin-left: 0px;"class="nav-title">로그인 </a>						
		</li>
			
		</c:when>
		<c:otherwise>	
			
			<li class="m-login"><a href="#" class="nav-title nav-title-username" >${USER.username} 님</a>	
			
			
			 <ul class="navbar-nav ml-auto" id="noticeCountBtn" style="width: 50px;right: 0px">
			 		    <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span id="noticeCount">                                	
                                </span>								                                
                            </a>
							    	
 						<ul class="dropdown-menu"  id="notificationMessage"  aria-labelledby="dropdownMenu1">																	   
						</ul>
                            
                            
                       </li>
			 </ul>
			
			
			<c:choose>
				<c:when test="${USER.role eq 'ROLE_ADMIN'}">
					<li class="m-login" ><a href="/members" class="nav-title" >마이페이지</a></li>
					<li class="m-login" ><a href="/admin" class="nav-title" >관리자 페이지</a></li>
				</c:when>
				<c:when test="${USER.role eq 'ROLE_MANAGER'}">
					<li class="m-login" ><a href="/admin" class="nav-title" >중간관리자</a></li>
				</c:when>
				<c:when test="${USER.role eq 'ROLE_USER'}">
					<li class="m-login" ><a href="/members" class="nav-title" >마이페이지</a></li>
				</c:when>								
			</c:choose>	
		
		
		<li class="m-login">				  
		  <a href="/logout"  class="nav-title">로그아웃</a>
		</li>
		</c:otherwise>
	</c:choose>
	</ul>
	</div>
</div>
			
		
<div class="visible-md visible-lg" style="border-top: 0px;" >



<nav class="container" id="nav" role="navigation" style=" ">
	<ul style="display: block;">
		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'index.jsp')? 'active':''}"  href="/"  >
		  <span>홈</span></a>
		</li>
		
		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'introduction')? 'active':''}"  href="/place/introduction/list"  >
		  <span>장소 소개</span></a>
		</li>
			
		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'reviews')? 'active':''}"  href="/place/reviews/list"  >장소 후기</a>
		</li>

		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'gallery')? 'active':''} "  href="/place/gallery" >장소 갤러리</a>
		</li>			

		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'map')? 'active':''} "  href="/place/map" >장소 맵</a>
		</li>					
	
		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'free')? 'active':''}"  href="/board/free/list" >자유게시판</a>
		</li> 
	
		<li class="navli">
		  <a class="nav-title ${fn:contains(URL, 'qna')? 'active':''} "  href="/board/qna/list" >질문과 답변</a>
		</li>		
		
	

	
	</ul>
</nav>
	
	
	</div>
	
	
		<div class="visible-xs visible-sm"
			style="width: 100%; border-bottom: 1px solid #dadada; border-top: 1px solid #607d8b; background-color: white; position: absolute; z-index: 30000;">
			<nav class="container" id="nav" role="navigation"
				style="max-width: 1200px; width: 100%; height: 50px; text-align: center; box-shadow: none;">
				<div style="width: 40px">
					<a class="icon-menu"><img width="23px" height="19px"
						style="display: inline; position: absolute; top: 15px; left: 15px;"
						src="/resources/web/images/iconmenu.jpg"></a>
					<div id="menu" class="menu"
						style="overflow-y: auto; -webkit-overflow-scrolling: touch; overflow-x: hidden; display: block; height: 100%; z-index: 300; opacity: 1 !important;">
						<ul>
<!-- 				<li class="mobilenav" style="background-color: #fff; color: #333 !important">
						<a style="color: #333 !important" href="/login">
							<img src="/resources/web/images/four-leaf-clover.png">로그인<span>&gt;</span>
						</a>
				</li> -->
		   <li>
			<img src="/resources/web/images/logo.png" class="responsive-img img-fluid" style="max-width: 80px">
	       </li>
		<c:choose>
			<c:when test="${empty sessionScope.USER }">
			<li class="m-login" >
				<a href="/join/register" class="mobile-ml-10" >회원가입
				</a>
			</li>	
			<li class="m-login" ><a href="/loginForm" class="mobile-ml-10" >로그인</a></li>
		</c:when>
		<c:otherwise>				
			<li class="m-login"><a href="#" class="mobile-ml-10" >${USER.username} 님</a>	
						
			 <ul class="navbar-nav ml-auto" id="noticeCountBtn" style="width: 50px;right: 0px">
			 		    <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span id="noticeCount">                                	
                                </span>								                                
                            </a>
							    	
 						<ul class="dropdown-menu"  id="notificationMessage"  aria-labelledby="dropdownMenu1">																	   
						</ul>
                                                      
                       </li>
			 </ul>
			
			
			<c:choose>
				<c:when test="${USER.role eq 'ROLE_ADMIN'}">
					<li class="m-login" ><a href="/members" class="mobile-ml-10" >마이페이지</a></li>
					<li class="m-login" ><a href="/admin" class="mobile-ml-10" >관리자 페이지</a></li>
				</c:when>
				<c:when test="${USER.role eq 'ROLE_MANAGER'}">
					<li class="m-login" ><a href="/admin" class="mobile-ml-10" >중간관리자</a>
				</c:when>
				<c:when test="${USER.role eq 'ROLE_USER'}">
					<li class="m-login" ><a href="/members" class="mobile-ml-10" >마이페이지</a>
				</c:when>								
			</c:choose>	
		
		
		<li class="m-login">				  
		  <a href="/logout"  class="mobile-ml-10">로그아웃</a>
		</li>
		</c:otherwise>
	</c:choose>
	
	
				<li class="mobilenav">
				  <a class=" ${fn:contains(URL, 'index.jsp')? 'active':''}"  href="/"  >
				  	홈
				  </a>
				</li>
				
				<li class="mobilenav">
				  <a class="${fn:contains(URL, 'introduction')? 'active':''}"  href="/place/introduction/list"  >
				 	장소 소개
				 </a>
				</li>
					
				<li class="mobilenav">
				  <a class=" ${fn:contains(URL, 'reviews')? 'active':''}"  href="/place/reviews/list"  >장소 후기</a>
				</li>
		
				<li class="mobilenav">
				  <a class=" ${fn:contains(URL, 'gallery')? 'active':''} "  href="/place/gallery" >장소 갤러리</a>
				</li>			
		
				<li class="mobilenav">
				  <a class="${fn:contains(URL, 'map')? 'active':''} "  href="/place/map" >장소 맵</a>
				</li>					
			
				<li class="mobilenav">
				  <a class=" ${fn:contains(URL, 'free')? 'active':''}"  href="/board/free/list" >자유게시판</a>
				</li> 
			
				<li class="mobilenav">
				  <a class=" ${fn:contains(URL, 'qna')? 'active':''} "  href="/board/qna/list" >질문과 답변</a>
				</li>		
		
	
	
	
						</ul>

					</div>
				</div>
<div id="dark" style="width: 100%; height: 5000px; background-color: black; opacity: 0.5; position: absolute; top: 0px; display: none; z-index: 200;"></div>
				
				
			</nav>
		</div>
	
	
	</header>
	