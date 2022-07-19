<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 장바구니</h3>

<div class="btnSet">
	<button type="button" id="delBtn" class="btn small is-red mb10">상품삭제</button>
</div>

<form id="form" method="post">
	<table class="table mt10">
		<colgroup>
			<col width="3%">
			<col width="20%">
			<col width="44%">
			<col width="13%">
			<col width="18%">
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>상품 이미지</th>
				<th>상품명</th>
				<th>수량</th>
				<th>총 금액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="txt-center">
						<input type="checkbox" name="shoppingBasketNoList" value="${result.shoppingBasketNo}">
						<input type="hidden" id="productStatus${result.shoppingBasketNo}" value="${result.productStatus}" >
					</td>
					<td>
						<c:if test="${not empty result.imgFileName}">
							<a href="/store/view?productNo=${result.productNo}"><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}"></a>
						</c:if>
					</td>
					<td><a href="/store/view?productNo=${result.productNo}">${result.productName}</a></td>
					<td class="txt-center">${result.quantity}</td>
					<td class="txt-center">
						<c:choose>
							<c:when test="${result.productStatus eq 'soldOut'}"><span class="comment">매진된 상품입니다.</span></c:when>
							<c:when test="${result.productStatus eq 'update'}"><span class="comment">상품정보가 변경되었습니다.</span></c:when>
							<c:otherwise><fmt:formatNumber value="${result.quantity * result.price}" pattern="#,###" /></c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="5" class="txt-center">장바구니에 담긴 상품이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form>

<div class="btnSet">
	<button type="button" id="orderBtn" class="btn is-blue">주문</button>
	<span class="shoppingBasket_price mr10">결제금액 <b id="totalPrice">0</b>원</span>
</div>

<script>
$(function() {
	$("#checkAll").click(function() {
		if($(this).is(":checked")) {
			$("input:checkbox[name='shoppingBasketNoList']").prop("checked", true);
		} else {
			$("input:checkbox[name='shoppingBasketNoList']").prop("checked", false);
		}
		setTotalPrice();
	});

	$("input:checkbox[name='shoppingBasketNoList']").click(function() {
		setTotalPrice();
	});

	$("#delBtn").click(function() {
		if ($("input:checkbox[name='shoppingBasketNoList']:checked").length == 0) {
			alert('장바구니에서 삭제할 상품을 선택해주세요.');
		} else {
			if(confirm('선택한 상품을 장바구니에서 삭제하시겠습니까?')) {
				$.post('./delete', $("#form").serialize(), function(result) {
					if(result == "success") {
						alert('상품이 장바구니에서 삭제되었습니다.');
						location.reload();
					} else {
						alert('오류가 발생했습니다.');
					}
				});
			}
		}
	});

	$("#orderBtn").click(function() {
		var flag = true;
		var msg = "";

		if ($("input:checkbox[name='shoppingBasketNoList']:checked").length == 0) {
			alert('주문할 상품을 선택해주세요.');
		} else {
			$.each($("input:checkbox[name='shoppingBasketNoList']:checked"), function() {
				var shoppingBasketNo = $(this).val();
				var productStatus = $("#productStatus"+shoppingBasketNo).val();

				if(!flag) return false;
				if(productStatus == "soldOut") {
					msg = "매진된 상품은 주문하실 수 없습니다.";
					flag = false;
				} else if(productStatus == "update") {
					msg = "정보가 변경된 상품은 주문하실 수 없습니다.";
					flag = false;
				}
			});
			if(!flag) {
				alert(msg);
				return false;
			}
			if(confirm('선택한 상품을 주문하시겠습니까?')) {
				$("form").attr("action", "/order");
				$("form").submit();
			}
		}
	});
});

function setTotalPrice() {
	var totalPrice = 0;
	$.each($("input:checkbox[name='shoppingBasketNoList']:checked"), function() {
		var shoppingBasketNo = $(this).val();
		if($("#productStatus"+shoppingBasketNo).val() == "") {
			var tr = $(this).parent().parent();
			var price = tr.children().eq(4).text().replace(/,/gi, "");
			totalPrice += Number(price);
		}
	});
	$("#totalPrice").text(setComma(totalPrice));
}

function setComma(value){
    return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>
