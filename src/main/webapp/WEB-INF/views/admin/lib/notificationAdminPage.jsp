<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


     <c:forEach items="${notificationMessage}" var="row">
       <a class="dropdown-item preview-item" href="/members/note/read/${row.noteId}">
         <div class="preview-thumbnail">
         <div class="icon-circle " style="width: auto; height: auto;">
			<span class="userColor ${row.userColor}" style="width: 63px;height: 65px;"> ${fn:substring(row.sendName,0,1)}  </span> 
		   </div>
         </div>
         <div class="preview-item-content flex-grow py-2">
           <p class="preview-subject ellipsis font-weight-medium text-dark" >
		        <c:choose>		
					<c:when test="${fn:length(row.title) > 32}">
							<c:out value="${fn:substring(row.title,0,31)}" />....
					</c:when>
					<c:otherwise>
							<c:out value="${row.title}" />
					</c:otherwise>
			   </c:choose>
           
           </p>
           <p class="fw-light small-text mb-0" style="position: relative;"> 
       		<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; ${row.customSendDate()}  
			 <c:if test="${row.totCnt>0 }">
				 <small class="badge badge-danger badge-counter" style="position: absolute;background: #f95f53;color: #fff;">${row.totCnt}+</small>
			 </c:if>
           </p>
         </div>
       </a> 
       
    </c:forEach>   
                  
    




