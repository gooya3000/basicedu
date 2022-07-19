<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 구매내역 조회</h3>

<h5>▶  상품정보</h5>
<table class="table">
	<colgroup>
		<col width="20%">
		<col width="25%">
		<col width="55%">
	</colgroup>
	<tbody>
		<tr>
			<td rowspan="3"><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}"></td>
			<th>상품명</th>
			<td>${result.productName}</td>
		</tr>
		<tr>
			<th>구매수량</th>
			<td>${result.quantity}</td>
		</tr>
		<tr>
			<th>상품가격</th>
			<td><fmt:formatNumber value="${result.productPrice}" pattern="#,###" />원</td>
		</tr>
	</tbody>
</table>

<h5 class="mt20">▶  배송정보</h5>
<table class="table">
	<colgroup>
		<col width="31%">
		<col width="69%">
	</colgroup>
	<tbody>
		<tr>
			<th>받는 사람</th>
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
			<th>주소</th>
			<td>${result.address}</td>
		</tr>
	</tbody>
</table>

<h5 class="mt20">▶  결제정보</h5>
<table class="table purchase_table">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
	<tbody>
		<tr>
			<th colspan="2" class="price">총 결제금액 <fmt:formatNumber value="${result.creditCard + result.point}" pattern="#,###" />원</th>
		</tr>
		<tr>
			<th>신용카드</th>
			<td><fmt:formatNumber value="${result.creditCard}" pattern="#,###" />원</td>
		</tr>
		<tr>
			<th>포인트</th>
			<td><fmt:formatNumber value="${result.point}" pattern="#,###" />원</td>
		</tr>
		<tr>
			<th rowspan="2">결제정보</th>
			<td>카카오페이 (결제번호 : ${result.pgTid})</td>
		</tr>
		<tr>
			<td><fmt:formatDate value="${result.paymentDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
	</tbody>
</table>

<div class="btnSet">
	<a href="./list" class="btn is-grey">목록</a>
</div>