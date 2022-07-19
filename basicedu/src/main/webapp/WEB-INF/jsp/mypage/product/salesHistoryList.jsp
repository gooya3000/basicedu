<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table">
	<colgroup>
		<col width="8%">
		<col width="15%">
		<col width="15%">
		<col width="15%">
		<col width="47%">
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>구매자 아이디</th>
			<th>결제일자</th>
			<th>상태</th>
			<th>구매후기</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="resultCnt" value="${pagination.totalRecordCount}" />
		<c:forEach var="result" items="${salesHistoryList}" varStatus="status">
			<tr>
				<td class="txt-center">${(resultCnt) - (pagination.recordCountPerPage * (pagination.pageIndex-1))}</td>
				<td><a href="./orderView?orderNo=${result.orderNo}">${result.id}</a></td>
				<td class="txt-center"><fmt:formatDate value="${result.orderDate}" pattern="yyyy-MM-dd"/></td>
				<td class="txt-center">
					<c:choose>
						<c:when test="${result.orderStatus eq '1'}">결제완료</c:when>
						<c:when test="${result.orderStatus eq '2'}">발송완료</c:when>
						<c:when test="${result.orderStatus eq '3'}">구매확정</c:when>
					</c:choose>
				</td>
				<td>
					<c:if test="${not empty result.contents}">
						<% pageContext.setAttribute("br", "\n"); %>
						${fn:replace(result.contents, br, '<br>')}
					</c:if>
					<c:if test="${empty result.contents}">-</c:if>
				</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt -1}" />
		</c:forEach>
		<c:if test="${fn:length(salesHistoryList) eq 0}">
			<tr>
				<td colspan="5" class="txt-center">판매내역이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<c:if test="${fn:length(salesHistoryList) != 0 }">
	<div class="pagination_wrap">
		<div class="pagination">
			<c:set var="pageIndex" value="${pagination.pageIndex}" />
			<c:set var="totalPageCount" value="${pagination.totalPageCount}" />

			<c:if test="${pageIndex eq 1}">
				<a>이전</a>
			</c:if>
			<c:if test="${pageIndex ne 1}">
				<a href="javascript:getSalesHistoryList(${pageIndex-1})">이전</a>
			</c:if>
			<c:forEach var="num" begin="${pagination.firstPageNo}" end="${pagination.lastPageNo}">
				<c:choose>
					<c:when test="${pageIndex eq num}">
						<a class="active">${num}</a>
					</c:when>
					<c:otherwise>
						<a href="javascript:getSalesHistoryList(${num})">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageIndex eq totalPageCount}">
				<a>다음</a>
			</c:if>
			<c:if test="${pageIndex ne totalPageCount}">
				<a href="javascript:getSalesHistoryList(${pageIndex+1})">다음</a>
			</c:if>
		</div>
	</div>
</c:if>
