<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:choose>
	<c:when test="${empty replyList }">
		<p
			style="padding-top: 5px; padding-left: 35px; font-size: 12px; display: inline-block">
			<span style="color: #a7a7a7"></span>첫 댓글을 적어보세요!
		</p>
	</c:when>
	<c:otherwise>
	 <c:forEach items="${replyList }" var="row">
	 		
	 	 <c:choose>
	 	 	<c:when test="${empty row.userId}" >
				<p class="comment-board" style="float: left;">
					${row.username}&nbsp;<span data-toggle="modal" data-target="#boardModal2"
						bcid="76748" class="deleteComment comment-tip" type="board"  onclick="deleteComment('${row.rno}')">삭제</span><span
						class="board-ip"> <c:out value="${fn:substring(row.ip,0,8)}"  escapeXml="false" />***
						 </span>
				</p>
				<pre class="comment-board" style="color: #444; padding-right: 35px;">${row.content}</pre>	 	 			 	 	
	 	 	</c:when>
			<c:when test="${(row.userId eq sessionScope.USER.userId) or isAdmin}">
				<p class="comment-board logined" style="float:left;">${row.username }&nbsp;
	<span uid="3959" bcid="76801" class="deleteLoginedComment comment-tip" type="board"  onclick="replyDelete('${row.rno}')">삭제</span>
				<span class="board-ip moment"><fmt:formatDate value="${row.createdDate}"  pattern="yyyy-MM-dd hh:mm:ss"/></span></p>
					<pre class="comment-board" style="color: #444; padding-right:35px;">${row.content}</pre>
			</c:when>
			<c:otherwise>
			<p class="comment-board logined" style="float:left;">${row.username}&nbsp;
			<span class="board-ip moment"><fmt:formatDate value="${row.createdDate}"  pattern="yyyy-MM-dd hh:mm:ss"/></span></p>
			<pre class="comment-board" style="color: #444; padding-right:35px;">${row.content}</pre>
			</c:otherwise>
	 	 </c:choose>	

	</c:forEach>	
	</c:otherwise>
</c:choose>
<input type="hidden"  id="replyListSize" value="${replyList.size()}">

