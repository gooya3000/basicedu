<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_offline_regi.css">




<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<div class="onlec_mg_list">
	<c:if test="${result.offline_lecture_img eq null}">
		<form id="form" name="form" action="./offlineUpdate?offline_lecture_NO=${result.offline_lecture_NO}" method="post">
	</c:if>
	<c:if test="${result.offline_lecture_img ne null}">
		<form id="form" name="form" action="./offlineUpdate1?offline_lecture_NO=${result.offline_lecture_NO}" method="post">
	</c:if>
		<!--구분-->

		<h4 class="h4h4">클래스 정보 입력</h4>
		<table class="onlec_mg_list_table">
			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스명</th>
				<td class="onlec_mg_list_td"><input type="text"
					 value="${result.offline_lecture_name}" name="offline_lecture_name" id="offline_lecture_name" class="regi_input">
					 <input type="hidden" id="lecture_NO" value="${result.offline_lecture_NO}">
					 </td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스 소개</th>
				<td class="onlec_mg_list_td"><textarea
						name="offline_lecture_introduce" id="offline_lecture_introduce" rows="8" cols="80"
						class="regi_textarea">${result.offline_lecture_introduce}</textarea></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">대표사진</th>
				<td class="onlec_mg_list_td">
					<c:if test="${result.offline_lecture_img eq null}">
						<input type="file" id="offline_lecture_img" name="offlineImg">
					</c:if>

					<c:if test="${result.offline_lecture_img ne null}">
						<input type="text" id="offline_lecture_img1" name="offlineImg1" value="${result.offline_lecture_img}" readonly="readonly" style="width: 50%;">
						<button type="button" style="margin-left: 10px;" onclick="imgBtn();" id="changeImg">이미지 바꾸기</button>
					</c:if>
				</td>
				<td>
			</tr>

			<tr>
					<th class="onlec_mg_list_th">클래스 주소</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_address" id="offline_lecture_address" value="${result.offline_lecture_address}" id="offline_lecture_address" class="regi_input" readonly="readonly" >
					<button type="button" class="juso_btn" style="width: 300px;margin-top: 20px; border-radius: 5px; background-color: rgb(26, 255, 255); font-weight: 600; border: 2px solid black; " onClick="goPopup()">주소 검색</button>
				</td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 최소인원</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_min" id="offline_lecture_min" value="${result.offline_lecture_min}" class="regi_input" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 최대인원</th>
				<td class="onlec_mg_list_td"><input type="text"
					name="offline_lecture_max" id="offline_lecture_max" value="${result.offline_lecture_max}" class="regi_input" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">등록기간 시작일</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_applyperiodstart" value="${result.offline_lecture_applyperiodstart}" class="regi_input"
					id="offline_lecture_applyperiodstart"></td>
			</tr>


			<tr>
				<th class="onlec_mg_list_th">등록기간 종료일</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_applyperiodend" value="${result.offline_lecture_applyperiodend}" class="regi_input"
					id="offline_lecture_applyperiodend"></td>

			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 일정</th>
				<td class="onlec_mg_list_td"><input type="date"
					name="offline_lecture_schedule" id="offline_lecture_schedule" value="${result.offline_lecture_schedule}" class="regi_input"></td>
			</tr>

			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
		</table>
</form>
	<div class="submit_box">
	<button type="button" class="onlec_submit_btn" onclick="checkForm();">수정하기</button>
		<input type="button" class="onlec_submit_btn" id="delete" value="삭제하기">
		<a href="./offlineList" class="onlec_submit_btn"><span>취소</span></a>

	</div>

<script>

		function imgBtn(){
			$("#changeImg").html('되돌리기');
			$("#changeImg").attr('class','btn is-red');
			$("#changeImg").attr('onclick', 'imgBtn2();');
			$("#offline_lecture_img1").prop("type", "file");
			$("#offline_lecture_img1").prop("accept", ".gif, .png, .jpg, .jpeg");
			$("#offline_lecture_img1").prop("name", "offlineImg");
			$("#offline_lecture_img1").attr("id","offline_lecture_img");
			$("#form").attr('action', './offlineUpdate?offline_lecture_NO=${result.offline_lecture_NO}');
			$("#form").attr('enctype', 'multipart/form-data');

		}

		function imgBtn2(){
			$("#changeImg").html('이지미 바꾸기');
			$("#changeImg").attr('class','btn is-blue');
			$("#changeImg").attr('onclick', 'imgBtn();');
			$("#offline_lecture_img").prop("type", "text");
			$("#offline_lecture_img1").prop("accept", "");
			$("#offline_lecture_img").prop("name", "offlineImg1");
			$("#offline_lecture_img").attr("id","offline_lecture_img1");
			$("#form").attr('action', './offlineUpdate1?offline_lecture_NO=${result.offline_lecture_NO}');
			$("#form").attr('enctype', '');
		}

		function checkForm() {
			if ($("#offline_lecture_name").val() == '') {
				alert('클래스명을 입력해주세요');
				$("#offline_lecture_name").focus();
				return false;
			}

			if ($("#offline_lecture_introduce").val() == '') {
				alert('클래스소개을 입력해주세요');
				$("#offline_lecture_introduce").focus();
				return false;
			}

			if ($("#offline_lecture_img").val() == '') {
				alert('파일을 선택해주세요');
				$("#offline_lecture_img").focus();
				return false;
			}

			if ($("#offline_lecture_img").val() != '' && $("#offline_lecture_img") > 0) {
				var imgFileExt = $("#offline_lecture_img").val().split('.').pop().toLowerCase();
				if($.inArray(imgFileExt, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
					$("#offline_lecture_img").focus();
					return false;
				}
			}

			if ($("#offline_lecture_address").val() == '') {
				alert('클래스 주소를 입력해주세요');
				$("#offline_lecture_address").focus();
				return false;
			}

			if ($("#offline_lecture_min").val() == '') {
				alert('클래스 최소인원을 확인해주세요');
				$("#offline_lecture_min").focus();
				return false;
			}

			if ($("#offline_lecture_max").val() == '') {
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
		$("#delete").click(function(){
			var result = confirm("정말 삭제하시겠습니까?");
			if(result){
				location.href="./offlineDelete?offline_lecture_NO=${result.offline_lecture_NO}";
			}
			});


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

		});

		// 등록기간 조건 1
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

		// 등록기간 조건 2
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