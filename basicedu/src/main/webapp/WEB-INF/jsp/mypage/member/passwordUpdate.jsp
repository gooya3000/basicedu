<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<h2 class="h4h4" style="text-align: center;">비밀번호 재설정</h2>
		<br/><br/>
<div class="join_wrap">
	<form action="./passwordUpdateAction" id="form" name="form" method="POST">
		<table class="table write mt15">
			<tbody>
				<tr>
					<th style="width: 20%;">비밀번호</th>
					<td>
						<input type="password" id="password" name="password" value="" class="w60p">
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="passwordChk" name="passwordChk" value=""></td>
				</tr>
			</tbody>
		</table>
	</form>

	<div class="btnSet">
		<button type="button" class="btn is-blue" onclick="joinBtn();">수정</button>
	</div>
</div>

<script>
function joinBtn() {

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

	if (confirm("비밀번호를 수정 하시겠습니까?")) {
		$("#form").submit();
	}
}
</script>