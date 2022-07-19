<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3 class="h4h4">비밀번호 재확인</h3>
<br/><br/>
<h5 style="text-align: center;">개인 정보 법규강화에 따라 회원정보 수정을 위해서는 불편하시더라도 비밀번호를 다시 입력해주셔야합니다.</h5>
<div class="join_wrap">
	<table class="table write mt15">
		<tbody>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" id="id" name="id" value="${id}" class="w60p" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="password" name="password" value=""></td>
			</tr>
		</tbody>
	</table>

	<div class="btnSet">
		<button type="button" class="btn is-blue" id="check">확인</button>
	</div>
</div>

<script>
$(function() {
	$("#check").click(function() {
		formCheck();
	});

	$("#password").keypress(function(e) {
		if(e.keyCode === 13) {
			formCheck();
		}
	});
});

function formCheck() {
	var password = $("#password").val();
	var id = $("#id").val();
	if(password == '') {
		alert('비밀번호를 입력해주세요');
		$("#password").focus();
		return false;
	}

	$.post('./passwordCheck', {'password':password , 'id':id}, function(result) {
		if(result == "success") {
			location.href="./memberUpdate";
		} else {
			alert('비밀번호를 확인해주세요.');
			$("#password").focus();
		}
	});
}
</script>