<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            	<ul class="board-list">
        <c:forEach  items="${likeList }" var="row">
		                <li style="background-color: #f6f6f6; font-size: 14px;">
		        <a href="/board/read/${row.bno}">
		        <span class="thumb" style="color: #ffd305; font-weight:600">
				<img class="board-star-img" src="/resources/web/images/star.png">&nbsp;${row.likeCnt}</span>
				
				<c:if test="${row.imgCnt>0 }">					
				<span class="board-img">
		           <img src="/resources/web/images/imgnotnull.png" style="width:16px; height:16px; margin-top: 4px;">
		        </span>
		        </c:if>
				
				<span class="count left-count">[${row.replyCnt }]</span>
				<span class="board-title ellipsis">${row.title}</span>
					<c:if test="${row.replyCnt>0 }">
						<span class="count right-count">[${row.replyCnt }]</span>
					</c:if>	
				<span class="board-right-tip">
				
				<c:choose>
					<c:when test="${empty row.userId}">
						<span class="board-list-right ellipsis">${row.username}</span>								
					</c:when>
					<c:otherwise>
						<span class="board-list-right ellipsis logined">${row.username}</span>	
					</c:otherwise>					
				</c:choose>
				
				
		       	<span class="board-list-right"><fmt:formatDate value="${row.createdDate}"  pattern="MM-dd"/></span>
				<span class="board-list-right board-view"><i class="fa fa-eye"  title="์กฐํ์" ></i> ${row.viewCnt}</span>
					</span>
					            		</a>
					        </li>        
        </c:forEach>

			
			
			<c:forEach items="${list }" var="row">            	
				<li style="font-size: 14px;">
					<a href="/board/read/${row.bno}">
					<span class="thumb" style="color: #666666">
					<img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}</span>
					
					<c:if test="${row.imgCnt>0 }">					
					<span class="board-img">
			           <img src="/resources/web/images/imgnotnull.png" style="width:16px; height:16px; margin-top: 4px;">
			        </span>
			        </c:if>
										
					<span class="board-title ellipsis">${row.title}</span>
					<c:if test="${row.replyCnt>0 }">
						<span class="count right-count" >[${row.replyCnt }]</span>
					</c:if>	
					
					<span class="board-right-tip">
					<c:choose>
						<c:when test="${empty row.userId}">
							<span class="board-list-right ellipsis">${row.username}</span>								
						</c:when>
						<c:otherwise>
							<span class="board-list-right ellipsis logined">${row.username}</span>	
						</c:otherwise>					
					</c:choose>
          			
          			
          			<span class="board-list-right"><fmt:formatDate value="${row.createdDate}"  pattern="MM-dd"/></span>
					<span class="board-list-right board-view"><i class="fa fa-eye"  title="์กฐํ์" ></i> ${row.viewCnt}</span>
					</span>
          			</a>
         		</li>			            	
			</c:forEach>            	
		
		<c:if test="${empty list }">
							<p style="text-align: center; margin: 50px 0 10px 0;">
									<img class="noresult" src="/resources/web/images/noresult.jpg">
								</p>
								<p style="text-align: center; margin: 50px 0 10px 0;">์ด๋ฐ! ๊ฒ์ ๊ฒฐ๊ณผ๊ฐ ์๋ค์.</p>
								<p style="text-align: center; margin: 10px 0 30px 0;">๋ค๋ฅธ ๋จ์ด๋ก ๊ฒ์ํด๋ณด์๊ธธ ๋ฐ๋๋๋ค.</p> 
		
			</c:if>			            	
			            		
	            	</ul>
                 ${pagination }
			<form method="get" action="/board/list">
                <ul class="board-search">                	
            		<li>
	            		<select name="searchType" id="board-search-select">
	       					 <option value="t" <c:out value="${pageMaker.searchType eq 't' ? 'selected' : '' }" /> >์?๋ชฉ</option>
	            			<option value="c" <c:out value="${pageMaker.searchType eq 'c' ? 'selected' : '' }" /> >๋ด์ฉ</option>
	            			<option value="w" <c:out value="${pageMaker.searchType eq 'w' ? 'selected' : '' }" /> >์์ฑ์</option>
	            			<option value="tcw" <c:out value="${pageMaker.searchType eq 'tcw' ? 'selected' : '' }" />>์?๋ชฉ+๋ด์ฉ+์์ฑ์</option>
	            		</select>
	            	</li> 
            		<li><input type="text" name="keyword" value="${pageMaker.keyword }" placeholder="๊ฒ์์ด ์๋?ฅ" length="20" max-length="20"></li>
            		<li><input type="submit" value="๊ฒ์" class="button border-search-submit"></li>            		            		
            	</ul>
            </form>
            	
            	
            	
            	<div id="boardFooterAd" style="text-align: center;width:100%; height:auto; display:inline-block; 
            	margin-top: 32px; margin-bottom:32px">

            	</div>
    


