<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



            	<ul class="board-list">
        <c:forEach  items="${likeList }" var="row">
		         <li style="background-color: #f6f6f6; font-size: 14px;">
		        <a href="/board/free/read/${row.bno}?page=${pageMaker.page}" style="padding: 10px 18px;line-height: 33px;">
		        <span class="thumb" style="color: #ffd305; font-weight:600">
				<img class="board-star-img" src="/resources/web/images/star.png">&nbsp;${row.likeCnt}</span>
				
					<span class="thumb" style="color: #666666;"> ${row.num} </span> 
					<c:if test="${row.imgCnt>0 }">
					 <c:choose>
					 	<c:when test="${empty row.fileName }">
					 		<span class="board-img" style="height:35px;">
					           <img src="/resources/web/images/imgnotnull.png" class="thumbnail-img">
					        </span>					 	
					 	</c:when>
					 	<c:otherwise>
					 		<span class="board-img" style="height:35px;">
					           <img src="/displayFile?fileName=${row.fileName}" class="thumbnail-img">
					        </span>
					 	</c:otherwise>
					 </c:choose>					
			       </c:if>
				
				<span class="count left-count">[${row.replyCnt }]</span>
				<span class="board-title ellipsis">${row.title}</span>
			
			
					<c:if	test="${row.replyCnt>0 }">
								<span class="count right-count">[${row.replyCnt }]</span>
					</c:if> 
					
					<span class="board-right-tip"> 
					<span class="board-list-right">
					<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" />
					</span> 
				
					<c:choose>
						<c:when test="${empty row.userId}">
							<span class="board-list-right ellipsis">${row.username}</span>
						</c:when>
						<c:otherwise>
							<span class="board-list-right ellipsis logined">${row.username}</span>
						</c:otherwise>
					</c:choose> 
					
					<span class="board-list-right board-view"><i class="fa fa-eye"  title="조회수" ></i> ${row.viewCnt}</span>
					</span>
					
					            		</a>
					        </li>        
        </c:forEach>

			
			
			<c:forEach items="${list }" var="row">            	
				<li style="font-size: 14px;" class="${row.bno eq bno ? 'active':''}">
					<a href="/board/free/read/${row.bno}?page=${pageMaker.page}" style="padding: 10px 18px;line-height: 33px;">
					<span class="thumb" style="color: #666666">
					<img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}</span>
					
					<span class="thumb" style="color: #666666;"> ${row.num} </span> 
					<c:if test="${row.imgCnt>0 }">
					 <c:choose>
					 	<c:when test="${empty row.fileName }">
					 		<span class="board-img" style="height:35px;">
					           <img src="/resources/web/images/imgnotnull.png" class="thumbnail-img">
					        </span>					 	
					 	</c:when>
					 	<c:otherwise>
					 		<span class="board-img" style="height:35px;">
					           <img src="/displayFile?fileName=${row.fileName}" class="thumbnail-img">
					        </span>
					 	</c:otherwise>
					 </c:choose>					
			       </c:if>
										
					<span class="board-title ellipsis">${row.title}</span>
					
					<c:if	test="${row.replyCnt>0 }">
								<span class="count right-count">[${row.replyCnt }]</span>
					</c:if> 
					
					<span class="board-right-tip"> 
					<span class="board-list-right">
					<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" />
					</span> 
				
					<c:choose>
						<c:when test="${empty row.userId}">
							<span class="board-list-right ellipsis">${row.username}</span>
						</c:when>
						<c:otherwise>
							<span class="board-list-right ellipsis logined">${row.username}</span>
						</c:otherwise>
					</c:choose> 
					
					<span class="board-list-right board-view"><i class="fa fa-eye"  title="조회수" ></i> ${row.viewCnt}</span>
					</span>
          			</a>
         		</li>			            	
			</c:forEach>            	
		
		<c:if test="${empty list }">
							<p style="text-align: center; margin: 50px 0 10px 0;">
									<img class="noresult" src="/resources/web/images/noresult.jpg">
								</p>
								<p style="text-align: center; margin: 50px 0 10px 0;">이런! 검색 결과가 없네요.</p>
								<p style="text-align: center; margin: 10px 0 30px 0;">다른 단어로 검색해보시길 바랍니다.</p> 
		
			</c:if>			            	
			            		
	            	</ul>
                 ${pagination}
                 
           <div>      
			<form method="get" action="/board/free/list">
                <ul class="board-search">                	
            		<li>
	            		<select name="searchType" id="board-search-select">
	       					 <option value="t" <c:out value="${pageMaker.searchType eq 't' ? 'selected' : '' }" /> >제목</option>
	            			<option value="c" <c:out value="${pageMaker.searchType eq 'c' ? 'selected' : '' }" /> >내용</option>
	            			<option value="w" <c:out value="${pageMaker.searchType eq 'w' ? 'selected' : '' }" /> >작성자</option>
	            			<option value="tcw" <c:out value="${pageMaker.searchType eq 'tcw' ? 'selected' : '' }" />>제목+내용+작성자</option>
	            		</select>
	            	</li> 
            		<li><input type="text" name="keyword" value="${pageMaker.keyword }" placeholder="검색어 입력" ></li>
            		<li><input type="submit" value="검색" class="button border-search-submit"></li>            		            		
            	</ul>
            </form>
          </div>
            	
            
           <div id="boardFooterAd"></div>
           
          
               


