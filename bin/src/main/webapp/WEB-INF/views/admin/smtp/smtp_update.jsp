<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
</head>
<body>
	<div class="container-scroller">


		<%@ include file="../include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">


			<%@ include file="../include/right_setting.jsp"%>

			<%@ include file="../include/left_menu.jsp"%>

			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<div class="row">
						<div class="col-sm-12">
							<div class="home-tab">
								<div class="d-sm-flex align-items-center justify-content-between border-bottom">
									<ul class="nav nav-tabs" role="tablist">
										<li class="nav-item" onclick="location.href='${home}/admin'">
										 <a class="nav-link    ps-0" 
										id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" 
										aria-selected="true">관리자 메인화면</a></li>
										
									
									</ul>

								</div>





								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">



										<div class="row">
											<div class="col-md-6 offset-md-3 grid-margin stretch-card">
												<div class="card">
													<div class="card-body">
														<h4 class="card-title text-center">SMTP 관리</h4>
														<p class="card-description"></p>

														<form class="forms-sample" id="frm1" method="post" action="memberDelete">
														
															<div class="form-group row">
																<label for="userId" class="col-sm-3 col-form-label">이메일발송자명</label>
																<div class="col-sm-9">
																	<input type="text" class="form-control" id="emailName" name="emailName"
																	 value="${smtpVO.emailName}" placeholder="이메일발송자명" autocomplete="off"> 
																	 <span class="mt-3" id="emailNameCheck" style="color: red; 
																	 position:relative; top: 10px; display: none;"></span>
																</div>
															</div>														
														
															<div class="form-group row">
																<label for="email" class="col-sm-3 col-form-label">host</label>
																<div class="col-sm-9">
																	<input type="text" class="form-control" id="host" name="host"
																	 value="${smtpVO.host}" placeholder="host"  autocomplete="off"> 
																	 <span class="mt-3" id="hostCheck" 
																	 style="color: red; position:relative; top: 10px; display: none;"></span>
																</div>
															</div>


															<div class="form-group row">
																<label for="username" class="col-sm-3 col-form-label">username</label>

																<div class="col-sm-9">
																	<input type="text" 
																	 autocomplete="off"
																	class="form-control" id="username" name="username" placeholder="username" value="${smtpVO.username}">
																</div>
															</div>


															<div class="form-group row">
																<label for="pwck_input" class="col-sm-3 col-form-label">password</label>

																<div class="col-sm-9">
																	<input type="password" class="form-control" id="password" name="password" placeholder="password" value="${smtpVO.password}">
																</div>
															</div>

											

															<div class="form-group row text-center">
																<div class="col-sm-12">														
																	<button type="button" id="smtpUpdateBtn" class="btn btn-info me-2 join_button">수정하기</button>																	
																</div>
															</div>

														</form>

													</div>
												</div>
											</div>




										</div>






									</div>
								</div>


							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->

				<%@ include file="../include/footer.jsp"%>


				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>		
	</div>


	<%@ include file="../include/footer_script.jsp"%>


	<script src="${home}/resources/admin/js/custom/smtp.js"></script>


</body>
</html>

