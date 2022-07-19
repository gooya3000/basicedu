<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<div class="login_wrap">
	<h1 class="mb20">로그인</h1>

	<form action="./loginAction" id="form" name="form" method="POST">
		<div>
			<span class="pr13">아이디</span>
			<input type="text" id="id" name="id" title="아이디"/>
		</div>
		<div class="mt10">
			<span>비밀번호</span>
			<input type="password" autocomplete="off" id="password" name="password" title="비밀번호" />
		</div>
		<div class="btnSet">
			<button type="button" class="btn is-blue" onclick="loginBtn();">로그인</button>
			<!-- <button type="button" class="btn is-yello mt5">카카오로 로그인</button> -->
		</div>
	</form>
</div>

<script>
$(function() {
	var error = ${empty param.error ? false : param.error};
	if(error) {
		alert('아이디 또는 비밀번호가 틀립니다.');
	}

	$("#form").keypress(function(e) {
		if(e.keyCode === 13) {
			loginBtn();
		}
	});
});

function loginBtn() {
	if($("#id").val() == '') {
		alert('아이디를 입력해주세요');
		$("#id").focus();
		return false;
	}

	if($("#password").val() == '') {
		alert('비밀번호를 입력해주세요');
		$("#password").focus();
		return false;
	}

	$("#form").submit();
}
</script>