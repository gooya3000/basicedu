<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_online_list.css">
<ul class="lecture_ch clearfix">
	<a href="#">
		<li class="lecture_ch_li mg_on">오프라인</li>
	</a>
	<a href="/mypage/online/onlecmgList"><li class="lecture_ch_li">온라인</li></a>
</ul>

<div class="onlec_mg_list">
	<a href="offlineJoin"><input type="button" name=""
		value="클 래 스 등 록" class="onlec_regi_btn"></a>
	<h4 class="h4h4">진행 중인 오프라인 클래스</h4>
	<table class="onlec_mg_list_table">
		<tr>
			<th class="onlec_mg_list_th">번호</th>
			<th class="onlec_mg_list_th">클래스명</th>
			<th class="onlec_mg_list_th">클래스장소</th>
			<th class="onlec_mg_list_th">클래스 날짜</th>
		</tr>
		<c:if test="${size != 0}">
			<c:forEach var="list" items="${list}" varStatus="status">
				<tr>
					<c:if test="${list.offline_lecture_schedule < curTime}">
						<td class="onlec_mg_list_td"><a href="./offlineDelete?offline_lecture_NO=${list.offline_lecture_NO}" onclick="return confirm('클래스을 삭제하시겠습니까?');">기간 만료</a></td>
					</c:if>
					<c:if test="${list.offline_lecture_schedule >= curTime}">
						<td class="onlec_mg_list_td"><a href="./offlineSelect?offline_lecture_NO=${list.offline_lecture_NO}">${status.index+1}</a></td>
					</c:if>
					<td class="onlec_mg_list_td">
						   <c:choose>
					        <c:when test="${fn:length(list.offline_lecture_name) gt 18}">
					       		<c:out value="${fn:substring(list.offline_lecture_name, 0, 18)}">...
					        	</c:out>
					        </c:when>
					        <c:otherwise>
					        	<c:out value="${list.offline_lecture_name}">
					        </c:out></c:otherwise>
						</c:choose>

					</td>
					<td class="onlec_mg_list_td">${list.offline_lecture_address}</td>
					<td class="onlec_mg_list_td">${list.offline_lecture_schedule}</td>
				</tr>
			</c:forEach>
		</c:if>
		 <c:if test="${size==0 }">
		       <tr><td colspan="4" class="onlec_mg_list_td">등록된 강의가 없습니다.</td></tr>
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