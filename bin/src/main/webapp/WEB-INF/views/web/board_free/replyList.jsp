<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<h2 style="padding-left: 30px;color: #a7a7a7; color: #607d8b; font-weight: bold;" >댓글 목록</h2>
<c:choose>
	<c:when test="${empty replyList }">
		<p style="padding-top: 5px; padding-left: 35px; font-size: 12px; display: inline-block">
			<span style="color: #a7a7a7; ">첫 댓글을 적어보세요!</span>
		</p>
	</c:when>
	<c:otherwise>
	

	<c:forEach items="${replyList}" var="row" varStatus="status">
	<c:choose>
				<c:when test="${(row.uid eq sessionScope.USER.uid) or isAdmin}">
					<div class="comment-board-reply ${status.index%2==0 ? 'even' :'odd'}">
						<div class="comment-board logined" style="float: left;">
							<span style="color: #999">${row.num}</span> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
							${row.username}&nbsp;
							<span class="deleteLoginedComment comment-tip" onclick="updateReplyForm('${row.rno}')">수정</span> 
							<span class="deleteLoginedComment comment-tip" onclick="replyDelete('${row.rno}')">삭제</span> 
							<span class="board-ip">	
							<fmt:formatDate value="${row.createdDate}" pattern="yyyy-MM-dd" />&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
							<span class="moment">					
							<fmt:formatDate value="${row.createdDate}" pattern="yyyy-MM-dd hh:mm:ss" />
							</span>
							</span>
						</div>
						
						<div id="comment-board-${row.rno}" class="comment-board"  >${row.content}</div>						
						<div  id="reply-textarea-div-${row.rno}" class="reply-textarea-div">
							<textarea id="reply-textarea-${row.rno}"  class="reply-textarea"
							class="form-control tooltipstered"  maxlength="500" required  aria-required="true"      						
	       						name="content"  placeholder="댓글을 입력해주세요 (최대 500자)"   >${row.content}</textarea>
	       				  <div class="text-center">
	       				  	<button  type="button"  class="btn-cancle" onclick="updateCancle('${row.rno}')">취소하기</button>			
	       					<button  type="button"  class="btn-update" onclick="updateReply('${row.rno}')">수정히기</button>
	       				   </div>	
       				   </div>	
					</div>	
					
				</c:when>

				<c:otherwise>
				<div class="comment-board-reply ${ status.index%2==0 ? 'even' :'odd'}">
					<div class="comment-board logined" style="float: left;">
						<span style="color: #999">${row.num}</span> &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
						${row.username}&nbsp;
						<span class="board-ip">	
						<fmt:formatDate value="${row.createdDate}" pattern="yyyy-MM-dd" />&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
						<span class="moment">					
						<fmt:formatDate value="${row.createdDate}" pattern="yyyy-MM-dd hh:mm:ss" />
						</span>
						</span>
					</div>
					<div class="comment-board" style="color: #444; padding-right: 35px;">${row.content}</div>
				</div>
					
				</c:otherwise>				
		</c:choose>
	</c:forEach>
		
	</c:otherwise>
</c:choose>

<c:if test="${replyLtotalCount>5 }">
<div id="pagination">
		${replyLpagination}
		
</div>
</c:if>
			
<input type="hidden" id="replyListSize" value="${replyList.size()}">

