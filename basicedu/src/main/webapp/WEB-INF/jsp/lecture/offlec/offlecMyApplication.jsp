<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_offline_application.css">


<div class="onlec_mg_list">
	<form id="form" name="form" action="./myapplicationUpdate?application_no=${list.application_no}"
		method="post" enctype="multipart/form-data">
		<!--구분-->

		<h4 class="h4h4">클래스 신청서</h4>
		<table class="onlec_mg_list_table">
			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">신청자 이름</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="application_name" id="application_name" value="${list.application_name}" maxlength="5" oninput="maxLengthCheck2(this)"
					class="regi_input"></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">신청자 연락처</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="application_phone" id="application_phone" value="${list.application_phone}" maxlength="11" oninput="maxLengthCheck(this)"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
					class="regi_input"></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">자기소개</th>
				<td class="onlec_mg_list_td"><textarea
						name="application_introduce" rows="8" cols="80"
						class="regi_textarea" id="application_introduce" maxlength="1000" oninput="maxLengthCheck(this)">${list.application_introduce}</textarea></td>
			</tr>


			<!-- 최대인원수는 신청인원수와 신청자수를 더한거보다 작거나 같아야함 -->
			<tr>
				<th class="onlec_mg_list_th">신청 인원 수</th>
				<td class="onlec_mg_list_td">
					<button type="button" id="plus"
						style="width: 8%; font-size: 18px; border-radius: 10px; border: 1px solid black; margin-right: 10px;">+</button>
					<input type="text" name="application_number" value="${list.application_number}"
					class="regi_input_number" id="application_number_apli"
					readonly="readonly" style="text-align: center;">
					<button type="button" id="minus"
						style="width: 8%; font-size: 18px; border-radius: 10px; border: 1px solid black; margin-left: 10px;">-</button>
					<br />
				<br />
					<h5>수강인원 : ${nowPeople}/${maxPeople}</h5>
				</td>
			</tr>

			<input type="hidden" name="offline_lecture_NO" value="${list.offline_lecture_NO}" class="regi_input" id="offline_lecture_NO">
		</table>
	</form>
</div>
<div class="submit_box" style="padding-bottom: 10px;">
	<button type="button" class="onlec_submit_btn" onclick="checkForm();">수정하기</button>
	<input type="button" name="" value="삭 제 하 기" class="onlec_submit_btn" id="delete">
</div>

<script>
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }
  }

function maxLengthCheck2(object){
	 var str_space = /\s/;  // 공백체크
	    if(str_space.exec(object.value)) { //공백 체크
	        alert("해당 항목에는 공백을 사용할수 없습니다.\n\n공백은 자동적으로 제거 됩니다.");
	        object.focus();
	        object.value = object.value.replace(' ',''); // 공백제거
	        return false;
	    }
   if (object.value.length > object.maxLength){
     object.value = object.value.slice(0, object.maxLength);
   }
 }


function checkForm() {
	if ($("#application_name").val().trim() == '') {
		alert('신청자명을 입력해주세요');
		$("#offline_lecture_name").focus();
		return false;
	}
	if ($("#application_phone").val().trim() == '') {
		alert('신청자연락처를 입력해주세요');
		$("#offline_lecture_name").focus();
		return false;
	}
	if ($("textarea#application_introduce").val().trim() == '') {
		alert('자기소개를 입력해주세요');
		$("#offline_lecture_name").focus();
		return false;
	}

	var result = confirm("수정하시겠습니까?");
	if(result){
		$("#form").submit();
		}
}

</script>

<script type="text/javascript">
	$(function() {
		$('#minus').click(function(e) {
			e.preventDefault();
			var stat = $('#application_number_apli').val();
			var num = parseInt(stat, 10);
			num--;
			if (num <= 0) {
				alert('수강 최소인원은 1명입니다.');
				num = 1;
			}
			$('#application_number_apli').val(num);
		});
		$('#plus').click(function(e) {
			e.preventDefault();
			var stat = $('#application_number_apli').val();
			var num = parseInt(stat, 10);
			num++;

			if (num > ${maxPeople} - ${nowPeople}) {
				alert('최대 수강인원을 초과하였습니다.');
				num = ${maxPeople} - ${nowPeople};
			}
			$('#application_number_apli').val(num);
		});
	});

		$("#delete").click(function(){
			var result = confirm("삭제 하시겠습니까??");
			if(result){
				location.href="./myapplicationDelete?application_no=${list.application_no}";
		}
		});


</script>
