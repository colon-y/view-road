<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 	<input type="hidden" id="NOTICE_COUNT_SETINTERVAL" value="5000" >
   <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row" style="margin-top: 0px !important; padding-top: 0px !important">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
        <div class="me-3">
          <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-bs-toggle="minimize">
            <span class="icon-menu"></span>
          </button>
        </div>
        <div>
          <a class="navbar-brand brand-logo" href="${home}/admin" 
          	style="width: 78px">
            <img src="${home}/resources/admin/images/logo.svg" alt="logo" />            
          </a>

          <a class="navbar-brand brand-logo-mini" href="${home}/admin">
            <img src="${home}/resources/admin/images/logo-mini.svg" alt="logo" />
          </a>
        </div>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-top"> 
        <ul class="navbar-nav">
          <li class="nav-item font-weight-semibold d-none d-lg-block ms-0">
            <h1 class="welcome-text"><span class="text-black fw-bold">${menuName}</span></h1>       
          </li>
        </ul>
        
        
        <ul class="navbar-nav ms-auto">


          <li class="nav-item">
            <form class="search-form" action="${home}/admin/member/memberList">
              <i class="icon-search"></i>
              <input type="hidden" name="searchType"  value="all">
              <input type="search" name="keyword"  class="form-control" placeholder="검색" title="검색"  value="${param.keyword}">
            </form>
          </li>



	<li class="nav-item dropdown"> 
            <a class="nav-link count-indicator" id="countDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="icon-bell"></i>
              <span class="count"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list pb-0" aria-labelledby="countDropdown">
              <a class="dropdown-item py-3" href="/members/note/groupMessgeList" style="    justify-content: space-between;">
                <p class="mb-0 font-weight-medium float-left">알림 메시지 </p>
                <span class="badge badge-pill badge-primary float-right">전체보기</span>
              </a>
              <div class="dropdown-divider"></div>
           	<div id="alertHtml">
           
  
           </div>
           
            </div>
          </li>
       
		  


          
          
          <li class="nav-item dropdown d-none d-lg-block user-dropdown">
            <a class="nav-link" id="UserDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">          
              <i class="menu-icon mdi mdi-account-circle-outline" style="font-size: 2.3rem;"></i> 
             </a>
             
             
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
              <div class="dropdown-header text-center">
                <i class="menu-icon mdi mdi-account-circle-outline" style="font-size: 2.3rem;"></i>
                <p class="mb-1 mt-3 font-weight-semibold">
                <a href="/admin/member/memberInfo?uid=${USER.uid}">${USER.username}  님</a></p>
                
              </div>
              


              <a class="dropdown-item" href="${home}/logout">
              <i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>로그아웃</a>
            </div>
          </li>
        </ul>
        
        
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
          <span class="mdi mdi-menu"></span>
        </button>
      </div>
    </nav>
    