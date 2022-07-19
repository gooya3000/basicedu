<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 상품관리</h3>

<h5>▶  주문내역</h5>
<table class="table">
	<tbody>
		<tr>
			<th>상품명</th>
			<td>${result.productName}</td>
		</tr>
		<tr>
			<th>구매수량</th>
			<td>${result.quantity}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${result.id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${result.name}</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>
				<c:set var="phoneNumber" value="${result.phoneNumber}"/>
				<c:if test="${not empty phoneNumber}">
					${fn:substring(phoneNumber,0,3)}-${fn:substring(phoneNumber,3,7)}-${fn:substring(phoneNumber,7,11)}
				</c:if>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${result.email}</td>
		</tr>
		<tr>
			<th>배송지</th>
			<td>${result.address}</td>
		</tr>
		<tr>
			<th>결제금액</th>
			<td><fmt:formatNumber value="${result.quantity*result.productPrice}" pattern="#,###" />원</td>
		</tr>
		<tr>
			<th>주문일시</th>
			<td><fmt:formatDate value="${result.paymentDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>주문상태</th>
			<td>
				<c:choose>
					<c:when test="${result.orderStatus eq '1'}">결제완료</c:when>
					<c:when test="${result.orderStatus eq '2'}">발송완료</c:when>
					<c:when test="${result.orderStatus eq '3'}">구매확정</c:when>
				</c:choose>
			</td>
		</tr>
		<c:if test="${not empty result.contents}">
			<tr>
				<th>구매후기</th>
				<td>
					<% pageContext.setAttribute("br", "\n"); %>
					${fn:replace(result.contents, br, '<br>')}
				</td>
			</tr>
		</c:if>
	</tbody>
</table>

<div class="btnSet">
	<a href="./view?productNo=${result.productNo}" class="btn is-grey ml5">취소</a>
	<c:if test="${result.orderStatus eq '1'}">
		<button type="button" id="shippingProcessingBtn" class="btn width120 is-blue">발송완료 처리</button>
	</c:if>
</div>

<script>
$(function() {
	$("#shippingProcessingBtn").click(function() {
		if(confirm("발송완료 처리 하시겠습니까?")) {
			$.post('/order/modifyOrderStatus', {'orderNo':'${result.orderNo}','orderStatus':'2'}, function(result) {
				if(result == "success") {
					alert('발송완료 처리가 되었습니다.');
					location.reload();
				} else {
					alert('오류가 발생했습니다.');
				}
			});
		}
	});
});
</script>