<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="include/head.jsp"%>
<style type="text/css">
.book-write {
	background: #15749e;
}

.book-write:hover {
	opacity: 0.8
}
</style>
</head>
<body>
	<div class="container-scroller">


		<%@ include file="include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_settings-panel.html -->

			<%@ include file="include/right_setting.jsp"%>

			<%@ include file="include/left_menu.jsp"%>


<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-sm-12">
				<div class="home-tab">

					<div class="d-sm-flex align-items-center justify-content-between border-bottom">
						<ul class="nav nav-tabs" role="tablist">
						</ul>
					</div>

					<div class="tab-content tab-content-basic">
						<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">


							<div class="row">
								<div class="col-lg-12 grid-margin stretch-card">



									<div class="card">
										<div class="card-body">
											<h4 class="card-title">관리자 화면</h4>
											<p class="card-description">
												관리자 메인화면
												<code></code>
											</p>
											<div class="template-demo">



												<button type="button" class="btn btn-dark btn-lg btn-block" 
														onclick="location.href='${home}/'">
													<i class="menu-icon mdi mdi-home"></i> 사이트 홈
												</button>


												<button type="button" class="btn btn-warn btn-lg btn-block" 
														onclick="location.href='/members'" style="background: #ff9800">
													<i class="mdi mdi-account-card-details"></i> 마이페이지
												</button>


												<button type="button" class="btn btn-warn btn-lg btn-block" 
														onclick="location.href='/admin'" style="background: #323f87">
													<i class="mdi mdi-grid-large menu-icon"></i> 관리자 메인화면
												</button>

												<button type="button" class="btn btn-primary btn-lg btn-block" 
														onclick="location.href='${home}/admin/member/memberList'">
													<i class="mdi mdi-account-multiple-outline"></i> 회원 관리
												</button>



												<c:if test="${USER.role eq 'ROLE_ADMIN'}">
													<button type="button" class="btn btn-danger btn-lg btn-block" 
														onclick="location.href='${home}/admin/smtpUpdate'">
														<i class="mdi mdi-email-variant"></i> SMTP 관리
													</button>
												</c:if>


												<button type="button" class="btn btn-success btn-lg btn-block" 
													onclick="location.href='/admin/note/receiveList'">
													<i class="far fa-paper-plane"></i> 쪽지 관리
												</button>


												<button type="button" class="btn btn-info btn-lg btn-block" 
													onclick="location.href='/admin/statistics/visitorStatistics'">
													<i class="fas fa-chart-bar"></i> 통계 관리
												</button>


							

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
	</div>
	<!-- content-wrapper ends -->

	<%@ include file="include/footer.jsp"%>



	<!-- partial -->
</div>





		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->


	<%@ include file="include/footer_script.jsp"%>

</body>
</html>

