<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>광클</title>
	<link rel="stylesheet" href="/resources/css/common.css">
	<link rel="stylesheet" href="/resources/css/pagination.css">
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div class="popup_wrap">
		<h3>| 강사 조회</h3>

		<form action="./memberListPop" name="form" id="form" class="sh">
			<select name="searchSe">
				<option value="1" <c:if test="${param.searchSe eq '1'}">selected="selected"</c:if>>강사 아이디</option>
				<option value="2" <c:if test="${param.searchSe eq '2'}">selected="selected"</c:if>>강사명</option>
			</select>
			<input type="text" title="검색어" name="keyword" value="${param.keyword}" />
			<button type="submit" class="btn is-grey">검색</button>
		</form>

		<table class="table">
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="30%">
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>강사 아이디</th>
					<th>강사명</th>
					<th>연락처</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="resultCnt" value="${pagination.totalRecordCount}" />
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr style="cursor: pointer;">
						<td class="txt-center">${(resultCnt) - (pagination.recordCountPerPage * (pagination.pageIndex-1))}</td>
						<td>${result.id}</td>
						<td>${result.name}</td>
						<td>
							<c:set var="phoneNumber" value="${result.phoneNumber}"/>
							<c:if test="${not empty phoneNumber}">
								${fn:substring(phoneNumber,0,3)}-${fn:substring(phoneNumber,3,7)}-${fn:substring(phoneNumber,7,11)}
							</c:if>
							<c:remove var="phoneNumber"/>
						</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt -1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="4" class="txt-center">조회결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<c:if test="${fn:length(resultList) != 0 }">
			<div class="pagination_wrap">
				<div class="pagination">
					<c:set var="pageIndex" value="${pagination.pageIndex}" />
					<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
					<c:url var="link" value="./memberListPop?keyword=${param.keyword}&searchSe=${param.searchSe}" />

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
	</div>

	<script>
	$(function() {
		$('tr').click(function() {
			if(this.rowIndex > 0) {
				var tr = $(this);
				var id = tr.children().eq(1).text();
				var name = tr.children().eq(2).text();

				window.opener.setSellerInfo(id, name);
				self.close();
			}
		});
	});
	</script>
</body>
</html>
