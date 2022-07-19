<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<link rel="stylesheet"
	href="/resources/css/offline_admin_findId.css">

		<h3 class="h4h4">아이디 검색하기</h3>
		<br/><br/>
<div class="join_wrap">

<form id="form" name="form" action="./findIdAction" method="post" enctype="multipart/form-data">

		<table class="table write mt15">
			<tbody>
				<tr style="width: 30%;">
					<th>아이디</th>
					<td>
						<select class="search_condition" name="searchCondition" id="searchCondition">
							<option value="lecId">강사아이디</option>
							<option value="lecName">강사명</option>
						</select> <input type="text" name="search_keyword" value="" class="search_keword" id="search_keyword">
						<button type="button" class="btn is-blue" id="check" onclick="checkForm()">검색</button>

					</td>
				</tr>
			</tbody>
		</table>
</form>

	<script>
		function checkForm(){
			if ($("#search_keyword").val() == '') {
				alert('입력창을 입력해주세요');
				$("#search_keyword").focus();
				return false;
			}

			$("#form").submit();
		}
	</script>
</div>

	<table class="table write mt15">
		<tr>
			<th>강사명</th>
			<th>강사아이디</th>
			<th>회원 구분</th>
			<th></th>
		</tr>
		<c:forEach var="list" items="${list}" varStatus="status">
			<tr>
				<td>${list.name}</td>
				<td>${list.id}</td>
				<td>
				<c:if test="${list.memberCategory eq 1}"> 일반 회원</c:if>
				<c:if test="${list.memberCategory eq 2}"> 강사 회원</c:if>
				</td>
				<td><button type="button" value="${list.id}" title="${list.memberCategory}" class="selectId">선택</button></td>
			</tr>
		</c:forEach>
	</table>

	<script>
	$(".selectId").on("click", function(){
			var id = $(this).attr('value');
			var category = $(this).attr('title');
			if(category == 2){
				$(opener.document).find("#id").val(id);
				window.close();
			}else{
					alert('일반회원은 강의를 생성 할 수 없습니다.');
				}

	 });

	</script>
