<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_offline_list.css">
<ul class="lecture_ch clearfix">
	<a href="#">
		<li class="lecture_ch_li mg_on">오프라인</li>
	</a>

</ul>

<div class="onlec_mg_list">
	<h4 class="h4h4">신청서 리스트</h4>
	<h5>수강인원 :  ${nowPeople}/${maxPeople} </h5>
	<!-- 회원구분 후 강사면 강의중인 클래스, 진행중인 클래스 리스트
		 일반 회원이면 진행중인 클래스 리스트 -->
	<table class="onlec_mg_list_table">
		<tr>
			<th class="onlec_mg_list_th">신청인</th>
			<th class="onlec_mg_list_th">회원아이디</th>
			<th class="onlec_mg_list_th">신청인원</th>
			<th class="onlec_mg_list_th">신청일</th>
			<th class="onlec_mg_list_th">신청상태</th>

		</tr>
		<c:if test="${size !=0 }">
			 <c:forEach var="list" items="${list}" varStatus="status">
				<tr>
					<td class="onlec_mg_list_td"><a href="#">${list.application_name}</a></td>
					<td class="onlec_mg_list_td">${list.application_id}</td>
					<td class="onlec_mg_list_td">${list.application_number}</td>
					<td class="onlec_mg_list_td">${list.application_regdate}</td>

					<c:if test="${list.application_status eq 0 }">
						<td class="onlec_mg_list_td">
							<a href="./offapli_detail?application_no=${list.application_no}" onclick="window.open(this.href,'_blanck','width=600, height=700');return false"><button type="button" class="offlec_submit_btn">신청서 보기</button></a>
						</td>
					</c:if>

					<c:if test="${list.application_status eq 1}">
						<td class="onlec_mg_list_td">
							승인됨
						</td>
					</c:if>

					<c:if test="${list.application_status eq 2}">
						<td class="onlec_mg_list_td">
							거절됨
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</c:if>

		 <c:if test="${size==0 }">
		     <tr><td colspan="5" class="onlec_mg_list_td">신청된 신청서가 없습니다. </td></tr>
		 </c:if>


	</table>
</div>

  		<c:if test="${fn:length(list) != 0 }">
			<div class="pagination_wrap">
				<div class="pagination">
					<c:set var="pageIndex" value="${pagination.pageIndex}" />
					<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
					<c:url var="link" value="./onlecmgList" />

					<c:if test="${pageIndex eq 1}">
						<a>이전</a>
					</c:if>
					<c:if test="${pageIndex ne 1}">
						<a href="${link}&pageIndex=${pageIndex-1}">이전</a>
					</c:if>
					<c:forEach var="num" begin="${pagination.firstPageNo}" end="${pagination.lastPageNo}">
						<c:choose>
							<c:when test="${pageIndex eq num}">
								<a class="active">${num}</a>
							</c:when>
							<c:otherwise>
								<a href="${link}&pageIndex=${num}">${num}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageIndex eq totalPageCount}">
						<a>다음</a>
					</c:if>
					<c:if test="${pageIndex ne totalPageCount}">
						<a href="${link}&pageIndex=${pageIndex+1}">다음</a>
					</c:if>
				</div>
			</div>
		</c:if>
