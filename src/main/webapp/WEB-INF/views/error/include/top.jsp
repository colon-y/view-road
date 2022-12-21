<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <span id="warning-container"><i data-reactroot=""></i></span>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
<a class="btn btn-navbar" data-toggle="collapse"data-target=".nav-collapse">
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span> </a>
    
    <a class="brand" href="/"><i class="icon-globe"></i>&nbsp; Member Service System </a>
				<div class="nav-collapse">
	

	<ul class="nav pull-right">	
	  <c:choose>
	  	 <c:when test="${ not empty USER }">
	  	 	<li><a	href="mailto:${USER.email }"><i
				class="icon-envelope"></i>&nbsp; ${USER.email }
				</a>					
			</li>  	  	 
	  	 	
	  	      <li class="dropdown"><a	href="#" class="dropdown-toggle" data-toggle="dropdown"><i
				class="icon-user"></i>&nbsp; ${USER.id }<b class="caret"></b>
				</a>
					<ul class="dropdown-menu">								
					<li style="display:table; margin: auto;height:20px;">
						<a href="/logout" style="height: 100%;">로그아웃</a>
					</li>					
					</ul>					
				</li>  	 
	  	 </c:when>
	  	 <c:otherwise>	  	 			  	 	  
	  	 </c:otherwise>
	  </c:choose>

	</ul>
	
				</div>
				<!--/.nav-collapse -->
			</div>
			<!-- /container -->
		</div>
		<!-- /navbar-inner -->
	</div>
	