<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mylect_online_list.css">

<ul class="lecture_ch clearfix">
	<a href="#">
		<li class="lecture_ch_li mg_on">오프라인</li>
	</a>
	<a href="/mypage/online/myOnlineClass"><li class="lecture_ch_li">온라인</li></a>
</ul>

<div class="onlec_mg_list">
	<h3 class="title">&rtrif;&nbsp;수강 중인 오프라인 클래스</h3>
	<c:if test="${size == 0}">
		<p style="width: 100%; text-align: center; line-height: 1.5;">수강
			중인 강의가 없습니다.</p>
	</c:if>

	<c:forEach var="list" items="${list}" varStatus="status">

		<div class="myClass_list">

			<table class="onlec_myClass">
				<tr>
					<td rowspan="2" class="imgBox">
						<div class="onlec_img_box">
							<img src="/upload/offline/thumb/${list.offline_lecture_img}"
								alt="">
						</div>
					</td>
					<td colspan="2"><h4 class="lecName">
					  <c:choose>
				        <c:when test="${fn:length(list.offline_lecture_name) gt 25}">
				       		<c:out value="${fn:substring(list.offline_lecture_name, 0, 25)}">...
				        	</c:out>
				        </c:when>
				        <c:otherwise>
				        	<c:out value="${list.offline_lecture_name}">
				        </c:out></c:otherwise>
					</c:choose>

					</h4></td>
					<c:if test="${list.offline_lecture_schedule<=curTime}">
						<td rowspan="2" class="classBox"><a href="/offlineClass/detail?offline_lecture_NO=${list.offline_lecture_NO}"><div class="goClass">후기 쓰러 가기</div></a></td>
					</c:if>
					<c:if test="${list.offline_lecture_schedule>curTime}">
						<td rowspan="2" class="classBox"><a href="/offlineClass/detail?offline_lecture_NO=${list.offline_lecture_NO}"><div class="goClass">강의 보기</div></a></td>
					</c:if>

				</tr>
				<tr>
					<c:if test="${list.offline_lecture_schedule>curTime}">
						<c:if test="${list.offline_lecture_applyperiodend > curTime}">
							<td class="myclass_content">신청서
								상태&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td class="alignRight myclass_content">
							<c:if test="${list.application_status eq 0}">
								대기중
							</c:if>
							<c:if test="${list.application_status eq 1}">
								승인
							</c:if>
							<c:if test="${list.application_status eq 2}">
								거절됨
							</c:if></td>
						</c:if>

					</c:if>


					<c:if test="${list.offline_lecture_schedule<=curTime}">
						<td class="myclass_content"><h3>클래스
							완료</h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td class="alignRight myclass_content">

						</td>
					</c:if>
				</tr>
			</table>
			<div class="btns">
			<c:if test="${list.offline_lecture_schedule>curTime}">
				<c:if test="${list.offline_lecture_applyperiodend > curTime}">
					<a href="/offlineClass/offlec_myApplication?application_no=${list.application_no}&offline_lecture_NO=${list.offline_lecture_NO}" onclick="window.open(this.href,'_blanck','width=600, height=700');return false"><input type="button" name="" value="신청서 보기" class="btns_btn review_regi" style="margin-left: 25%;"></a>
				</c:if>
				<c:if test="${list.offline_lecture_applyperiodend < curTime}">
					<input type="button" name="" value="신청기간 만료" class="btns_btn review_regi" style="margin-left: 25%;">
				</c:if>
			</c:if>
			</div>
		</div>
	</c:forEach>
</div>


<c:if test="${fn:length(list) != 0 }">
			<div class="pagination_wrap">
				<div class="pagination">
					<c:set var="pageIndex" value="${pagination.pageIndex}" />
					<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
					<c:url var="link" value="./myOnlineClass" />

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