<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 스토어</h3>

<form action="./list" name="form" id="form" class="sh">
	<input type="text" title="검색어" name="keyword" value="${param.keyword}" />
	<button type="submit" class="btn is-grey">검색</button>
</form>

<div class="store_wrap mt20">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<a href="./view?productNo=${result.productNo}">
					<div class="thumbImg"><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}" height="188" width="250"></div>
					<div class="info">
						<span>${result.productName}</span>
						<span><b class="price"><fmt:formatNumber value="${result.price}" pattern="#,###" /></b>원</span>
					</div>
				</a>
			</li>
		</c:forEach>
	</ul>
	<c:if test="${fn:length(resultList) eq 0}"><div>'${param.keyword}'에 대한 상품이 없습니다.</div></c:if>
</div>

<c:if test="${fn:length(resultList) != 0 }">
	<div class="pagination_wrap">
		<div class="pagination">
			<c:set var="pageIndex" value="${pagination.pageIndex}" />
			<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
			<c:url var="link" value="./list?keyword=${param.keyword}" />

			<c:if test="${pageIndex eq 1}">
				<a>이전</a>
			</c:if>
			<c:if test="${pageIndex ne 1}">
				<a href="${link}&pageIndex=${pageIndex-1}">이전</a>
			</c:if>
			<c:forEach var="num" begin="${pagination.firstPageNo}" end="${pagination.lastPageNo}">
				<c:choose>
					<c:when test="${pageIndex eq num}">
						<a class="active">${num}</a>
					</c:when>
					<c:otherwise>
						<a href="${link}&pageIndex=${num}">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageIndex eq totalPageCount}">
				<a>다음</a>
			</c:if>
			<c:if test="${pageIndex ne totalPageCount}">
				<a href="${link}&pageIndex=${pageIndex+1}">다음</a>
			</c:if>
		</div>
	</div>
</c:if>
