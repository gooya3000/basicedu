<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_online_list.css">
<script src="/resources/js/add_my_on2.js"></script>
<script src="/resources/js/search.js"></script>



	<div class="onlec_mg_list">

		<h3 class="title" style="width: 100%; border-bottom: 1px solid #000; padding-bottom: 10px;">&rtrif;&nbsp;온라인 클래스 관리</h3>

		<div class="search_bar">
			<form class="frm" name="frm" action="/admin/online/list" method="post" id="searchFrm">
				<select class="search_condition" name="condition" style="margin-left: 420px;">
					<option value="lecturerName">강사명</option>
					<option value="className">클래스명</option>
				</select> <input type="text" name="keyword" value="" class="search_keword"
					required> <input type="submit" name="searchBtn" value="검색"
					class="search_btn" >
			</form>
		</div>
		<script>
		$(function() {
			var condition = '${condition}';
			if(condition == "lecturerName"){
				$('.search_condition option:eq(0)').prop("selected", true);
				}else{
					$('.search_condition option:eq(1)').prop("selected", true);
				}
			var keyword = '${keyword}';
			$('.search_keword').val(keyword);

		});
		</script>

		<c:if test="${lname != null }">
	      <h4 style="margin-left:10px;margin-top: 100px; color: #333;">&rtrif; <span style="color:red;">${lname}</span> 강사님이 진행 중인 온라인 클래스입니다.</h4>
	      <p style="margin-left: 28px; font-size:14px; margin-top: 10px;"><a href="/admin/online/list">[전체보기]</a></p>
	    </c:if>
	    <c:if test="${searchInfo != null }">
	      <h4 style="margin-left:10px;margin-top: 100px; color: #333;">&rtrif; ${condition} '<span style="color:red;">${keyword}</span>'${searchInfo}</h4>
	      <p style="margin-left: 28px; font-size:14px; margin-top: 10px;"><a href="/admin/online/list">[전체보기]</a></p>
	    </c:if>
	    <p></p>


		<table class="onlec_mg_list_table">
			<tr>
				<th class="onlec_mg_list_th">번호</th>
				<th class="onlec_mg_list_th">대표이미지</th>
				<th class="onlec_mg_list_th">클래스명</th>
				<th class="onlec_mg_list_th">강사</th>
				<th class="onlec_mg_list_th">가격</th>
				<th class="onlec_mg_list_th">등록일</th>
			</tr>
			<c:if test="${size!=0 }">
				<c:set var="resultCnt" value="${pagination.totalRecordCount}"/>
				<c:forEach var="result" items="${list}" varStatus="status">


					<tr>
						<td class="onlec_mg_list_td">${(resultCnt) - (pagination.recordCountPerPage * (pagination.pageIndex-1))}</td>
						<td class="onlec_mg_list_td" style="width: 190px;">
							<div style="width:190px; height:120px; overflow: hidden; border-radius: 5px;"><img src="/upload/onlec/thumb/${result.imgFile}" style="width: 100%;"/></div>
						</td>
						<td class="onlec_mg_list_td" style="line-height: 1.5; width: 260px;"><a href="detail?onlineLectureNo=${result.onlineLectureNo}">${result.onlineLectureName}</a></td>
						<td class="onlec_mg_list_td" style="line-height: 1.5;">${result.lecturerId}</br>${result.name }</td>
						<td class="onlec_mg_list_td"><fmt:formatNumber type="number"
								maxFractionDigits="3" value="${result.price}" />원</td>
						<td class="onlec_mg_list_td"><fmt:formatDate
								value="${result.registerDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
				<c:set var="resultCnt" value="${resultCnt -1}" />
				</c:forEach>

			</c:if>
			<c:if test="${size==0 }">
				<tr>
					<td colspan="6" class="onlec_mg_list_td">등록된 강의가 없습니다.</td>
				</tr>
			</c:if>

		</table>

		<a href="regist"><input type="button" name="" value="클래스 등록"
			class="onlec_regi_btn" style="width: 50%; display: block; margin:0 auto; margin-bottom: 100px;"></a>

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
