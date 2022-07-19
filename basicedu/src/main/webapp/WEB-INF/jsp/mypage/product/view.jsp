<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 상품관리</h3>

<h5>▶  상품정보</h5>
<table class="table">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
	<tbody>
		<tr>
			<th>상품명</th>
			<td>${result.productName}</td>
		</tr>
		<tr>
			<th>상품 이미지</th>
			<td>
				<c:if test="${not empty result.imgFileName}">
					<div class="imgDiv">
						<img alt="상품 이미지" src="/upload/product/${result.imgFileName}">
					</div>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>상세 이미지</th>
			<td>
				<c:if test="${not empty result.contentsFileName}">
					<div class="imgDiv">
						<img alt="상품내용 파일명" src="/upload/product/${result.contentsFileName}">
					</div>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>상품 수량</th>
			<td>${result.quantity}</td>
		</tr>
		<tr>
			<th>상품 금액</th>
			<td><fmt:formatNumber value="${result.price}" pattern="#,###" /> 원</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><fmt:formatDate value="${result.registerDate}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
	</tbody>
</table>

<div class="btnSet">
	<a href="./list" class="btn is-grey ml5"><span>취소</span></a>
	<a href="./write?productNo=${result.productNo}" class="btn is-blue ml5"><span>수정</span></a>
	<a href="./delete?productNo=${result.productNo}" class="btn is-red" onclick="return confirm('상품을 삭제하시겠습니까?');"><span>삭제</span></a>
</div>

<h5 class="mt70">▶  판매내역</h5>
<span>총 매출 <b class="price"><fmt:formatNumber value="${totalSales}" pattern="#,###" /></b>원</span>
<div id="salesHistoryDiv"></div>

<script>
$(function() {
	getSalesHistoryList(1);
});

function getSalesHistoryList(pageIndex) {
	$.post('./getSalesHistoryList', {'pageIndex' : pageIndex, 'keyNo' : '${result.productNo}'}, function(result) {
		$("#salesHistoryDiv").html(result);
	}, 'html');
}
</script>