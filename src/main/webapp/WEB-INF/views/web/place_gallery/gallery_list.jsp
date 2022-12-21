<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:forEach items="${list}" var="row" varStatus="status">

	<a data-lg-size="1600-1067" class="gallery-item"
		data-sub-html="<h4>${row.place} <br> 
                <a href='/place/${row.boardType eq "place_reviews" ? "reviews":"introduction"}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}' style='font-weight:400' >${row.title}</a></h4>
                <p> 작성자 - <a href='/place/${row.boardType eq "place_reviews" ? "reviews":"introduction"}/read/${row.bno}?keyword=${param.keyword}&st=${param.st}'>
       </a>${row.username }</p>"
		data-src="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}"
	> <img alt="${row.place}" class="img-responsive" src="/displayFile?fileName=${fn:replace(row.fileName, 's_', '')}" />
	</a>
</c:forEach>