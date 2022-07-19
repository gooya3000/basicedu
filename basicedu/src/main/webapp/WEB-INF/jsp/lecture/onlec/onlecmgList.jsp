<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_list.css">
<script src="/resources/js/add_my_on2.js"></script>


		<ul class="lecture_ch clearfix">
          <a href="/mypage/offline/list">
          <li class="lecture_ch_li">오프라인</li></a>
          <a href="/mypage/online/onlecmgList"><li class="lecture_ch_li mg_on">온라인</li></a>
        </ul>

        <div class="onlec_mg_list">
          <a href="onlecmgRegist"><input type="button" name="" value="클 래 스 등 록" class="onlec_regi_btn"></a>
          <h4 class="h4h4">진행 중인 온라인 클래스</h4>



	          <table class="onlec_mg_list_table">
	            <tr>
	              <th class="onlec_mg_list_th">번호</th><th class="onlec_mg_list_th">강의명</th><th class="onlec_mg_list_th">가격</th><th class="onlec_mg_list_th">등록일</th>
	            </tr>
				<c:if test="${size!=0 }">
					<c:set var="resultCnt" value="${pagination.totalRecordCount}" />
					<c:forEach var="result" items="${list}" varStatus="status">

			            <tr>
			              <td class="onlec_mg_list_td">${(resultCnt) - (pagination.recordCountPerPage * (pagination.pageIndex-1))}</td>
			              <td class="onlec_mg_list_td"><a href="onlecmgDetail?onlineLectureNo=${result.onlineLectureNo}">${result.onlineLectureName}</a></td>
			              <td class="onlec_mg_list_td"><fmt:formatNumber type="number" maxFractionDigits="3" value="${result.price}"/>원</td>
			              <td class="onlec_mg_list_td"><fmt:formatDate value="${result.registerDate}" pattern="yyyy-MM-dd HH:mm"/></td>
			            </tr>
			            <c:set var="resultCnt" value="${resultCnt -1}" />
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
						<a href="${link}?pageIndex=${pageIndex-1}">이전</a>
					</c:if>
					<c:forEach var="num" begin="${pagination.firstPageNo}" end="${pagination.lastPageNo}">
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
