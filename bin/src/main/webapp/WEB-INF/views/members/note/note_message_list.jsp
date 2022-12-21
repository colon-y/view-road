<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach items="${messageList}" var="row">

	<c:if test="${param.sendId eq row.sendId }">
		<div class="incoming_msg mt-5 mb-5">
			<div class="incoming_msg_img">
			
			<span class="userColor2 ${row.userColor}">
				${fn:substring(row.sendName,0,1)}                                            	
             </span><small>[${row.sendName}]</small>
                                            	
			</div>
			<div class="received_msg">
				<div class="received_withd_msg">
					<span class="time_date mb-2"> <fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" />
					 | ${row.customSendDate()} |  
					 <c:if test="${row.remove!=1}">
					 	<span  onclick="deleteNote('${row.noteId}')"  style="cursor: pointer;">삭제</span>
					 </c:if>
					</span>
					<p style="background: ${row.remove==1?'#eeeeee':''}">${row.remove==1?"삭제 되었습니다.":row.content}</p>


					<span class="time_date"> <c:choose>
							<c:when test="${row.readCnt==0}">
                  		읽지않음
                  	</c:when>
							<c:otherwise>
								<fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd hh:mm:ss" /> 
                  	 |  ${row.customReadDate()}               		  
                  		</c:otherwise>
						</c:choose>
					</span>
				</div>

			</div>
		</div>
	</c:if>


	<c:if test="${USER.uid eq row.sendId }">
		<div class="outgoing_msg">
			<div class="sent_msg">
				<span class="time_date mb-2"> <fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" /> | ${row.customSendDate()}
				
				| 
				<c:if test="${row.remove!=1}">
				 <span  onclick="deleteMyNote('${row.noteId}')"  style="cursor: pointer;">삭제</span>									
				</c:if>
				</span>
				<p style="background: ${row.remove==1?'#eeeeee':''}">${row.remove==1?"삭제 되었습니다.":row.content}</p>
				<span class="time_date"> <c:choose>
						<c:when test="${row.readCnt==0}">
                  		읽지않음
                  	</c:when>
						<c:otherwise>
							<fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd hh:mm:ss" /> 
                  	 |  ${row.customReadDate()}               		  
                  		</c:otherwise>
					</c:choose>
				</span>
			</div>
		</div>
	</c:if>

</c:forEach>
