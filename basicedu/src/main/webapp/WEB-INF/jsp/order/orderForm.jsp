<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">

<form id="form" action="/order/payment" method="post">
	<input type="hidden" name="orderNoStr" value="${orderNoStr}">
	<input type="hidden" name="paymentNo" value="">
	<input type="hidden" name="pgTid" value="">

	<h3>| 주문결제</h3>

	<h5>▶  주문상품</h5>
	<table class="table order_table">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
		<tbody>
			<c:set var="totalPrice" value="0"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}"></td>
					<td>
						${result.productName} (${result.quantity}개)
						<div>
							<c:set var="price" value="${result.quantity * result.price}" />
							<fmt:formatNumber value="${price}" pattern="#,###" />원
						</div>
					</td>
				</tr>
				<c:set var="totalPrice" value="${totalPrice+price}" />
			</c:forEach>
		</tbody>
	</table>

	<h5 class="mt20">▶  배송정보</h5>
	<table class="table write">
		<tbody>
			<tr>
				<th><span class="required">*</span>받으시는 분</th>
				<td><input type="text" id="name" name="name" value="${user.name}" maxlength="20"></td>
			</tr>
			<tr>
				<th><span class="required">*</span>휴대폰번호</th>
				<td><input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" onkeyup="this.value=numberCheck(this.value);" placeholder="숫자만 입력해주세요" maxlength="11"></td>
			</tr>
			<tr>
				<th><span class="required">*</span>이메일</th>
				<td><input type="text" id="email" name="email" value="${user.email}" maxlength="40"></td>
			</tr>
			<tr>
				<th><span class="required">*</span>배송주소</th>
				<td>
					<input type="text" id="address" name="address" value="${user.address}" readonly="readonly" class="w70p mr5">
					<button type="button" class="btn" onClick="addressPop()">주소검색</button>
				</td>
			</tr>
		</tbody>
	</table>

	<h5 class="mt20">▶ 결제금액</h5>
	<table class="table write">
		<tbody>
			<tr>
				<th>총 결제금액</th>
				<td><fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td><input type="text" id="point" name="point" value="0" class="w10p" onkeyup="this.value=numberCheck(this.value);">원 (사용가능 <fmt:formatNumber value="${user.point}" pattern="#,###" />P)</td>
			</tr>
			<tr>
				<th>최종 결제금액 </th>
				<td><input type="hidden" name="creditCard" value="" ><span id="priceSpan"><fmt:formatNumber value="${totalPrice}" pattern="#,###" /></span>원</td>
			</tr>
		</tbody>
	</table>

	<h5>▶ 결제방식</h5>
	<button type="button" class="kakaopay_btn">카카오페이</button>
	<div class="btnSet">
		<a href="/shoppingBasket/list" class="btn is-grey ml5">취소</a>
		<button type="button" id="orderBtn" class="btn is-blue">결제</button>
	</div>
</form>

<script>
$(function() {
	$("#orderBtn").click(function() {
		if($("#name").val() == '') {
			alert('받으시는 분 이름을 입력해주세요');
			$("#name").focus();
			return false;
		}

		if($("#phoneNumber").val() == '') {
			alert('휴대폰번호를 입력해주세요');
			$("#phoneNumber").focus();
			return false;
		}

		if($("#email").val() == '') {
			alert('이메일 주소를 입력해주세요');
			$("#email").focus();
			return false;
		}

		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(!regExp.test($("#email").val())) {
			alert('이메일 형식이 올바르지 않습니다.');
			$("#email").focus();
			return false;
		}

		if($("#address").val() == '') {
			alert('배송 주소를 입력해주세요');
			$("#address").focus();
			return false;
		}

		if(confirm('상품을 결제하시겠습니까?')) {
			$.post('/shoppingBasket/productStatusCheck', {}, function(result) {
				if(result == "success") {
					var productNum = '${fn:length(resultList)}';
					var productName = '${resultList[0].productName}';
					var totalPrice = Number('${totalPrice}')-Number($("#point").val());
					var now = new Date();
					var merchantUid = now.getFullYear() + lpad(now.getMonth()+1,2) + lpad(now.getDate(),2) + lpad(now.getHours(),2) + lpad(now.getMinutes(),2) + lpad(now.getSeconds(),2);

					var IMP = window.IMP;
					IMP.init('imp96885242'); // 가맹점 식별 코드
					IMP.request_pay({
						pg: 'kakaopay'
						, pay_method: 'card'
						, merchant_uid : merchantUid
						, name: productName + (productNum > 1 ? ' 외 ' + (productNum-1) : '')
						, amount : totalPrice
						, buyer_name: $("#name").val()
						, buyer_tel: $("#phoneNumber").val()
						, buyer_email: $("#email").val()
						, buyer_addr: $("#address").val()
					}, function (rsp) {
						console.log(rsp);
						if (rsp.success) {
							$("input[name='creditCard']").val(rsp.paid_amount); // 결제금액
							$("input[name='paymentNo']").val(rsp.merchant_uid); // 상점 거래ID
							$("input[name='pgTid']").val(rsp.pg_tid); // 결제번호
							$("#form").submit();
					    } else {
						   alert(rsp.error_msg)
					    }
					});
				} else if(result == "soldOut") {
					alert('매진된 상품은 결제하실 수 없습니다.');
				} else if(result == "update") {
					alert('정보가 변경된 상품은 결제하실 수 없습니다.');
				} else {
					alert('오류가 발생했습니다.');
				}
			});
		}
	});

	var pointValue = Number('${user.point}');
	$("#point").change(function() {
		var point = Number($(this).val());
		if(pointValue == 0) {
			alert('사용가능한 포인트가 없습니다.');
			point = 0;
		} else {
			if(pointValue < point) {
				alert(pointValue + 'P 사용 가능합니다.');
				point = pointValue;
			}
		}
		$("#point").val(point);
		$("#priceSpan").text(setComma(Number('${totalPrice}')-point));
	});
});

function numberCheck(value) {
	if (isNaN(value)) {
		return "";
	} else return value;
}

function lpad(str, len) {
	str = String(str);
	while(str.length < len) {
		str = '0' + str;
	}
	return str;
}

function setComma(value) {
    return String(value).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function addressPop() {
	var left = (document.body.offsetWidth/2) - 300;
	window.open("/popup/jusoPopup.jsp", "addressPop", "width=570, height=420, left="+left+", top=200");
}

function jusoCallBack(roadFullAddr) {
	$("#address").val(roadFullAddr);
}
</script>
