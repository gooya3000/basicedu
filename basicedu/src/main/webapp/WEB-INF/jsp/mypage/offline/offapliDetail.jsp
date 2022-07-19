<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_offapli_detail.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<div class="onlec_mg_list">

		<!--구분-->

		<h4 class="h4h4">신청서</h4>
		<table class="onlec_mg_list_table">
			<tr>
				<th class="onlec_mg_list_th">신청자 이름</th>
				<td class="onlec_mg_list_td"><p class="regi_input">${list.application_name}</p></td>
			</tr>

			<tr>
			<th class="onlec_mg_list_th">신청자 ID</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${list.application_id}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">신청 인원</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${list.application_number}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">신청자 연락처</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${list.application_phone}
				</p></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">신청자 소개</th>
				<td class="onlec_mg_list_td"><p
						class="regi_textarea">${list.application_introduce}</p></td>
			</tr>


			<tr>
				<th class="onlec_mg_list_th">신청일</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${list.application_regdate}
				</p></td>
			</tr>

		</table>

		<div class="submit_box">
			<input type="button" name="" value="승 인 하 기" class="onlec_submit_btn" id="ok">
			<input type="button" name="" value="거 절 하 기" class="onlec_submit_btn" id="reject">
		</div>

</div>


<script type="text/javascript">

	$("#ok").click(function(){
	var result = confirm("승인 하시겠습니까??");
	if(result){
		location.href="./offaplicationOk?application_no=${list.application_no}";
	}
	});

	$("#reject").click(function(){
		var result = confirm("거절 하시겠습니까??");
		if(result){
			location.href="./offaplicationReject?application_no=${list.application_no}";
		}
		});


</script>