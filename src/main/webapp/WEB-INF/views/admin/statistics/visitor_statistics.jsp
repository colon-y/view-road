<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
<link href="/resources/admin/css/statistics/statistics.css" rel="stylesheet">
</head>
<body>
	<div class="container-scroller">


		<%@ include file="../include/top_menu.jsp"%>

		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_settings-panel.html -->

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
										<a class="nav-link   ps-0" 
										id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" 
										aria-controls="overview" aria-selected="true"
										>관리자 메인화면</a></li>

										<li class="nav-item " onclick="location.href='/admin/statistics/visitorStatistics'">
										<a class="nav-link active" id="profile-tab" data-bs-toggle="tab"
										 href="#audiences" role="tab"
											aria-selected="false"
										>방문자수</a></li>

																	
										<li class="nav-item" onclick="location.href='/admin/statistics/newMemberRegist'">
										
										<a class="nav-link" 
										id="contact-tab" data-bs-toggle="tab" href="#" role="tab" aria-selected="false">  새회원 가입수</a></li>

									</ul>
								</div>


								<div class="tab-content tab-content-basic">
									<div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"></div>
								</div>

								
								<h2 class="mb-3">방문자수</h2>								
								
								<div class="row">
								<div class="col-lg-6 grid-margin stretch-card">
										<div class="sec_cal">
										  <div class="cal_nav">
										    <a href="javascript:;" class="nav-btn go-prev">prev</a>
										    <div class="year-month"></div>
										    <a href="javascript:;" class="nav-btn go-next">next</a>
										  </div>
										  <div class="cal_wrap">
										    <div class="days">
										      <div class="day">월</div>
										      <div class="day">화</div>
										      <div class="day">수</div>
										      <div class="day">목</div>
										      <div class="day">금</div>
										      <div class="day">토</div>
										      <div class="day">일</div>
										    </div>
										    <div class="dates"></div>
										  </div>
										</div>
								</div>
								<div class="col-lg-6 grid-margin stretch-card">
									<input type="month" class="form-control" id="currentMonth" 										
									value="${currentMonth}">
								</div>
								</div>								
								
								
								<h3 class="mb-3 text-warning">세션 방문자수</h3>
								<div class="row">
									<div class="col-lg-6 grid-margin stretch-card">
										<div class="card">
											<div class="card-body">
												<h4 class="card-title">막대 차트</h4>
												<div id="barChartDiv">
												<canvas id="barChart"></canvas>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-6 grid-margin stretch-card">
										<div class="card">
											<div class="card-body">
												<h4 class="card-title">라인 차트</h4>
												<div id="lineChartDiv">
													<canvas id="lineChart"></canvas>
												</div>
											</div>
										</div>
									</div>									
								</div>



								<h3 class="mt-3 mb-3 text-danger">IP 방문자수</h3>
								<div class="row">
									<div class="col-lg-6 grid-margin stretch-card">
										<div class="card">
											<div class="card-body">
												<h4 class="card-title">IP 막대 차트</h4>
												<div id="ipBarChartDiv">
												<canvas id="ipBarChart"></canvas>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-6 grid-margin stretch-card">
										<div class="card">
											<div class="card-body">
												<h4 class="card-title">IP 라인 차트</h4>
												<div id="ipLineChartDiv">
													<canvas id="ipLineChart"></canvas>
												</div>
											</div>
										</div>
									</div>									
								</div>


							</div>
						</div>
					</div>
				</div>


				<%@ include file="../include/footer.jsp"%>



			</div>
			<!-- main-panel ends -->


		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->


	<%@ include file="../include/footer_script.jsp"%>
	<script src="/resources/admin/js/statistics/visitor_statistics.js"></script> 
	


</body>
</html>

