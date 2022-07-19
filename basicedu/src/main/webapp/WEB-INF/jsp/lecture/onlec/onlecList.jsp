<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/search.css">
<link rel="stylesheet" href="/resources/css/onlec_list.css">
<script src="/resources/js/search.js"></script>

	<div class="search_bar container">
		<form class="frm" name="frm" action="/onlineClass/list" method="post" id="searchFrm">
			<select class="search_condition" name="condition">
				<option value="lecturerName">강사명</option>
				<option value="className">클래스명</option>
			</select>
			<input type="text" name="keyword" value="" class="search_keword"
				required>
			<input type="submit" name="searchBtn" value="검색"
				class="search_btn">
		</form>
	</div>
	<c:if test="${lname != null }">
		<h4 style="margin-left: 10px; margin-top: 100px; color: #333;">
			&rtrif; <span style="color: red;">${lname}</span> 강사님이 진행 중인 온라인
			클래스입니다.
		</h4>
		<p style="margin-left: 28px; font-size: 14px; margin-top: 10px;">
			<a href="/onlineClass/list">[전체보기]</a>
		</p>
	</c:if>
	<c:if test="${searchInfo != null }">
		<h4 style="margin-left: 10px; margin-top: 100px; color: #333;">
			&rtrif; ${condition} '<span style="color: red;">${keyword}</span>'${searchInfo}
		</h4>
		<p style="margin-left: 28px; font-size: 14px; margin-top: 10px;">
			<a href="/onlineClass/list">[전체보기]</a>
		</p>
		<script>
			$(function() {

				var condition = '${condition}';
				if(condition == "강사명"){
					$('.search_condition option:eq(0)').prop("selected", true);
					}else{
						$('.search_condition option:eq(1)').prop("selected", true);
						}
				var keyword = '${keyword}';
				$('.search_keword').val(keyword);

			});
		</script>
	</c:if>
	<p></p>


	<ul class="onlec_list clearfix">
		<c:if test="${size != 0}">
			<c:forEach var="result" items="${onlecList}" varStatus="status">
			<li class="onlec_list_li" style="height: 450px;">
				<div class="onlec_list_box">
					<div class="onlec_img">
						<a href="detail?onlineLectureNo=${result.onlineLectureNo}"><img
							src="/upload/onlec/thumb/${result.imgFile}" alt="sample"></a>
					</div>
					<div class="onlec_cont">
						<a href="detail?onlineLectureNo=${result.onlineLectureNo}">
							<h3 class="onlec_title onlec_cont_com">${result.onlineLectureName}</h3>
						</a>
						<h4 class="onlec_lecturer onlec_cont_com">${result.name}</h4>
						<h4 class="onlec_price onlec_cont_com">
							<fmt:formatNumber type="number" maxFractionDigits="3"
								value="${result.price}" />
							원
						</h4>
					</div>

				</div>
			</li>
		</c:forEach>
		</c:if>

		<c:if test="${size == 0}">
			<li><h3 style="width: 100%; text-align: center; margin-top: 100px; color: red;">등록된 결과가 없습니다.</h3></li>
		</c:if>





	</ul>

	<c:if test="${fn:length(onlecList) != 0 }">
		<div class="pagination_wrap">
			<div class="pagination">
				<c:set var="pageIndex" value="${pagination.pageIndex}" />
				<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
				<c:url var="link" value="./list" />

				<c:if test="${pageIndex eq 1}">
					<a>이전</a>
				</c:if>
				<c:if test="${pageIndex ne 1}">
					<a href="${link}?pageIndex=${pageIndex-1}">이전</a>
				</c:if>
				<c:forEach var="num" begin="${pagination.firstPageNo}"
					end="${pagination.lastPageNo}">
					<c:choose>
						<c:when test="${pageIndex eq num}">
							<a class="active">${num}</a>
						</c:when>
						<c:otherwise>
							<a href="${link}?pageIndex=${num}">${num}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pageIndex eq totalPageCount}">
					<a>다음</a>
				</c:if>
				<c:if test="${pageIndex ne totalPageCount}">
					<a href="${link}?pageIndex=${pageIndex+1}">다음</a>
				</c:if>
			</div>
		</div>
	</c:if>


