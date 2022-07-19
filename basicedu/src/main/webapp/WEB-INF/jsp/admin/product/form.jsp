<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 상품관리</h3>

<c:set var="productNo" value="${empty result.productNo ? 0 : result.productNo}" />

<form id="form" name="form" action="./writeAction" method="post" enctype="multipart/form-data">
	<input type="hidden" name="productNo" value="${productNo}">

	<table class="table write mt20">
		<tbody>
			<tr>
				<th><span class="required">*</span>상품명</th>
				<td><input type="text" id="productName" name="productName" value="${result.productName}" class="w100p" maxlength="60"></td>
			</tr>
			<c:if test="${empty result.sellerId}">
				<tr>
					<th><span class="required">*</span>강사명</th>
					<td>
						<span id="sellerName"></span>
						<input type="hidden" id="sellerId" name="sellerId" value="${result.sellerId}">
						<button type="button" class="btn" onclick="memberListPop();">강사검색</button>
					</td>
				</tr>
			</c:if>
			<tr>
				<th><span class="required">*</span>상품 이미지</th>
				<td>
					<input type="file" id="imgFile" name="imgFile" value=""/>
					<c:if test="${not empty result.imgFileName}">
						<div id="imgFileDiv">${result.imgFileName}</div>
					</c:if>
				</td>
			</tr>
			<tr>
				<th><span class="required">*</span>상세 이미지</th>
				<td>
					<input type="file" id="contentsFile" name="contentsFile" value=""/>
					<c:if test="${not empty result.contentsFileName}">
						<div id="contentsFileDiv">${result.contentsFileName}</div>
					</c:if>
				</td>
			</tr>
			<tr>
				<th><span class="required">*</span>상품 수량</th>
				<td><input type="text" id="quantity" name="quantity" value="${result.quantity}" class="w10p" onkeyup="this.value=numberCheck(this.value);" maxlength="8"></td>
			</tr>
			<tr>
				<th><span class="required">*</span>상품 금액</th>
				<td><input type="text" id="price" name="price" value="${result.price}" class="w10p mr5" onkeyup="this.value=numberCheck(this.value);" maxlength="8"> 원</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="btnSet">
	<a href="./list" class="btn is-grey ml5"><span>취소</span></a>
	<button type="button" class="btn is-blue" onclick="checkForm();">${productNo eq 0 ? '등록' : '수정'}</button>
</div>

<script>
function numberCheck(value) {
	if (isNaN(value)) {
		return "";
	} else return value;
}

function checkForm() {
	if($("#productName").val().trim() == '') {
		alert('상품명을 입력해주세요');
		$("#productName").focus();
		return false;
	}

	if(${empty result.sellerId}) {
		if($("#sellerId").val() == '') {
			alert('강사를 선택해주세요');
			return false;
		}
	}

	if(${empty result.imgFileName}) {
		if($("#imgFile").val() == '') {
			alert('상품 이미지를 선택해주세요');
			$("#imgFile").focus();
			return false;
		}
	}
	if($("#imgFile").val() != '') {
		var imgFileExt = $("#imgFile").val().split('.').pop().toLowerCase();
		if($.inArray(imgFileExt, ['gif','png','jpg','jpeg']) == -1) {
			alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
			$("#imgFile").focus();
			return false;
		}
	}

	if(${empty result.contentsFileName}) {
		if($("#contentsFile").val() == '') {
			alert('상세 이미지를 선택해주세요');
			$("#contentsFile").focus();
			return false;
		}
	}
	if($("#contentsFile").val() != '') {
		var contentsFileExt = $("#contentsFile").val().split('.').pop().toLowerCase();
		if($.inArray(contentsFileExt, ['gif','png','jpg','jpeg']) == -1) {
			alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
			$("#contentsFile").focus();
			return false;
		}
	}

	if($("#quantity").val().trim() == '') {
		alert('상품 수량을 입력해주세요');
		$("#quantity").focus();
		return false;
	}

	if($("#price").val().trim() == '') {
		alert('상품 금액을 입력해주세요');
		$("#price").focus();
		return false;
	}

	if (confirm("${productNo eq 0 ? '등록' : '수정'} 하시겠습니까?")) {
		$("#form").submit();
	}
}

function memberListPop() {
	var left = (document.body.offsetWidth/2) - 400;
	window.open("/admin/member/memberListPop", "pop", "width=800, height=500, left="+left+", top=200");
}

function setSellerInfo(id, name) {
	$("#sellerName").text(name)
	$("#sellerId").val(id);
}
</script>