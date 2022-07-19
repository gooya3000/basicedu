<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/offline_admin_findId.css">

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

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