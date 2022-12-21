<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<c:choose>
 <c:when test="${ empty sessionScope.USER }">
 
  
<div id="boardComment" class="panel-footer board board-view-comment" >
          <h5 style="margin-bottom:0">답변쓰기</h5>
       
       <form action="/board/replies/create" method="post" id="boardCommentForm" >


              <p>
      <input id="submitbtn" class="form-control tooltipstered" min="1" maxlength="500" required aria-required="true" 
               name="content" type="text"  placeholder="댓글을 입력해주세요 (최대 500자)" />
             </p>
           
  
<p style="display: none;">
<input id="clicktoshow1" class="hidden form-control tooltipstered" min="1" maxlength="10" required="" 
aria-required="true" style="float:left; margin-bottom:25px; 
width:48%; height:40px; border: 1px solid #d9d9de" name="username"  type="text" placeholder="작성자 (최대 10자)"></p>
<p style="display: none;">
<input id="clicktoshow2" class="hidden form-control tooltipstered" 
min="4" maxlength="4" required="" aria-required="true" 
style="ime-mode:inactive; float:right; margin-bottom:25px; width:48%; height:40px; border: 1px solid #d9d9de" 
name="replyPassword" type="password"  placeholder="비밀번호 (4자)"  >
</p>                  
     
              
             
              

              
          	  <c:choose>
						<c:when test="${not empty USER}">							   
            			   <input id="clicktoshow3" class="button form-control tooltipstered hidden"  type="button" value="답변 쓰기">
						</c:when>
					<c:otherwise>
							<li><button class="button form-control tooltipstered wsubmit" 
							 	style=" color: #fff;
								    background-color: #607d8b;
								    opacity: .8;
								    border: 1px solid #d67c20;
								    margin: 0px !important;
								    padding-bottom:30px;
								    font-weight: normal;
								    
								" onclick="alert('로그인후 댓글쓰기가 가능합니다.')">로그인후 답변쓰기가 가능합니다.
							 	</button>
							 </li>					
				</c:otherwise>
			</c:choose>              
              
              
              <input type="hidden" name="bno">               	                       
          </form>
      </div> 
                
 </c:when>
 <c:otherwise>
 
 <div id="boardComment" class="panel-footer board board-view-comment">
       <h5 style="margin-bottom:0">답변쓰기</h5>  
                     
       <form action="/board/replies/create" method="post" id="boardCommentForm">
  
       <p><input id="submitbtn" class="form-control tooltipstered" minlength="1" maxlength="500" required
       aria-required="true"
       name="content" type="text"  placeholder="답변을 입력해주세요 (최대 500자)"   ></input>
       </p>                    
     
       <p>
       <input disabled id="clicktoshow1" value="${sessionScope.USER.username }"  class="hidden form-control tooltipstered" 
       minlength="1" maxlength="10" required aria-required="true"  name="username" type="text"   placeholder="작성자 (최대 10자)"/>               
       </p>                        
                                        
<input id="clicktoshow3" class="button form-control tooltipstered hidden" type="button" value="답변 쓰기">
<p><input type="hidden" name="bno"> 

</p>

                    	 
   </form>
       
</div>
          
 
 
 
 </c:otherwise>
</c:choose>    
