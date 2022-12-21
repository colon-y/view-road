<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="boardComment" class="panel-footer board board-view-comment" style="height: 70px;">
	<div class="btn-right-div">
		<button class="button btn-right" onclick="replyShow(this)" id="replyOpen" >답변 쓰기</button>		
	</div>

	<form action="/board/qna/replies/create" method="post" id="boardCommentForm" style="visibility: hidden;" >
		<p>
			<input type="text" disabled id="clicktoshow1" value="${sessionScope.USER.username}" class="form-control" 
			required aria-required="true" name="username" />		
		</p> 
		<br/><br/>
		
		<p>
			<textarea id="replyContent" name="content"  placeholder="답변을 입력해주세요"></textarea>
		</p>


		<p><input id="clicktoshow3"class="button form-control" type="button" value="답변등록 하기"></p>
		
		<p>
			<input type="hidden" name="bno">
		</p>
	</form>
</div>




