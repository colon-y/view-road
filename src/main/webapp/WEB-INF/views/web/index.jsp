<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="./include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link href="/resources/web/css/main.css" rel="stylesheet">	
<link href="/resources/web/css/main-slide.css" rel="stylesheet">	
</head>
<body>

	<%@ include file="./include/header.jsp" %>
	
	
	<section style="margin-bottom: 50px">
		<div class="container board-container" >

			<div>
				<div>
					<div class="ban">
			  			<div><a href="#"><img src="/resources/web/images/main_ban_1.png"  ></a></div>
			            <div><a href="#"><img src="/resources/web/images/main_ban_2.png"  ></a></div>
			            <div><a href="#"><img src="/resources/web/images/main_ban_3.png" ></a></div>
			            <div><a href="#"><img src="/resources/web/images/main_ban_4.png" ></a></div>
			            <div><a href="#"><img src="/resources/web/images/main_ban_5.png" ></a></div>
			            <div><a href="#"><img src="/resources/web/images/main_ban_6.png" ></a></div>
		        	</div>    	     					
				</div>
			</div>
			 			
			
			<div class="list con">
				<div class="title"><h3>일간베스트</h3></div>
				<ul class="row">				  
				  <c:if test="${empty dailyBestList}">
				  		<li class="no-data"><h3>데이터가 없습니다</h3><li>
				  </c:if>
					<c:forEach items="${dailyBestList}" var="row" varStatus="status">
						<li  class="cell ${status.index %5 ==0? 'on':''}  ${(status.count%5==0) ? 'on3':'' }" 
						onclick="location.href='/place/${row.boardType eq 'place_reviews' ? 'reviews':'introduction'}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'" >
							<div class="img-box">
								<c:choose>
									<c:when test="${empty row.fileName}">
										<img src="/resources/web/images/no_image.png"  alt="${row.title}" style="height:125px">
									</c:when>
									<c:otherwise>
										<img src="/displayFile?fileName=${row.fileName}" alt="${row.title}" style="height:125px">	
									</c:otherwise>
								</c:choose>								
							</div>
							<div class="product-name">${row.title}</div>
							
							<div class="cell-bottom">
								<div class="username"><i class="fa fa-user"></i> ${row.username }							
									<span class="likeCnt">
										<span class="thumb" style="color: #666666"> 
										 <img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}
										</span>
									</span>
								</div>										 						
								<div class="date-and-view">
									<div class="date"><i class="fa fa-calendar"></i>	
									<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" /></div>																			
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
			</div>
					
						
			<div class="list con">
				<div class="title"><h3>주간베스트</h3></div>
				<ul class="row">
					<c:if test="${empty weeklyBestList}">
				  		<li class="no-data"><h3>데이터가 없습니다</h3><li>
				    </c:if>
					<c:forEach items="${weeklyBestList}" var="row" varStatus="status">
						<li  class="cell ${status.index %5 ==0? 'on':''}  ${(status.count%5==0) ? 'on3':'' }" 
						onclick="location.href='/place/${row.boardType eq 'place_reviews' ? 'reviews':'introduction'}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'" >
							<div class="img-box">
								<c:choose>
									<c:when test="${empty row.fileName}">
										<img src="/resources/web/images/no_image.png"  alt="${row.title}" style="height:125px">
									</c:when>
									<c:otherwise>
										<img src="/displayFile?fileName=${row.fileName}" alt="${row.title}" style="height:125px">	
									</c:otherwise>
								</c:choose>								
							</div>
							<div class="product-name">${row.title}</div>
							
							<div class="cell-bottom">
								<div class="username"><i class="fa fa-user"></i> ${row.username }							
									<span class="likeCnt">
										<span class="thumb" style="color: #666666"> 
										 <img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}
										</span>
									</span>
								</div>										 						
								<div class="date-and-view">
									<div class="date"><i class="fa fa-calendar"></i>	
									<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" /></div>																			
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
		  </div>	
			
	
	
		<div class="list con">
				<div class="title"><h3>월간베스트</h3></div>
				<ul class="row">
					<c:if test="${empty monthlyBestList}">
				  		<li class="no-data"><h3>데이터가 없습니다</h3><li>
				    </c:if>				
					<c:forEach items="${monthlyBestList}" var="row" varStatus="status">
						<li  class="cell ${status.index %5 ==0? 'on':''}  ${(status.count%5==0) ? 'on3':'' }" 
						onclick="location.href='/place/${row.boardType eq 'place_reviews' ? 'reviews':'introduction'}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'" >
							<div class="img-box">
								<c:choose>
									<c:when test="${empty row.fileName}">
										<img src="/resources/web/images/no_image.png"  alt="${row.title}" style="height:125px">
									</c:when>
									<c:otherwise>
										<img src="/displayFile?fileName=${row.fileName}" alt="${row.title}" style="height:125px">	
									</c:otherwise>
								</c:choose>								
							</div>
							<div class="product-name">${row.title}</div>
							
							<div class="cell-bottom">
								<div class="username"><i class="fa fa-user"></i> ${row.username }							
									<span class="likeCnt">
										<span class="thumb" style="color: #666666"> 
										 <img class="board-star-img" src="/resources/web/images/star_grey.png">&nbsp;${row.likeCnt}
										</span>
									</span>
								</div>										 						
								<div class="date-and-view">
									<div class="date"><i class="fa fa-calendar"></i>	
									<fmt:formatDate value="${row.createdDate}" pattern="YY-MM-dd" /></div>																			
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
		  </div>			
			
			
			<div class="row" id="main-board" >
				<div class="col-xs-11 col-sm-6 col-md-6" style="border-right: 2px solid #eee;">
					<!-- 게시판2 -->
				  <div class="notice">
				      <h4><a href="/board/free/list">자유게시판</a></h4>
				      <ul>
				      	<c:forEach items="${freeList}" var="row">
				        	<li><a href="/board/free/read/${row.bno}?page=1">${row.title}</a><span><fmt:formatDate value="${row.createdDate}"  pattern="yyyy-MM-dd"/> </span></li>
				      	</c:forEach>
				      </ul> 
				      <a href="/board/free/list" class="more ir_pm" title="더보기"><span class="fas fa-plus-circle" aria-hidden="true"></span></a>
				  </div>
				<!-- //게시판2 -->
				</div>
				
			  <div class="col-xs-11 col-sm-6 col-md-6" >
					<!-- 게시판1 -->
				  <div class="notice">
				      <h4><a href="/board/qna/list">질문과 답변</a></h4>
				      <ul>
				      	<c:forEach items="${qnaList}" var="row">
				        	<li><a href="/board/qna/read/${row.bno}?page=1">${row.title}</a><span><fmt:formatDate value="${row.createdDate}"  pattern="yyyy-MM-dd"/> </span></li>
				      	</c:forEach>		
				      </ul> 
				      <a href="/board/qna/list" class="more ir_pm" title="더보기"><span class="fas fa-plus-circle" aria-hidden="true"></span></a>
				  </div>
				<!-- //게시판1 -->
				</div>
								
			</div>
			
			
					
					
		</div>

	</section>


	<%@ include file="./include/nav-bottom.jsp"%>
	<%@ include file="./include/footer.jsp"%>

	<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
//갤러리
$(".ban").slick({    
	   infinite: true,
       slidesToShow: 1,
       slidesToScroll: 1,
       autoplay:true,
       autoplaySpeed:3000,
       fade:true,
       dots:true,
       responsive: [ // 반응형 웹 구현 옵션	 
		
			{ 
				breakpoint: 479, //화면 사이즈 479px
				settings: {	
					//위에 옵션이 디폴트 , 여기에 추가하면 그걸로 변경
					slidesToShow:1 
				} 
			}
		]
});
</script>
</body>
</html>


