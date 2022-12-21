<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:forEach items="${notificationMessage}" var="row">
<li style="position: relative;">
	<span class="userColor ${row.userColor}"> ${fn:substring(row.sendName,0,1)}  </span> 
	<a href="/members/note/read/${row.noteId}"> 
		<c:choose>		
			<c:when test="${fn:length(row.title) > 32}">
					<c:out value="${fn:substring(row.title,0,31)}" />....
			</c:when>
			<c:otherwise>
					<c:out value="${row.title}" />
			</c:otherwise>
	   </c:choose>
	 
	
	<span class="time-span">
		<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd"/>
		| <span>${row.customSendDate()}</span>
	</span>
	</a>
	<c:if test="${row.totCnt>0 }">
	 <small class="badge badge-danger badge-counter" style="position: absolute;width: 30px;
    right: 10px;top: 35px;">${row.totCnt}+</small>
    </c:if>
</li>
</c:forEach>
<div>
<a class="text-center small text-gray-500 alert-bottom" href="/members/note/groupMessgeList">모든 알림 보기</a>
</div>