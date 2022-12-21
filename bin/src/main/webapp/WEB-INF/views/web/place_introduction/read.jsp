<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp" %>
</head>
<body>

<%@ include file="../include/header.jsp" %>

 <section id="warp">
 		<input type="hidden" id="USER_userId" value="${sessionScope.USER.userId}">
 		<input type="hidden" id="USER_uid" value="${sessionScope.USER.uid}">
 		<input type="hidden" id="USER_username" value="${sessionScope.USER.username}">
 		<input type="hidden" id="bno" value="${boardVO.bno}">
 		<input type="hidden" id="board_uid" value="${boardVO.uid}">
 		<input type="hidden" id="board_username" value="${boardVO.username}">
 		<input type="hidden" id="board_userId" value="${boardVO.userId}">
 		<input type="hidden" id="isAdmin" value="${isAdmin}">
 		<input type="hidden" id="page" value="${param.page}">
 		<input type="hidden" id="board_url" value="/place/introduction">
 		<input type="hidden" id="board_type" value="place_introduction">
 	    <input type="hidden" id="createdDate" value="<fmt:formatDate value="${boardVO.createdDate}" pattern="yyyy-MM-dd"/>">		
 	    <input type="hidden" id="customDate" value="${boardVO.customDate()}">		
 	    <input type="hidden" id="likeCnt" value="${boardVO.likeCnt}">	
 	    <input type="hidden" id="viewCnt" value="${boardVO.viewCnt}">
 	    <input type="hidden" id="replyCnt" value="${boardVO.replyCnt}">
 	   
        <div class="container read-container" >

			<div class="row">
			 	<div class="col-xs-12 col-sm-12 col-md-12">						
				<div class="bn-box con">
					<h1 class="warp-title">장소 소개
					
					<input type="hidden" name="latitude" id="latitude" value="${boardVO.latitude}">
					<input type="hidden" name="longitude" id="longitude" value="${boardVO.longitude}">
					</h1>				
				</div>	
				</div>
			</div> 

            	
            	<ul class="board-right-tab mt-0">             	
            		<li>            		
            			<a class="button right-board" href="/place/introduction/list">목록 보기</a>
            		</li>
     			    <c:if test="${not empty USER and (USER.role eq 'ROLE_ADMIN') or (USER.role eq 'ROLE_MANAGER') }">
							<li style="margin-right: 10px">
								<a class="button right-board" href="/place/introduction/write">글쓰기</a>
							</li>	
					</c:if>           		            	            
            	</ul>
            	
      
             	<div class="board-view-header" style="margin-top: 65px">
           
             	
             	<div class="map_wrap">
				    <div id="map" ></div>				 
			        <p id="map-sub-option">
					    <input type="checkbox" id="chkUseDistrict" onclick="setOverlayMapTypeId()" /> 지적편집도 정보 보기
					    <input type="checkbox" id="chkTerrain" onclick="setOverlayMapTypeId()" /> 지형정보 보기 
					    <input type="checkbox" id="chkTraffic" onclick="setOverlayMapTypeId()" /> 교통정보 보기       
					    <input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> 자전거도로 정보 보기
					</p>
					<input type="hidden" id="address" value="${boardVO.address}">
					<input type="hidden" id="place" value="${boardVO.place}">
					<input type="hidden" id="title" value="${boardVO.title}">
					<input type="hidden" id="fileName" value="${boardVO.fileName}">

			    </div>
            
            <div class="sub_wrap">
            	 <p>
            		<span>
            		<i class="fa fa-user"></i> 
            		<strong class="logined">${boardVO.username}</strong>
            		</span>
            		            		
            		<span><i class="fa fa-calendar"></i>
            			<fmt:formatDate value="${boardVO.createdDate}" pattern="yyyy-MM-dd"/>            		 
            		</span>
            		
            		<span>
            			<i class="fas fa-hourglass-end"></i>
            			${boardVO.customDate()}
            		</span>
            	 </p>
            		
            		<c:if test="${not empty boardVO.fileName}">
	            		<p class="mtb-20">
	            			<img src="/displayFile?fileName=${boardVO.fileName}" class="img-responsive img-rounded mxw-300" >
	            		</p>
            		</c:if>
            		
					<h4>${boardVO.title}</h4>
      
      			<form method="post" action="/place/introduction/boardEditDirect"  id="directForm"> 
		      		    <input type="hidden" value="${boardVO.bno}" name="bno">
		      			<input type="hidden"  name="boardPassword" id="formPw">		            	
		            	<p>
						<span id="topLikeCount" >
							<img class="board-star-img" src="/resources/web/images/star_grey.png">0
						</span>
						<span><i class="fa fa-eye"></i> 조회 ${boardVO.viewCnt}</span>
						<span><i class="fa fa-comments"></i> 
							<a href="#boardComment" onclick="return false;" id="boardComment2">댓글 0</a>
						</span>
		
						<c:if test="${not empty USER and not empty  boardVO.userId }">				
							<span>
								<a href="#" onclick="return false;"  id="boardScrap" data-bno="${boardVO.scrapCnt ==1 ? -1:boardVO.bno}">
								${boardVO.scrapCnt ==1 ? '<i class="fas fa-check"></i>' :'<i class="fas fa-fw fa-thumbtack"></i>'}스크랩</a>				
							</span> 					
							
  							<c:if test="${USER.userId ne  boardVO.userId }">								
								<span data-toggle="modal" data-target="#noteModal" class="noteModal">
									<a href="#" onclick="return false;">
									<i class="far fa-paper-plane" ></i> 쪽지보내기</a>				
								</span> 
							</c:if>
													 	      					
						    <c:if test="${ (USER.userId  eq  boardVO.userId )	or  isAdmin}">													
									 <span class="editBoardLoginedUser" style="cursor: pointer;"><a>수정</a></span>
							    	 <span class="deleteBoardLoginedUser" style="cursor: pointer;"><a>삭제</a></span>					         
							 </c:if> 
				      	</c:if>
				      	
			     		 </p>
	     		   </form>	            	
				</div>

			</div>
            
            
            	<div class="board-view-body">
            		<div class="board-view-desc">
            		${boardVO.content }        		            		
            		</div>
            		
            		
            	 	<p class="addThumb col-xs-12">
			            <a id="boardThumb"  href="#" >	
			            		
		            		<c:choose>
		            			<c:when test="${boardVO.myLikeCnt>0 }">
		            				 <img class="board-star-img" src="/resources/web/images/star.png">
									 <span>추천 취소</span> 
								 	<input type="hidden" id="likeCount" value="${boardVO.likeCnt}">
		            			</c:when>
		            			<c:otherwise>
		            				<img class="board-star-img" src="/resources/web/images/star_grey.png"> 
									<span>추천</span>     
									<input type="hidden" id="likeCount" value="${boardVO.likeCnt}">
		            			</c:otherwise>
		            		</c:choose>         			            	
			            </a>      			          	     
            		</p>
            		
            		
            		<div  style="text-align: center;width:100%; height:auto; display:inline-block; margin-bottom:15px"></div>
				</div>
				
	
	   ﻿<%@  include file="replyForm.jsp" %>
	    
    

       
    
    
                        
      <!-- 댓글 리스트 뷰 panel-footer-->
      <div class="panel-footer board board-view-comment"  id="replyList" ></div>	
      
      
    	
			  <!-- 댓글 리스트 뷰 panel-footer-->          
      <div class="row">  
    	   <div class="col-xs-12 col-sm-12 col-md-12">				  		
    		<ul class="board-right-tab">      
    				<li><button class="button default" onclick="listView()" id="btn-listView" ><i class="fas fa-list"></i> 리스트</button></li>		       	
            		<li><button  class="button right-board mr-10" onclick="galleryView()"  id="btn-galleryView" ><i class="fas fa-image"></i> 갤러리</button></li>     			    														           		            	          
            </ul>    		
            </div>
      </div>    	
			
		<ul class="board-left-tab">
			<li>&nbsp;</li>		
		</ul>
			
		 <div class="board-container pt-0 mt-0">					    	
		 </div>

			</div>
        </section>


	<%@ include file="../include/noteModal.jsp" %>



    <%@ include file="../include/nav-bottom.jsp" %>
    <%@ include file="../include/footer.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KAKAO_APP_KEY}&libraries=services"></script>
	<script type="text/javascript" src="/resources/web/js/board/board-read.js"></script>			
					       


</body>
</html>



