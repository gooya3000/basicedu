<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_offline_list.css">


<div class="onlec_mg_list" style="width: 880px;">

	<h3 class="title">&rtrif;&nbsp;오프라인 클래스</h3>

<div class="search_bar">
	<select class="search_condition" name="searchCondition" id="searchCondition" style="margin-left: 435px;">
			<c:if test="${searchCondition eq null}">
				<option value="lecName">강사명</option>
				<option value="className">클래스명</option>
			</c:if>
			<c:if test="${searchCondition ne null}">
				<option value="className"<c:if test="${searchCondition eq 'className'}"> selected="selected"</c:if>>클래스명</option>
				<option value="lecName" <c:if test="${searchCondition eq 'lecName'}">selected="selected" </c:if>>강사명</option>
			</c:if>

		</select>
		<c:if test="${keyword eq null}">
			<input type="text" name="search_keyword" value="" class="search_keword" id="keyword" onkeypress="enter()">
		</c:if>
		<c:if test="${keyword ne null}">
			<input type="text" name="search_keyword" value="${keyword}" class="search_keword" id="keyword" onkeypress="enter()">
		</c:if>
		<button name="searchBtn"class="search_btn" id="search"> 검색</button>
	</div>


	<table class="onlec_mg_list_table">
		<tr>
			<th class="onlec_mg_list_th">번호</th>
			<th class="onlec_mg_list_th">대표이미지</th>
			<th class="onlec_mg_list_th">클래스명</th>
			<th class="onlec_mg_list_th">강사명</th>
			<th class="onlec_mg_list_th">신청인원</th>
			<th class="onlec_mg_list_th">등록일</th>
			<th class="onlec_mg_list_th">신청기간</th>
		</tr>
		<c:if test="${size!=0 }">
			<c:forEach var="result" items="${list}" varStatus="status">
				<tr>
					<td class="onlec_mg_list_td">${status.index+1}</td>
					<td class="onlec_mg_list_td"><a href="./offlineSelect?offline_lecture_NO=${result.offline_lecture_NO}"><img src="/upload/offline/thumb/${result.offline_lecture_img}"alt="img"></a></td>
					<td class="onlec_mg_list_td">${result.offline_lecture_name}</td>
					<td class="onlec_mg_list_td">${result.name}</td>
					<td class="onlec_mg_list_td">${result.aplinum} / ${result.offline_lecture_max}</td>
					<td class="onlec_mg_list_td">${result.offline_lecture_reg}</td>
					<td class="onlec_mg_list_td">${result.offline_lecture_applyperiodstart} ~ ${result.offline_lecture_applyperiodend}</td>
				</tr>

			</c:forEach>
		</c:if>
		<c:if test="${size==0 }">
			<tr>
				<td colspan="4" class="onlec_mg_list_td">등록된 강의가 없습니다.</td>
			</tr>
		</c:if>

	</table>

	<a href="./offlineAdd"><input type="button" name="" value="클래스 등록"
		class="onlec_regi_btn" style="width: 50%; display: block; margin:0 auto; margin-bottom: 100px;"></a>

</div>

<script>


	$(document).on('click', '#search', function(e){

		if($("#keyword").val().trim() ==''){
			alert('입력란에 검색어를 입력하세요');
			$("#keyword").focus();
			return false;
		}
		e.preventDefault();
		var url = "./offlineSearch";
		url = url + "?searchCondition=" + $('#searchCondition').val();
		url = url + "&search_keyword=" + $('#keyword').val();
		location.href = url;

	});

	function enter() {
        if (window.event.keyCode == 13 ) {
        	var url = "./offlineSearch";
    		url = url + "?searchCondition=" + $('#searchCondition').val();
    		url = url + "&search_keyword=" + $('#keyword').val();
    		location.href = url;
        }
    }

</script>

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
			<c:forEach var="num" begin="${pagination.firstPageNo}"
				end="${pagination.lastPageNo}">
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
