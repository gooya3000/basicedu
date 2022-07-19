<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<div class="join_wrap">
	<h1 id="join">카카오 회원가입</h1>
	<form action="./joinAction" id="form" name="form" method="POST">
		<table class="table write mt15">
			<tbody>
				<tr>
					<th>회원구분</th>
					<td>
						<label for="memberCategory1"><input type="radio" id="memberCategory1" name="memberCategory" value="1" checked="checked"><span>일반</span></label>
						<label for="memberCategory2" class="ml5"><input type="radio" id="memberCategory2" name="memberCategory" value="2"><span>강사</span></label>
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" id="id" name="id" value="${id}" class="w60p" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" id="name" name="name" value="${name}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="password" name="password" value=""></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="passwordChk" value=""></td>
				</tr>

				<tr>
					<th>연락처</th>
					<td><input type="text" id="phoneNumber" name="phoneNumber" value=""></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="address" name="address" value="" style="width: 300px;" readonly="readonly">
						<button type="button" id="idCheckBtn" class="btn" onClick="goPopup()">주소찾기</button>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" id="email" name="email" value="${id}" readonly="readonly">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="btnSet">
		<button type="button" class="btn is-blue" onclick="joinBtn();">가입</button>
		<a href="/" class="btn is-grey ml5" onclick="return confirm('회원가입을 취소하시겠습니까?');">취소</a>
	</div>
</div>

<script>
function numberCheck(value) {
	if (isNaN(value)) {
		return "";
	} else return value;
}

function joinBtn() {
	if($("#id").val() == '') {
		alert('아이디를 입력해주세요');
		$("#id").focus();
		return false;
	}

	if($("#name").val() == '') {
		alert('이름을 입력해주세요');
		$("#name").focus();
		return false;
	}

	if($("#password").val() == '') {
		alert('비밀번호를 입력해주세요');
		$("#password").focus();
		return false;
	}

	if($("#passwordChk").val() == '') {
		alert('비밀번호를 입력해주세요');
		$("#passwordChk").focus();
		return false;
	}

	if ($("#password").val() != $("#passwordChk").val()) {
         alert("비밀번호가 일치 하지 않습니다.");
         $("#passwordChk").focus();
         return false;
    }

	if($("#phoneNumber").val() == '') {
		alert('연락처를 입력해주세요');
		$("#phoneNumber").focus();
		return false;
	}

	if($("#address").val() == '') {
		alert('주소를 입력해주세요');
		$("#address").focus();
		return false;
	}

	if($("#email").val() == '') {
		alert('이메일 주소를 입력해주세요');
		$("#email").focus();
		return false;
	}

	if (confirm("회원가입 하시겠습니까?")) {
		$("#form").submit();
	}
}

</script>

<script type="text/javascript">
function goPopup() {
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("/popup/jusoPopup.jsp", "pop",
			"width=570,height=420, scrollbars=yes, resizable=yes");

	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes");
}
function jusoCallBack(roadFullAddr) {
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.form.address.value = roadFullAddr;

}

</script>