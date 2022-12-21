<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:import url="../include/head.jsp" />
<link href="/resources/web/css/style-type-2.css" rel="stylesheet">
    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:13px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:inherit;}
#menu_wrap {position:absolute;top:0px;left:0px;bottom:0;width:270px;margin:0px 0 0px 0px;padding:5px;overflow-y:auto;
height:700px;display:none;
background:rgba(255, 255, 255, 1);z-index: 1;font-size:12px;border-radius: 10px;}


.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}

#placesList {left: 0px; top:0px; }
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}


.map_wrap  .overlaybox {position:relative;width:360px;height:350px;
background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat; 
padding:15px 10px;}
 

.map_wrap  .overlaybox2 {position:relative;width:360px;height:350px;
background:url('/resources/web/images/box_movie5.png') no-repeat;
padding:15px 10px;}

 
.map_wrap  .overlaybox div, ul {overflow:hidden;margin:0;padding:0; }
.map_wrap  .overlaybox li {list-style: none;}

.map_wrap  .overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;
background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;
margin-bottom:8px;}

/* .map_wrap  .overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;
background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;
margin-bottom:8px;}
 */
/* .map_wrap  .overlaybox .first {position:relative;width:147px;height:76px; */
.map_wrap  .overlaybox .first {position:relative;width:247px;height:136px;
background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat; 
margin-bottom:8px;}


.map_wrap  .first .text {color:#fff;font-weight:bold;}
.map_wrap  .first .triangle {position:absolute;width:48px;height:48px;top:0;left:0;
background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:3px;font-size:12px;}
.map_wrap  .first .movietitle {
position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;
overflow: hidden; text-overflow: ellipsis;white-space: nowrap;
}
.map_wrap  .overlaybox ul {width:247px;}
.map_wrap .overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
.map_wrap .overlaybox li span {display:inline-block;}
.map_wrap .overlaybox li .number {font-size:16px;font-weight:bold;}
.map_wrap .overlaybox li .title {font-size:13px;}
.map_wrap .overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;
background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
.map_wrap  .overlaybox li .up {background-position:0 -40px;

}
/* .map_wrap  .overlaybox li.up{
	word-wrap: break-word;

	width: 150px;
	white-space: pre-line;
	line-height:1.5;
}
 */
.map_wrap  .overlaybox li .down {background-position:0 -60px;}
.map_wrap .overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
.map_wrap .overlaybox li:hover {color:#fff;background:#d24545;}
.map_wrap .overlaybox li:hover .up {background-position:0 0px;}


.map_wrap .overlaybox li:hover .down {background-position:0 -20px;} 



 #menu_wrap::-webkit-scrollbar {
   width: 6px;
 }
 #menu_wrap::-webkit-scrollbar-thumb {
   background-color: #f99510;
   border-radius: 10px;
 }
 #menu_wrap::-webkit-scrollbar-track {
   background-color: grey;
   border-radius: 10px;
   box-shadow: inset 0px 0px 5px white;
 }
 
 
#pagingul {
    text-align: center;
    display: inline-block;
    /* border: 1px solid #ccc; */
}

#pagingul li {
    text-align: center;
    float: left;
}

#pagingul li a {
    display: block;
    font-size: 14px;
    padding: 5px 15px;
    border: 1px solid #ccc !important;
    box-sizing: border-box;
}

#pagingul li.on {
    background: #f99208;
}

#pagingul li.on a {
    color: #fff;
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
				<h1 class="warp-title">장소 맵</h1>				
			</div>	
			</div>
		</div> 
			

		<div class="row">	
			<div class="col-xs-12 col-sm-12 col-md-12">	
			
				
					<form method="get" action="/place/map">
						<ul class="board-search" >
							<li>
								<select name="searchType" id="board-search-select">
										<option value="t" <c:out value="${param.searchType eq 't' ? 'selected' : '' }" />>제목</option>
										<option value="w" <c:out value="${param.searchType eq 'w' ? 'selected' : '' }" />>작성자</option>
										<option value="tcw" <c:out value="${param.searchType eq 'tcw' ? 'selected' : '' }" />>제목+작성자</option>
								</select>
							</li>
							<li>
							<input type="search" name="keyword" id="keyword" value="${param.keyword }" placeholder="검색어 입력" ></li>
							<li><input type="button" value="검색" class="button border-search-submit"></li>
						</ul>
					</form>
			</div>
		</div>

		  

		<div class="row">
			 <div class="col-xs-12 col-sm-12 col-md-12" >
			
			 <div class="row" style="margin-left: -30px">
			 	<div class="col-xs-6 col-sm-12 col-md-6">
			 		<select id="dataPerPage" class="form-control">
				        <option value="15">15개씩보기</option>
				        <option value="30">30개씩보기</option>
				        <option value="100">100개씩보기</option>
					</select>
					
					<button class="mbtn" id="left-handle" style="margin-bottom: 20px; padding: 0 1.2em;height:35px;display: none" >
					<i class="fas fa-arrows-alt-h"></i> 
					</button>
					
					<input type="hidden" id="convertToggle" value="${convertToggle}">
					
					<button class='${empty convertToggle?  "mbtn" :"mbtn-grey"}'
					  id="makerInfoShowAll" style="margin-bottom: 20px; padding: 0 1.2em;height:35px" >
						<i class="fas fa-map-marked"></i>
					</button>
					
					<button class='${not empty convertToggle ? "mbtn" :"mbtn-grey"}' 
						id="makerInfoShow" style="margin-bottom: 20px; padding: 0 1.2em;height:35px" >
						<i class="fas fa-map-marked-alt"></i>
					</button>			 	
			 	</div>
			 	 <div class="col-xs-6 col-sm-12 col-md-6" style="text-align: right">
			  		<ul id="pagingul"></ul>
			 	 </div>
			 </div>
			
			
						 
			 	
			 	
			 	
			<div class="list con">
				<div class="row">
				
				<div class="blank-text" style="font-size: 25px;text-align: center;padding: 50px; display: none">데이터가 없습니다.</div>
				
				<div class="map_wrap">
				
				    <div id="map" style="width:1200px; min-height:700px;  height:100%;position:relative;overflow:hidden;"></div>
				

				    <div id="menu_wrap" class="bg_white">
		<!-- 		        <div class="option">
				            <div>
				                <form onsubmit="searchPlaces(); return false;">
				                    키워드 : <input type="text" value="" id="keyword" size="15"> 
				                    <button type="submit">검색하기</button> 
				                </form>
				            </div>
				        </div> -->
				        <hr>
				        <ul id="placesList"></ul>
				     
				       
				    </div>
				</div>
		
		
				</div>		
			</div>
			 			
			 </div>
		 </div>
			
		

		
		
			<div id="boardFooterAd" style="margin-bottom: 200px"></div>

		</div>

	</section>


	
	<%@ include file="../include/nav-bottom.jsp"%>
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
	<script src="/resources/web/js/board/map_list.js"></script>
  
  
  
</body>
</html>