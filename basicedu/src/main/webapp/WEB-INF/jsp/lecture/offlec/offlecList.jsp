<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/search.css">
<link rel="stylesheet" href="/resources/css/onlec_list.css">

<div class="search_bar container">

		<select class="search_condition" name="searchCondition" id="searchCondition">
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

<ul class="onlec_list clearfix">


<c:if test="${keyword ne null}">
	<c:if test="${searchCondition eq 'lecName'}">
		<h5>[강사명] ${keyword}로 검색하신 결과입니다.</h5>
	</c:if>
	<c:if test="${searchCondition eq 'className'}">
		<h5>[클래스명] ${keyword}로 검색하신 결과입니다.</h5>
	</c:if>
</c:if>
	<c:forEach var="list" items="${offlecList}" varStatus="status">

	 <li class="onlec_list_li">
	          <div class="onlec_list_box">
	            <div class="onlec_img">
	            	<a href="./detail?offline_lecture_NO=${list.offline_lecture_NO}"><img src="/upload/offline/thumb/${list.offline_lecture_img}" alt="sample"></a></div>
	            <div class="onlec_cont">
	            <a href="./detail?offline_lecture_NO=${list.offline_lecture_NO}"><h3 class="onlec_title onlec_cont_com">
	            <c:choose>
				        <c:when test="${fn:length(list.offline_lecture_name) gt 35}">
				       		 <c:out value="${fn:substring(list.offline_lecture_name, 0, 35)}">...
				        </c:out></c:when>
				        <c:otherwise>
				        	<c:out value="${list.offline_lecture_name}">
				        </c:out></c:otherwise>
				</c:choose>
	          </h3></a>
	            <h5 class="onlec_lecturer onlec_cont_com">${list.offline_lecture_address}</h5>
	            </div>
	          </div>
	        </li>

	</c:forEach>

</ul>

<c:if test="${fn:length(offlecList) != 0 }">
			<div class="pagination_wrap">
				<div class="pagination">
					<c:set var="pageIndex" value="${pagination.pageIndex}" />
					<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
					<c:url var="link" value="./list" />

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

<script>
	$(document).on('click', '#search', function(e){
		if($("#keyword").val().trim() ==''){
			alert('입력란에 검색어를 입력하세요');
			$("#keyword").val('');
			$("#keyword").focus();
			return false;
		}
		e.preventDefault();
		var url = "./offlecSearch";
		url = url + "?searchCondition=" + $('#searchCondition').val();
		url = url + "&search_keyword=" + $('#keyword').val();
		location.href = url;

	});

	function enter() {
        if (window.event.keyCode == 13 ) {
        	var url = "./offlecSearch";
    		url = url + "?searchCondition=" + $('#searchCondition').val();
    		url = url + "&search_keyword=" + $('#keyword').val();
    		location.href = url;
        }
    }
</script>
