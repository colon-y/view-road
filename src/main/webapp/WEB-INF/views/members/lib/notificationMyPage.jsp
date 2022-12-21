<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<h6 class="dropdown-header">메시지 알림</h6>
<c:forEach items="${notificationMessage}" var="row">
<a class="dropdown-item d-flex align-items-center" href="/members/note/read/${row.noteId}">
	<div class="mr-3">
		<div class="icon-circle bg-primary" style="width: auto; height: auto;">
			<span class="userColor ${row.userColor}" style="width: 63px;height: 65px;"> ${fn:substring(row.sendName,0,1)}  </span> 
		</div>
	</div>
	<div>
		<div class="small text-gray-500" style="position: relative;">
		<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd"/> | ${row.customSendDate()}  
		<c:if test="${row.totCnt>0 }">
			 <small class="badge badge-danger badge-counter" style="position: absolute;right: -50px;top:0px;">${row.totCnt}+</small>
		  </c:if>
		</div>
		<span class="font-weight-bold" style="position: relative;">
		
		<c:choose>		
			<c:when test="${fn:length(row.title) > 32}">
					<c:out value="${fn:substring(row.title,0,31)}" />....
			</c:when>
			<c:otherwise>
					<c:out value="${row.title}" />
			</c:otherwise>
	   </c:choose>
	 
		</span>
	</div>
</a>

</c:forEach>

<a class="dropdown-item text-center small text-gray-500" href="/members/note/groupMessgeList">모든 알림 보기</a>

