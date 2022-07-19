<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_list.css">
<script src="/resources/js/add_my_on2.js"></script>

	<div class="onlec_mg_list">

		<h3 class="title" style="width: 100%; border-bottom: 1px solid #000; padding-bottom: 10px;">&rtrif;&nbsp;회원 관리</h3>

		<div class="search_bar">
			<form class="frm" name="frm" action="/admin/member/list" method="post">
				<select class="search_condition" name="condition" style="margin-left: 420px;">
					<option value="lecturer" <c:if test="${condition eq 'lecturer'}">selected="selected"</c:if>>강사</option>
					<option value="normal" <c:if test="${condition eq 'normal'}">selected="selected"</c:if>>일반회원</option>
					<option value="all" <c:if test="${empty condition || condition eq 'all'}">selected="selected"</c:if>>전체</option>
				</select> <input type="text" name="keyword" value="${keyword}" class="search_keword" placeholder="아이디 또는 이름으로 검색하세요."
					required> <input type="submit" name="searchBtn" value="검색"
					class="search_btn" >
			</form>
			<script>
			$(function() {

				/* var condition = '${condition}';
				if(condition == "all"){
					$('.search_condition option:eq(0)').prop("selected", true);
					}else if(condition == "lecturer"){
						$('.search_condition option:eq(1)').prop("selected", true);
						}else{
							$('.search_condition option:eq(2)').prop("selected", true);
							} */


			});
		</script>
		</div>

		<p></p>

		<c:if test="${condition!=null }">
			<div style="width: 100%; text-align: right; margin-top: 30px;"><a href="/admin/member/list">[전체목록으로 돌아가기]&nbsp;</a></div>
		</c:if>

		<table class="onlec_mg_list_table">
			<tr>
				<th class="onlec_mg_list_th">번호</th>
				<th class="onlec_mg_list_th">회원ID</th>
				<th class="onlec_mg_list_th">회원명</th>
				<th class="onlec_mg_list_th">구분</th>
				<th class="onlec_mg_list_th">가입일시</th>
				<th class="onlec_mg_list_th">인증</th>
				<th class="onlec_mg_list_th">포인트</th>
			</tr>

			<c:if test="${size!=0 }">
				<c:set var="resultCnt" value="${pagination.totalRecordCount}" />
				<c:forEach var="result" items="${list}" varStatus="status">


						<tr>
							<td class="onlec_mg_list_td">${(resultCnt) - (pagination.recordCountPerPage * (pagination.pageIndex-1))}</td>
							<td class="onlec_mg_list_td">
								<a href="/admin/member/detail?id=${result.id}">${result.id}</a>
							</td>
							<td class="onlec_mg_list_td">${result.name}</td>
							<td class="onlec_mg_list_td">
								<c:if test="${result.memberCategory == 1 }">
									일반회원
								</c:if>
								<c:if test="${result.memberCategory == 2}">
									강사
								</c:if>
							</td>
							<td class="onlec_mg_list_td">
								${result.registerDate}
							</td>
							<td class="onlec_mg_list_td">${result.authstatus}</td>
							<td class="onlec_mg_list_td">
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${result.point}" />
							</td>

						</tr>
						<c:set var="resultCnt" value="${resultCnt -1}" />

				</c:forEach>
			</c:if>

			<c:if test="${size==0 }">
				<tr>
					<td colspan="5" class="onlec_mg_list_td">가입된 회원이 없습니다.</td>
				</tr>
			</c:if>


		</table>

		<!--  <a href="regist" style="display: block; width: 50%; margin: 0 auto;">
			<input type="button" name="" value="회원 등록"
			class="onlec_regi_btn" style="width: 100%; display: block; margin:0 auto;
			margin-bottom: 100px;">
		</a>-->

	</div>

	<c:if test="${fn:length(list) != 0 }">
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