<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
</head>
<body>
	<%@ include file="../include/header.jsp"%>


	<section id="warp">
		<div class="container board-container" >
		
			<div class="row">
			 	<div class="col-xs-12 col-sm-12 col-md-12">						
				<div class="bn-box con">
					<h1 class="warp-title">질문과 답변</h1>
					<div class="img-box">
						<img src="/resources/web/images/ban_4.jpg" alt="질문과 답변" class="img-responsive img-rounded">
					</div>
				</div>	
				</div>
			</div> 
		


			<div class="row" style="margin-top: 20px">					
				<form method="get" action="/board/qna/list" >
				   <div class="col-xs-12 col-sm-12 col-md-6">
					<ul class="board-search board-search-top">
						<li><select name="searchType" >
								<option value="t" <c:out value="${pageMaker.searchType eq 't' ? 'selected' : '' }" />>제목</option>
								<option value="c" <c:out value="${pageMaker.searchType eq 'c' ? 'selected' : '' }" />>내용</option>
								<option value="w" <c:out value="${pageMaker.searchType eq 'w' ? 'selected' : '' }" />>작성자</option>
								<option value="tcw" <c:out value="${pageMaker.searchType eq 'tcw' ? 'selected' : '' }" />>제목+내용+작성자</option>
						</select></li>
						<li>
							<input type="search" name="keyword" value="${pageMaker.keyword }" placeholder="검색어 입력" >
						</li>
						<li><input type="submit" value="검색" class="button border-search-submit"></li>
					</ul>
			  </div>				
			 	 <div class="col-xs-12 col-sm-12 col-md-6">	
					<ul class="board-right-tab" >							
						<c:if test="${not empty USER }">
							<li><a class="button right-board" href="/board/qna/write">글쓰기</a></li>
						</c:if>
					</ul>
					</div>
				</form>							
		  </div>



			
			<ul class="board-list"  >
				<c:forEach items="${list}" var="row">
					<li style="font-size: 14px;">
						<a href="/board/qna/read/${row.bno}?page=${pageMaker.page}" style="padding: 10px 18px; line-height: 33px;">
					
						<c:if test="${row.likeCnt>0 }">
							<span class="thumb" style="color: #ffd305; font-weight: 600"> 
								<img class="board-star-img" src="/resources/web/images/star.png">&nbsp;${row.likeCnt}
							</span>
						</c:if>
						  
						<span class="thumb" style="color: #666666;"> ${row.num} </span> 
						<span class="thumb" style="color: #666666; display: none;"> 
						<img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}</span> 
						
						<c:if test="${row.imgCnt>0 }">
							<span class="board-img" style="height: 35px;"> 
								<img src="/resources/web/images/imgnotnull.png" style="height: 35px; margin-top: 4px;">
							</span>
						</c:if> 
						
						<span class="board-title ellipsis">${row.title}</span> 
						<span class="board-list-right">
						<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" /></span> 
						<span class="board-right-tip"> 
						<c:choose>
							<c:when test="${empty row.userId}">
								<span class="board-list-right ellipsis">${row.username}</span>
							</c:when>
							<c:otherwise>
							<span class="board-list-right ellipsis logined">${row.username}</span>
								</c:otherwise>
						</c:choose> 						
							<span class="board-list-right board-view">
								<i class="fa fa-eye"  title="조회수" ></i>
								${row.viewCnt}
							</span>							
						</span>
						</a>
					</li>
					
					<c:if test="${row.replyCnt >0}">
						<li class="reply-list">
							<a href="/board/qna/read/${row.bno}?page=${pageMaker.page}"> 
							<span class="board-title ellipsis" style="padding-left: 50px;">
							  <img src="/resources/web/images/arrow-right.png" style="width: 18px">
							  <strong style="font-weight:bold;"> RE</strong> : ${row.title} | <strong style="font-weight:bold;">답변</strong>
							 </span> 
							 <span class="count right-count">[${row.replyCnt }]</span>
							</a>
						</li>
					</c:if>
				</c:forEach>

				<c:if test="${empty list }">
					<p style="text-align: center; margin: 50px 0 50px 0;">등록된 데이터가 없습니다.</p>
				</c:if>
			</ul>
			
			${pagination }
			
			<form method="get" action="/board/qna/list">
				<ul class="board-search">
					<li>
						<select name="searchType" id="board-search-select">
								<option value="t" <c:out value="${pageMaker.searchType eq 't' ? 'selected' : '' }" />>제목</option>
								<option value="c" <c:out value="${pageMaker.searchType eq 'c' ? 'selected' : '' }" />>내용</option>
								<option value="w" <c:out value="${pageMaker.searchType eq 'w' ? 'selected' : '' }" />>작성자</option>
								<option value="tcw" <c:out value="${pageMaker.searchType eq 'tcw' ? 'selected' : '' }" />>제목+내용+작성자</option>
						</select>
					</li>
					<li>
					<input type="search" name="keyword" value="${pageMaker.keyword }" placeholder="검색어 입력" ></li>
					<li><input type="submit" value="검색" class="button border-search-submit"></li>
				</ul>
			</form>
			
			<div id="boardFooterAd"></div>
			
			
		</div>
	</section>

	<%@ include file="../include/nav-bottom.jsp"%>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>