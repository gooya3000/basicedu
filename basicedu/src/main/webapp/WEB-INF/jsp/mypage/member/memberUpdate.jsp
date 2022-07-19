<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="join_wrap">
	<h1 id="join">회원정보 수정</h1>
	<c:if test="${member.memberCategory eq 2 && member.lecturerImg eq null}">
		<form id="form" name="form" action="./updateAction" method="post" enctype="multipart/form-data">
	</c:if>

	<c:if test="${member.memberCategory eq 2 && member.lecturerImg ne null}">
		<form id="form" name="form" action="./updateAction1" method="post">
	</c:if>

	<c:if test="${member.memberCategory eq 1}">
		<form id="form" name="form" action="./updateAction1" method="post">
	</c:if>
		<table class="table write mt15">
			<tbody style="width: 70%;">

				<tr>
					<th>이름</th>
					<td><input type="text" id="name" name="name" value="${member.name}" maxlength="5" oninput="maxLengthCheck2(this)"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><a href="./passwordUpdate" class="btn is-red ml5" onclick="window.open(this.href,'_blanck','width=830, height=300');return false">비밀번호 변경</a></td>
				</tr>

				<tr>
					<th>연락처</th>
					<td><input type="text" id="phoneNumber" name="phoneNumber" maxlength="11" oninput="maxLengthCheck(this)"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="${member.phoneNumber}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="address" name="address" value="${member.address}" style="width: 300px;" readonly="readonly">
						<button type="button" id="idCheckBtn" class="btn" onClick="goPopup()">주소찾기</button>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" id="email" name="email" value="${member.email}">
					</td>
				</tr>

				<c:if test="${member.memberCategory eq 2}">
					<tr>
						<th>강사사진</th>
						<td>
							<c:if test="${member.lecturerImg eq null}">
								<input type="file" id="img" name="img">
							</c:if>

							<c:if test="${member.lecturerImg ne null}">
								<input type="text" id="img1" name="img" value="${member.lecturerImg}" readonly="readonly">
								<button type="button" class="btn is-blue" onclick="imgBtn();" id="changeImg">이미지 바꾸기</button>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>강사소개</th>
						<td>
							<textarea rows="10" cols="40" id="lecturerInfo" name="lecturerInfo"style="border: 1px solid black;" maxlength="1000" oninput="maxLengthCheck(this)">${member.lecturerInfo}</textarea>


						</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</form>
	<div class="btnSet">
		<button type="button" class="btn is-blue" onclick="joinBtn();">수정</button>
		<a href="./memberCertify" class="btn is-grey ml5" onclick="return confirm('수정을 취소하시겠습니까?');">취소</a>
	</div>
</div>
<div style="float: right; font-size: 7px; ">
	<a href="./deleteMember" onclick="return confirm('회원 탈퇴를 하시겠습니까?');">회원탈퇴하기</a>
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
function imgBtn(){
	$("#changeImg").html('되돌리기');
	$("#changeImg").attr('class','btn is-red');
	$("#changeImg").attr('onclick', 'imgBtn2();');
	$("#img1").prop("type", "file");
	$("#img1").attr("id","img");
	$("#form").attr('action', './updateAction');
	$("#form").attr('enctype', 'multipart/form-data');

}

function imgBtn2(){
	$("#changeImg").html('이지미 바꾸기');
	$("#changeImg").attr('class','btn is-blue');
	$("#changeImg").attr('onclick', 'imgBtn();');
	$("#img").prop("type", "text");
	$("#img").attr("id","img1");
	$("#form").attr('action', './updateAction1');
	$("#form").attr('enctype', '');
}

function joinBtn() {

	if($("#name").val() == '') {
		alert('이름을 입력해주세요');
		$("#name").focus();
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


	if ($("#img").val() == '') {
		alert('파일을 선택해주세요');
		$("#offlineImg").focus();
		return false;
	}

	if($("#img").val() != '' && $("#img") > 0) {
		var imgFileExt = $("#img").val().split('.').pop().toLowerCase();
		if($.inArray(imgFileExt, ['gif','png','jpg','jpeg']) == -1) {
			alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
			$("#img").focus();
			return false;
		}
	}


	if ($("#lecturerInfo").val() == '') {
		alert('소개를 입력해주세요');
		$("#offlineImg").focus();
		return false;
	}

	if (confirm("수정하시겠습니까?")) {
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