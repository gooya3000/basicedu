<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">

<h3>| 구매내역 조회</h3>

<div class="btnSet">
	<button type="button" id="delBtn" class="btn small90 is-red mb10">구매내역삭제</button>
</div>

<form id="form" method="post">
	<span class="comment">발송완료 11일 이후 자동 구매확정처리가 됩니다.</span>
	<table class="table">
		<colgroup>
			<col width="4%">
			<col width="20%">
			<col width="36%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>상품 이미지</th>
				<th>상품명</th>
				<th>구매일자</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="orderNoArr" value="${result.orderNo}"></td>
					<td>
						<c:if test="${not empty result.imgFileName}">
							<a href="./view?orderNo=${result.orderNo}"><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}"></a>
						</c:if>
					</td>
					<td><a href="./view?orderNo=${result.orderNo}">${result.productName}</a></td>
					<td><fmt:formatDate value="${result.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
					<td class="txt-center">
						<c:choose>
							<c:when test="${result.orderStatus eq '1'}">결제완료</c:when>
							<c:when test="${result.orderStatus eq '2'}">
								발송완료
								<button type="button" class="btn is-blue" onclick="fnPurchaseConfirm('${result.orderNo}')">구매확정</button>
							</c:when>
							<c:when test="${result.orderStatus eq '3'}">
								구매확정
								<c:if test="${empty result.registerDate}">
									<button type="button" class="btn is-blue modalBtn" data-toggle="modal" data-target="#modal" data-orderno="${result.orderNo}" data-productname="${result.productName}">구매후기 작성</button>
								</c:if>
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) eq 0}">
				<tr>
					<td colspan="5" class="txt-center">등록한 상품이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form>

<c:if test="${fn:length(resultList) != 0 }">
	<div class="pagination_wrap">
		<div class="pagination">
			<c:set var="pageIndex" value="${pagination.pageIndex}" />
			<c:set var="totalPageCount" value="${pagination.totalPageCount}" />

			<c:if test="${pageIndex eq 1}">
				<a>이전</a>
			</c:if>
			<c:if test="${pageIndex ne 1}">
				<a href="./list?pageIndex=${pageIndex-1}">이전</a>
			</c:if>
			<c:forEach var="num" begin="${pagination.firstPageNo}" end="${pagination.lastPageNo}">
				<c:choose>
					<c:when test="${pageIndex eq num}">
						<a class="active">${num}</a>
					</c:when>
					<c:otherwise>
						<a href="./list?pageIndex=${num}">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pageIndex eq totalPageCount}">
				<a>다음</a>
			</c:if>
			<c:if test="${pageIndex ne totalPageCount}">
				<a href="./list?pageIndex=${pageIndex+1}">다음</a>
			</c:if>
		</div>
	</div>
</c:if>


<!-- review modal -->
<div id="modal" role="dialog" tabindex="-1" class="modal fade">
	<div role="document" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">상품 구매후기</h4>
			</div>
			<div class="modal-body">
				<form id="modalForm" method="post">
					<input type="hidden" name="keySection" value="P">
					<input type="hidden" id="keyNo" name="keyNo" value="">
					<table class="table write">
						<tr>
							<th>상품명</th>
							<td><span id="productNameSpan"></span></td>
						</tr>
						<tr>
							<th>구매후기</th>
							<td><textarea id="textAreaContents" name="contents" rows="5" class="w100p mt5"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn is-grey ml5" data-dismiss="modal">닫기</button>
				<button type="button" id="saveReview" class="btn is-blue">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
	$("#checkAll").click(function() {
		if($(this).is(":checked")) {
			$("input:checkbox[name='orderNoArr']").prop("checked", true);
		} else {
			$("input:checkbox[name='orderNoArr']").prop("checked", false);
		}
	});

	$("#delBtn").click(function() {
		if ($("input:checkbox[name='orderNoArr']:checked").length == 0) {
			alert('삭제할 구매내역을 선택해주세요.');
		} else {
			if(confirm('선택한 구매내역을 삭제하시겠습니까?')) {
				$.post('./delete', $("#form").serialize(), function(result) {
					if(result == "success") {
						alert('구매내역이 삭제되었습니다.');
						location.reload();
					} else {
						alert('오류가 발생했습니다.');
					}
				});
			}
		}
	});

	$(".modalBtn").click(function () {
		$("#textAreaContents").val('');
        $("#keyNo").val($(this).data('orderno'));
        $("#productNameSpan").text($(this).data('productname'));
    });

	$("#saveReview").click(function() {
		if($("#textAreaContents").val().length == 0) {
			alert('구매후기를 입력해주세요');
			$("#textAreaContents").focus();
			return false;
		}

		if (confirm("구매후기를 등록 하시겠습니까?")) {
			$.post('/mypage/review/writeAction', $("#modalForm").serialize(), function(result) {
				if(result == "success") {
					alert('구매후기가 등록되었습니다.');
					location.reload();
				} else {
					alert('오류가 발생했습니다.');
				}
			});
		}
	});
});

function fnPurchaseConfirm(orderNo) {
	if(confirm("구매확정 처리 하시겠습니까?")) {
		$.post('/order/modifyOrderStatus', {'orderNo':orderNo,'orderStatus':'3'}, function(result) {
			if(result == "success") {
				alert('구매확정 처리가 되었습니다.');
				location.reload();
			} else {
				alert('오류가 발생했습니다.');
			}
		});
	}
}
</script>
