<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          
          
          <li class="nav-item">
            <a class="nav-link" href="${home}/">            
              <i class="menu-icon mdi mdi-home"></i> 
              <span class="menu-title">사이트홈</span>              
            </a>
          </li>
    
          <li class="nav-item">
            <a class="nav-link" href="/members">
              <i class="menu-icon mdi mdi-account-card-details"></i>
              <span class="menu-title">마이페이지</span>
            </a>
          </li>
          
    
          <li class="nav-item ${menuName eq '관리자 메인화면'  ?  'active':''} ">
            <a class="nav-link" href="${home}/admin">
              <i class="mdi mdi-grid-large menu-icon"></i>
              <span class="menu-title">관리자 메인화면</span>
            </a>
          </li>
     
     

          <li class="nav-item">
            <a class="nav-link collapsed" data-bs-toggle="collapse" 
           	 href="#form-members" aria-expanded="false" aria-controls="form-members">
              <i class="menu-icon mdi mdi-account-multiple-outline"></i>
              <span class="menu-title">회원관리</span>
              <i class="menu-arrow"></i>
            </a>
            
         	<div class="collapse" id="form-members">
              <ul class="nav flex-column sub-menu">
                 <li class="nav-item"> 
                 	<a class="nav-link" href="#" onclick="location.href='${home}/admin/member/memberList'"> 회원목록</a>
                 </li>

                 <li class="nav-item"> 
                 	<a class="nav-link" href="#" onclick="location.href='${home}/admin/member/memberWrite'"> 회원등록</a>
                 </li>
              </ul>
            </div>
          </li>
       
       
	<c:if test="${USER.role eq 'ROLE_ADMIN'}">     
	          <li class="nav-item ${menu eq 'smtpUpdate'  ?  'active':''}">
	            <a class="nav-link " href="#" onclick="location.href='${home}/admin/smtpUpdate'">
	              <i class="menu-icon mdi mdi-email-variant"></i>
	              <span class="menu-title">SMTP관리</span>
	            </a>
	          </li> 
	</c:if>
       
       
	         <li class="nav-item ${menuName eq '쪽지관리'  ?  'active':''}">
	           <a class="nav-link" href="#" onclick="location.href='${home}/admin/note/receiveList'">
	            <i class="far fa-paper-plane menu-icon"></i> 
	             <span class="menu-title">쪽지관리</span>
	           </a>
	         </li>
	    
       
       
          <li class="nav-item ${menuName eq '통계관리'  ?  'active':''}">
            <a class="nav-link collapsed" data-bs-toggle="collapse" 
           	 href="#form-book" aria-expanded="false" aria-controls="form-book">
              <i class="fas fa-chart-bar menu-icon"></i>
              <span class="menu-title">통계관리</span>
              <i class="menu-arrow"></i>
            </a>
            
         	<div class="collapse" id="form-book">
              <ul class="nav flex-column sub-menu">
                 <li class="nav-item"> 
                 	<a class="nav-link" href="#" onclick="location.href='${home}/admin/statistics/visitorStatistics'"> 일별 방문자 수</a>
                 </li>

                 <li class="nav-item"> 
                 	<a class="nav-link" href="#" onclick="location.href='${home}/admin/statistics/newMemberRegist'">일별 새회원 가입수</a>
                 </li>
              </ul>
            </div>
          </li>            
       
       
  
 
          
          

        </ul>
      </nav>