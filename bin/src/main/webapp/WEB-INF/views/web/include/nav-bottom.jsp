<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<a id="topBtn" href="#">TOP</a>
<script>
	$(function() {
		$(window).scroll(function() {
			if ($(this).scrollTop() > 250) {
				$('#topBtn').fadeIn();
			} else {
				$('#topBtn').fadeOut();
			}
		});

		$("#topBtn").click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 400);
			return false;
		});
	});
</script>