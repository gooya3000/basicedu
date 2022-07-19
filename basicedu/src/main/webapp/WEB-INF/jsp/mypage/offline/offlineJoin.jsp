<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_offline_regi.css">


<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<ul class="lecture_ch clearfix">
	<a href="#">
		<li class="lecture_ch_li mg_on">오프라인</li>
	</a>
	<a href="/mypage/online/onlecmgList"><li class="lecture_ch_li">온라인</li></a>
</ul>

<div class="onlec_mg_list">
	<form id="form" name="form" action="./offlineJoinadd" method="post" enctype="multipart/form-data">
		<!--구분-->

		<h4 class="h4h4">클래스 정보 입력</h4>
		<table class="onlec_mg_list_table">
			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스명</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_name" id="offline_lecture_name" value=""
					class="regi_input"></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스 소개</th>
				<td class="onlec_mg_list_td"><textarea
						name="offline_lecture_introduce" rows="8" cols="80"
						class="regi_textarea" id="offline_lecture_introduce"></textarea></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">대표사진</th>
				<td class="onlec_mg_list_td"><input type="file"
					name="offlineImg" id="offlineImg"> <!--<p class="upload_info">&check; 클래스를 표현할 수 있는 한 장의 이미지를 업로드해주세요.</p>-->
				</td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 주소</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_address" id="offline_lecture_address"
					class="regi_input" readonly="readonly">
					<button type="button" class="juso_btn"
						style="width: 300px; margin-top: 20px; border-radius: 5px; background-color: rgb(26, 255, 255); font-weight: 600; border: 2px solid black;"
						onClick="goPopup()">주소 검색</button></td>

			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 최소인원</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_min" value="" class="regi_input"
					id="offline_lecture_min"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
			</tr>


			<tr>
				<th class="onlec_mg_list_th">클래스 최대인원</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_max" class="regi_input"
					id="offline_lecture_max"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">등록기간 시작일</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_applyperiodstart" value=""
					id="offline_lecture_applyperiodstart" class="regi_input"></td>
			</tr>


			<tr>
				<th class="onlec_mg_list_th">등록기간 종료일</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_applyperiodend"
					id="offline_lecture_applyperiodend" value="" class="regi_input"></td>

			</tr>


			<tr>
				<th class="onlec_mg_list_th">클래스 일정</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_schedule" id="offline_lecture_schedule"
					value="" class="regi_input"></td>
			</tr>

			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
		</table>

<input type="hidden" value="${curTime}" id="curTime">

	</form>
	<div class="submit_box">
		<button type="button" class="onlec_submit_btn" onclick="checkForm();">등록</button>
		<a href="./list" class="onlec_submit_btn_cancel"><span>취소</span></a>
	</div>
	<script>
		function checkForm() {
			if ($("#offline_lecture_name").val().trim() == '') {
				alert('클래스명을 입력해주세요');
				$("#offline_lecture_name").val('');
				$("#offline_lecture_name").focus();
				return false;
			}

			if ($("#offline_lecture_introduce").val().trim() == '') {
				alert('클래스소개을 입력해주세요');
				$("#offline_lecture_introduce").focus();
				return false;
			}

			if ($("#offlineImg").val() == '') {
				alert('파일을 선택해주세요');
				$("#offlineImg").focus();
				return false;
			}

			if($("#offlineImg").val() != '') {
				var imgFileExt = $("#offlineImg").val().split('.').pop().toLowerCase();
				if($.inArray(imgFileExt, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
					$("#offlineImg").focus();
					return false;
				}
			}

			if ($("#offline_lecture_address").val() == '') {
				alert('클래스 주소를 입력해주세요');
				$("#offline_lecture_address").focus();
				return false;
			}

			if ($("#offline_lecture_min").val().trim() == '') {
				alert('클래스 최소인원을 확인해주세요');
				$("#offline_lecture_min").focus();
				return false;
			}

			if ($("#offline_lecture_max").val().trim() == '') {
				alert('클래스 최대인원을 확인해주세요');
				$("#offline_lecture_max").focus();
				return false;
			}

			if ($("#offline_lecture_applyperiodstart").val() == '') {
				alert('등록기간 시작일을 입력해주세요');
				$("#offline_lecture_applyperiodstart").focus();
				return false;
			}

			if ($("#offline_lecture_applyperiodend").val() == '') {
				alert('등록기간 종료일을 입력해주세요');
				$("#offline_lecture_applyperiodend").focus();
				return false;
			}

			if ($("#offline_lecture_schedule").val() == '') {
				alert('클래스 일정을 입력해주세요');

				$("#offline_lecture_schedule").focus();
				return false;
			}
			$("#form").submit();
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
			document.form.offline_lecture_address.value = roadFullAddr;

		}

		//수강 최대인원 조건
		$("#offline_lecture_max").blur(function() {
			var max = Number($("#offline_lecture_max").val());
			var min = Number($("#offline_lecture_min").val());

			if (max > 100) {
				alert('최대 수강인원은 100명입니다.');
				$("#offline_lecture_max").val('');
			}

			if (max < min) {
				alert('수강 최대인원은 최소인원보다 작을 수 없습니다.');
				$("#offline_lecture_max").val('');

			}
		});

		//수강 최소 인원 조건
		$("#offline_lecture_min").blur(function() {
			var max = Number($("#offline_lecture_max").val());
			var min = Number($("#offline_lecture_min").val());

			if (min < 10 && $("#offline_lecture_min").val() != '') {
				alert('최소 수강인원은 10명입니다.');
				$("#offline_lecture_min").val('');
			}
			if (min > 100) {
				alert('최대 수강인원은 100명입니다.');
				$("#offline_lecture_min").val('');
			}

		});

		// 등록기간 조건 1
		$("#offline_lecture_applyperiodstart").blur(
				function() {
					var start = $("#curTime").val();
					var end = $("#offline_lecture_applyperiodstart").val();
					var startArray = start.split('-');
					var endArray = end.split('-');

					if (Number(startArray[0]) >= Number(endArray[0])
							&& Number(startArray[1]) >= Number(endArray[1])
							&& Number(startArray[2]) > Number(endArray[2])) {
						$("#offline_lecture_applyperiodstart").val('');
						alert('신청 시작일은 현재날짜보다 이후 이어야 합니다.');
					}

				});

		// 등록기간 조건 2
		$("#offline_lecture_applyperiodend").blur(
				function() {
					var start = $("#offline_lecture_applyperiodstart").val();
					var end = $("#offline_lecture_applyperiodend").val();
					var startArray = start.split('-');
					var endArray = end.split('-');

					if (Number(startArray[0]) >= Number(endArray[0])
							&& Number(startArray[1]) >= Number(endArray[1])
							&& Number(startArray[2]) > Number(endArray[2])) {
						$("#offline_lecture_applyperiodend").val('');
						alert('신청 종료일은 시작일보다 이후 이어야 합니다.');
					}

				});

		// 등록기간 조건 3
		$("#offline_lecture_schedule")
				.blur(
						function() {
							var end = $("#offline_lecture_applyperiodend")
									.val();
							var schedule = $("#offline_lecture_schedule").val();
							var endArray = end.split('-');
							var scheduleArray = schedule.split('-');

							if (Number(scheduleArray[0]) <= Number(endArray[0])
									&& Number(scheduleArray[1]) <= Number(endArray[1])
									&& Number(scheduleArray[2]) <= Number(endArray[2])) {
								$("#offline_lecture_schedule").val('');
								alert('클래스 일정은 등록기간 종료일 1일이상 이후이여야 합니다.');
							}

						});
	</script>

</div>