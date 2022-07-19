<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">

<c:set var="id" value="${sessionScope.userSession.id}" />
<form id="form" action="/order" method="post">
	<input type="hidden" name="productNo" value="${result.productNo}">
	<input type="hidden" name="productPrice" value="${result.price}">

	<div class="store_wrap">
		<table class="table">
			<colgroup>
				<col width="70%" />
				<col width="30%" />
			</colgroup>
			<tbody>
				<tr>
					<th><img alt="상품 이미지" src="/upload/product/${result.imgFileName}" width="800px"></th>
					<td>
						<table>
							<tr>
								<td colspan="2" class="productName">${result.productName}</td>
							</tr>
							<tr>
								<th>판매가</th>
								<td><span class="price"><fmt:formatNumber value="${result.price}" pattern="#,###" /></span> 원</td>
							</tr>
							<tr>
								<th>판매자</th>
								<td>${result.sellerName}</td>
							</tr>
							<sec:authorize access="!hasRole('ROLE_ADMIN')">
								<tr>
									<th>수량</th>
									<td>
										<button type="button" id="minusBtn" class="itemNumBtn">-</button>
										<input type="text" name="quantity" value="1" class="itemNumText" maxlength="2">
										<button type="button" id="plusBtn" class="itemNumBtn">+</button>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="btnSet">
											<button type="button" id="shoppingBasketBtn" class="btn is-blue">장바구니</button>
											<button type="button" id="orderBtn" class="btn is-blue mt5 mb10">구매하기</button>
										</div>
									</td>
								</tr>
							</sec:authorize>
						</table>
					</td>
				</tr>
				<tr>
					<th>
						<h5 class="txt-left">▶  상품정보</h5>
						<img alt="상품 상세 이미지" src="/upload/product/${result.contentsFileName}" width="800px">
					</th>
					<td></td>
				</tr>
				<tr>
					<th colspan="2">
						<h5 class="txt-left">▶  상품리뷰</h5>
						<table class="table review_table">
							<c:forEach var="review" items="${reviewList}">
								<tr>
									<th>
										${review.id} | <fmt:formatDate value="${review.registerDate}" pattern="yyyy-MM-dd HH:mm" />
										<c:if test="${id eq review.id}">
											<button type="button" class="btn ml15 modalBtn" data-toggle="modal" data-target="#modal" data-reviewno="${review.reviewNo}" data-contents="${review.contents}">수정</button>
											<button type="button" class="btn" onclick="delReview(${review.reviewNo})">삭제</button>
										</c:if>
									</th>
								</tr>
								<tr>
									<td>
										<% pageContext.setAttribute("br", "\n"); %>
										${fn:replace(review.contents, br, '<br>')}
									</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(reviewList) eq 0}">
								<tr>
									<td>등록된 상품리뷰가 없습니다.</td>
								</tr>
							</c:if>
						</table>
					</th>
				</tr>
				<c:if test="${not empty resultList}">
					<tr>
						<th colspan="2">
							<h5 class="txt-left">▶  판매자의 상품</h5>
							<ul>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<li>
										<a href="./view?productNo=${result.productNo}">
											<div class="thumbImg"><img alt="상품 이미지" src="/upload/product/thumb/${result.imgFileName}" height="188" width="250"></div>
											<div class="info">
												<span>${result.productName}</span>
												<span><b class="price"><fmt:formatNumber value="${result.price}" pattern="#,###" /></b>원</span>
											</div>
										</a>
									</li>
								</c:forEach>
							</ul>
						</th>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</form>

<!-- review modal -->
<div id="modal" role="dialog" tabindex="-1" class="modal fade">
	<div role="document" class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">상품 구매후기</h4>
			</div>
			<div class="modal-body">
				<form id="modalForm" method="post">
					<input type="hidden" id="reviewNo" name="reviewNo" value="">
					<table class="table write">
						<tr>
							<th>상품명</th>
							<td>${result.productName}</td>
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
				<button type="button" id="saveReview" class="btn is-blue">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
	var productQuantity = Number('${result.quantity}');
	var maxQuantity = (productQuantity < 20 ? productQuantity : 20);

	$("input[name='quantity']").change(function() {
		var quantity = this.value;
		if(quantity > maxQuantity) {
			alert('상품은 최대 '+ maxQuantity +'개 까지 구매 가능합니다.');
			quantity = maxQuantity;
		} else if(quantity < 1) {
			quantity = 1;
		}
		this.value = quantity;
	});
	$("#minusBtn").click(function() {
		var quantity = Number($("input[name='quantity']").val())-1;
		if(quantity < 1) {
			quantity = 1;
		}
		$("input[name='quantity']").val(quantity);
	});
	$("#plusBtn").click(function() {
		var quantity = Number($("input[name='quantity']").val())+1;
		if(quantity > maxQuantity) {
			alert('상품은 최대 '+ maxQuantity +'개 까지 구매 가능합니다.');
			quantity = maxQuantity;
		}
		$("input[name='quantity']").val(quantity);
	});

	$("#shoppingBasketBtn").click(function() {
		<sec:authorize access="isAnonymous()">
			if(confirm("로그인 후 이용 가능합니다. \n로그인 페이지로 이동하시겠습니까?")) {
				location.href = '/member/login';
			}
		</sec:authorize>
		<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_TEACHER')">
			if('${result.quantity}' == '0') {
				alert('매진된 상품은 장바구니에 담을 수 없습니다.');
				return false;
			}

			if(confirm("해당 상품을 장바구니에 담으시겠습니까?")) {
				$.post('/shoppingBasket/addToShoppingBasket', {'productNo':'${result.productNo}','quantity':$("input[name='quantity']").val(),'productPrice':'${result.price}'}, function(result) {
					if(result == "success") {
						alert('해당 상품이 장바구니에 담겼습니다.');
					} else {
						alert('오류가 발생했습니다.');
					}
				});
			}
		</sec:authorize>
	});

	$("#orderBtn").click(function() {
		<sec:authorize access="isAnonymous()">
			if(confirm("로그인 후 이용 가능합니다. \n로그인 페이지로 이동하시겠습니까?")) {
				location.href = '/member/login';
			}
		</sec:authorize>

		<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_TEACHER')">
			if('${result.quantity}' == '0') {
				alert('매진된 상품은 구매하실 수 없습니다.');
				return false;
			}

			if(confirm("해당 상품을 구매하시겠습니까?")) {
				$("#form").submit();
			}
		</sec:authorize>
	});

	$(".modalBtn").click(function() {
		$("#textAreaContents").val($(this).data('contents'));
        $("#reviewNo").val($(this).data('reviewno'));
	});

	$("#saveReview").click(function() {
		if($("#textAreaContents").val().length == 0) {
			alert('구매후기를 입력해주세요');
			$("#textAreaContents").focus();
			return false;
		}

		if (confirm("구매후기를 수정 하시겠습니까?")) {
			$.post('/mypage/review/writeAction', $("#modalForm").serialize(), function(result) {
				if(result == "success") {
					alert('구매후기가 수정되었습니다.');
					location.reload();
				} else {
					alert('오류가 발생했습니다.');
				}
			});
		}
	});
});

function delReview(reviewNo) {
	if (confirm("구매후기를 삭제 하시겠습니까?")) {
		$.post('/mypage/review/delete', {"reviewNo":reviewNo}, function(result) {
			if(result == "success") {
				alert('구매후기가 삭제되었습니다.');
				location.reload();
			} else {
				alert('오류가 발생했습니다.');
			}
		});
	}
}
</script>