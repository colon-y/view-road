<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/resources/web/css/style-type-2.css" rel="stylesheet">


		 <div id="galleryView" class="row">
			 <div class="col-xs-12 col-sm-12 col-md-12">						 			 	
			<div class="list con">
				<ul class="row">
					<c:forEach items="${list}" var="row" varStatus="status">
						<li  class="cell ${status.index %4 ==0? 'on':''}  ${(status.count%4==0) ? 'on3':'' } ${row.bno eq bno ? 'active':''}"
						 onclick="location.href='/place/introduction/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'" >
							<div class="img-box">
								<c:choose>
									<c:when test="${empty row.fileName}">
										<img src="/resources/web/images/no_image.png"  alt="${row.title}">
									</c:when>
									<c:otherwise>
										<img src="/displayFile?fileName=${row.fileName}"  alt="${row.title}">	
									</c:otherwise>
								</c:choose>								
							</div>
							<div class="product-name">${row.title}</div>
							
							<div class="cell-bottom">
								<div class="username"><i class="fa fa-user"></i> ${row.username }							
									<span class="likeCnt">
										<span class="thumb" style="color: #666666"> 
										 <img class="board-star-img" src="/resources/web/images/star_black.png">&nbsp;${row.likeCnt}
										</span>
									</span>
								</div>							
								<div class="date-and-view">
									<div class="date"><i class="fa fa-calendar"></i>	
									<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" />
									</div>
									<c:if test="${row.replyCnt>0 }">
										<span class="board-comments">
										<i class="fa fa-comments" title="댓글"></i> ${row.replyCnt} </span>
									</c:if>									
									<span class="board-view">							
										<i class="fa fa-eye"  title="조회수" ></i> ${row.viewCnt}						
									</span>	
								</div>
						    </div>																
						</li>																	
				  </c:forEach>


				</ul>
				
				<c:if test="${empty list }">
						<h2 class="text-center" style="font-size: 1.5rem">검색 처리된 데이터가 없습니다.</h2>													
				</c:if>
			</div>
			 			
			 </div>
			  
		 </div>

        
         <%@ include file="./inlistView.jsp" %>
        
         ${pagination}
    
    
    
    
                 
	      <div>      
	          <div class="row">	
				<div class="col-xs-12 col-sm-12 col-md-12">		
						<form method="get" action="/place/introduction/list">
							<ul class="board-search" >
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
				</div>
			</div>
          </div>
            	
    
            
       <div id="boardFooterAd"></div>
           
          
               


