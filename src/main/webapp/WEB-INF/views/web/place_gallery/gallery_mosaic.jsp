<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/css/lightgallery.css'>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/css/lg-zoom.css'>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/justifiedGallery@3.8.1/dist/css/justifiedGallery.css'>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/css/lg-thumbnail.css'>
<c:import url="../include/head.jsp" />
<link href="/resources/web/css/style-type-2.css" rel="stylesheet">
<style type="text/css">
.gallery-item {
  width: 200px;
  padding: 5px;
  cursor: pointer;
}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp"%>
	<section id="warp">
		<div class="container board-container" >

		
		<div class="row">
		 	<div class="col-xs-12 col-sm-12 col-md-12">						
			<div class="bn-box con">
				<h1 class="warp-title">장소 갤러리</h1>
				<input type="hidden" id="totalCount" value="${totalCount}">
				<input type="hidden" id="tempEndPage" value="${pageMaker.tempEndPage}">
				<input type="hidden" id="page" value="${pageMaker.page}">
			</div>	
			</div>
		</div> 
			
			<div class="row" style="float: right" >					
				<form method="get" action="/board/gallery" >
				   <div class="col-xs-12 col-sm-12 col-md-12">
					<ul class="board-search board-search-top">
						<li><select name="searchType" id="searchType">								
								<option value="t" <c:out value="${pageMaker.searchType eq 't' ? 'selected' : '' }" />>제목</option>
								<option value="w" <c:out value="${pageMaker.searchType eq 'w' ? 'selected' : '' }" />>작성자</option>
								<option value="tw" <c:out value="${pageMaker.searchType eq 'tw' ? 'selected' : '' }" />>제목+작성자</option>
						</select></li>
						<li>
							<input type="search" name="keyword" id="keyword" value="${pageMaker.keyword }" placeholder="검색어 입력" >
						</li>
						<li><input type="submit" value="검색" class="button border-search-submit"></li>
					</ul>
			  </div>				
			 	 <%-- <div class="col-xs-12 col-sm-12 col-md-6">	
					<ul class="board-right-tab" >							
						<c:if test="${not empty USER }">
							<li><a class="button right-board" href="/place/reviews/write">글쓰기</a></li>
						</c:if>
					</ul>
					</div> --%>
				</form>							
		  </div>
		  

	

		<div class="row">
			 <div class="col-xs-12 col-sm-12 col-md-12">						 
			 	
<div>
  <div class="row ">
    <div class="col col-md-12">
      <div class="gallery-container" id="animated-thumbnails-gallery">
      <c:forEach items="${list}" var="row" varStatus="status">
        
        <a data-lg-size="1600-1067" class="gallery-item"        
                data-sub-html="<h4>${row.place} <br> 
                <a href='/place/${row.boardType eq "place_reviews" ? "reviews":"introduction"}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}' style='font-weight:400' >${row.title}</a></h4>
                <p> 작성자 - <a href='/place/${row.boardType eq "place_reviews" ? "reviews":"introduction"}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'>
       </a>${row.username }</p>"
        
         data-src="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}">
          <img alt="${row.place}" class="img-responsive"
           src="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}" />
        </a>          
      </c:forEach>
      </div>
          
      <c:if test="${list.size() <=2}">
         <c:forEach items="${list}" var="row" varStatus="status">
         	<div style="width: auto; max-height:250px">
         	 <a href="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}" target="_blank" rel="noopener noreferrer">
      		 <img alt="${row.place}"  style="max-height:250px" class="img-responsive" src="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}" />
      		 </a>
      		</div>
      		</c:forEach>
      </c:if>
  
  
  	  <div class="list con">
				<ul class="row" id="resultRow"></ul>								
				<div class="row more-list">		
					<button class="mbtn" id="more" onclick="galleryList(2)" >더보기</button>
				</div>
	 </div>
	
    </div>
  </div>
</div>
			 	
			 	
			 	
			 	</div>			 	
		</div>
		  
	

			
		<div class="row" style="display: none;">	
			<div class="col-xs-12 col-sm-12 col-md-12">		
					<form method="get" action="/board/gallery">
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
		
		
			<div id="boardFooterAd"></div>

		</div>

	</section>


	<%@ include file="../include/nav-bottom.jsp"%>
	<%@ include file="../include/footer.jsp"%>

<script src='https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js'></script>
<script src='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/lightgallery.umd.js'></script>
<script src='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/plugins/zoom/lg-zoom.umd.js'></script>
<script src='https://cdn.jsdelivr.net/npm/justifiedGallery@3.8.1/dist/js/jquery.justifiedGallery.js'></script>
<script src='https://cdn.jsdelivr.net/npm/lightgallery@2.0.0-beta.3/plugins/thumbnail/lg-thumbnail.umd.js'></script>
<script src='/resources/web/js/board/gallery_list.js'></script>
    
    
<script>
jQuery("#animated-thumbnails-gallery")
.justifiedGallery({
  captions: false,
  lastRow: "hide",
  rowHeight: 180,
  margins: 5
}).on("jg.complete", function () {
  window.lightGallery(
    document.getElementById("animated-thumbnails-gallery"),
    {
      autoplayFirstVideo: false,
      pager: false,
      galleryId: "nature",
      plugins: [lgZoom, lgThumbnail],
      mobileSettings: {
        controls: false,
        showCloseIcon: false,
        download: false,
        rotate: false
      }
    }
  );
});

</script>    
</body>
</html>