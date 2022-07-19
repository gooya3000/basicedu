<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/search.css">
<link rel="stylesheet" href="/resources/css/onlec_apply.css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="/resources/js/payway.js"></script>

	<form id="frm" action="/onlineClass/applyPro" method="post">
		<input type="hidden" id="name" name="name" value="${user.name }"/>
		<input type="hidden" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber }"/>
		<input type="hidden" id="email" name="email" value="${user.email }"/>
		<input type="hidden" id="address" name="address" value="${user.address }"/>
		<input type="hidden" name="paymentNo" value="">
		<input type="hidden" name="pgTid" value="">

        <h3 id="title">&rtrif;&nbsp;&nbsp;온라인 강의 수강 신청</h3>
        <!--구분-->
        <h3 class="mini_title">주문정보</h3>
        <h3 class="onlec_apply_name">${lectureInfo.onlineLectureName}
        	<input type="hidden" name="onlineLectureNo" value="${lectureInfo.onlineLectureNo}"/>
        </h3>
        <table class="onlec_apply_table">
          <tr><td class="onlec_apply_td tdth">강의수</td><td class="onlec_apply_td tdtd">${videoQty}강</td></tr>
          <tr><td class="onlec_apply_td tdth">환급포인트</td><td class="onlec_apply_td tdtd">
          <fmt:parseNumber var="test" value="${lectureInfo.price*0.1}" integerOnly="true"/>
          <fmt:formatNumber type="number" maxFractionDigits="3" value="${test}"/>P</td></tr>


        </table>

        <!--구분-->
        <h3 class="mini_title">결제금액</h3>
        <table class="onlec_apply_table">
          <tr><td class="onlec_apply_td tdth">수강료</td><td class="onlec_apply_td tdtd">
          <fmt:formatNumber type="number" maxFractionDigits="3" value="${lectureInfo.price}"/> 원
          <input type="hidden" value="${lectureInfo.price}" id="lecPrice"/></td></tr>
          <tr><td class="onlec_apply_td tdth pointtd">포인트 사용(내 포인트: <span class="red_c">
          <fmt:formatNumber type="number" maxFractionDigits="3" value="${point}"/>P</span>)
          <input type="hidden" value="${point }" id="nowPoint"/></td>
            <td class="onlec_apply_td tdtd">
            <input type=number value="0" class="point_input" id="usePoint" name="point"/>
            <input type=hidden value="0" id="realUsePoint"/>
            <input type="button" value="사용" class="point_btn" id="pBtn"/></td></tr>
        </table>
        <h3 class="onlec_apply_name onlec_apply_name_2">최종 결제금액: <span class="red_c" id="finalPrice"></span>
        	<input type="hidden" id="totalPrice" name="totalPrice" value="${lectureInfo.price}"/>
        	<input type="hidden" name="creditCard" value="" >
        </h3>

        <!--구분-->
        <h3 class="mini_title">결제수단</h3>
        <h3 class="onlec_apply_name onlec_apply_name_3">카카오페이</h3>

        <!--구분-->
        <div class="btns">
          <p class="btns_mg"><input type="button" name="" value="결 제 하 기" class="onlec_apply_submit" id="payNow"></p>
          <p>
          	<input type="button" name="" value="취 소" class="onlec_apply_cancle" id="noApply">
          	<input type="hidden" value="/onlineClass/detail?onlineLectureNo=${lectureInfo.onlineLectureNo }" class="link" />

          </p>

        </div>

      </form>

<script>
	$(function() {

		$('.point_input').keydown(function(e) {
		    if (e.keyCode == 13) {
		        $('#pBtn').click();
		        return false;
		    }
		});

		$('#noApply').click(function(){

			var con = confirm("신청을 취소하시겠습니까?");
			var link = $(this).next('.link').val();

			if(con == true){
				location.href=link;
			}else{
				console.log("취소");
				return}

		});



		$("#payNow").click(function() {

			if($('.onlec_apply_name_3').hasClass('choice')){

				var productNum = '${lectureInfo.onlineLectureNo}';
				var productName = '${lectureInfo.onlineLectureName}';
				var totalPrice = Number($("#totalPrice").val())-Number($("#realUsePoint").val());

				var name = $("#name").val();
				var phoneNumber = $("#phoneNumber").val();
				var email = $("#email").val();
				var address = $("#address").val();

				console.log(name);
				console.log(phoneNumber);
				console.log(email);
				console.log(address);

				var now = new Date();
				var merchantUid = now.getFullYear() + lpad(now.getMonth()+1,2) + lpad(now.getDate(),2) + lpad(now.getHours(),2) + lpad(now.getMinutes(),2) + lpad(now.getSeconds(),2);

				var IMP = window.IMP;
				IMP.init('imp96885242'); // 가맹점 식별 코드
				IMP.request_pay({
					pg: 'kakaopay'
					, pay_method: 'card'
					, merchant_uid : merchantUid
					, name: productName
					, amount : totalPrice
					, buyer_name: name
					, buyer_tel: phoneNumber
					, buyer_email: email
					, buyer_addr: address

				}, function (rsp) {
					console.log(rsp);
					if (rsp.success) {
						$("input[name='creditCard']").val(rsp.paid_amount); // 결제금액
						$("input[name='paymentNo']").val(rsp.merchant_uid); // 상점 거래ID
						$("input[name='pgTid']").val(rsp.pg_tid); // 결제번호
				        $('#frm').submit();
				    } else {
					   alert(rsp.error_msg)
				    }
				});

				}else{
					alert("결제 수단을 선택해주세요");
					}



		});
	});

	function lpad(str, len) {
		str = String(str);
		while(str.length < len) {
			str = '0' + str;
		}
		return str;
	}
</script>