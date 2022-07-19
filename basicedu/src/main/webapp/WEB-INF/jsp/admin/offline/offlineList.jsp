<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_online_list.css">


<div class="onlec_mg_list">

	<table class="onlec_mg_list_table">
		<tr>
			<th class="onlec_mg_list_th">번호</th>
			<th class="onlec_mg_list_th">강의명</th>
			<th class="onlec_mg_list_th">강의 장소</th>
			<th class="onlec_mg_list_th">등록일</th>
		</tr>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td class="onlec_mg_list_td"><a href="./offlineSelect?offline_lecture_NO=${list.offline_lecture_NO}">${list.offline_lecture_NO}</a></td>
				<td class="onlec_mg_list_td">${list.offline_lecture_name}</td>
				<td class="onlec_mg_list_td">${list.offline_lecture_address}</td>
				<td class="onlec_mg_list_td">${list.offline_lecture_reg}</td>
			</tr>
		</c:forEach>
	</table>
</div>

	<c:if test="${fn:length(list) != 0 }">
			<div class="pagination_wrap">
				<div class="pagination">
					<c:set var="pageIndex" value="${pagination.pageIndex}" />
					<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
					<c:url var="link" value="./onlecmgList" />

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