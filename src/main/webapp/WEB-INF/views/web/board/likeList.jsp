<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${ likeCount >0 }">
		 <img class="board-star-img" src="/resources/web/images/star.png">
		 <div style="color: #999; display: inline;">추천 취소</div> 
	 	<input type="hidden" id="likeCount" value="${likeCount}">

	</c:when>
	<c:otherwise>
		<img class="board-star-img" src="/resources/web/images/star_grey.png"> 
		<span style="color: #999;">추천</span>     
		<input type="hidden" id="likeCount" value="${likeCount}">
	</c:otherwise>
</c:choose>

       

   
