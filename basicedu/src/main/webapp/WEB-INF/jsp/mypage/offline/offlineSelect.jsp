<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_online_detail.css">

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<ul class="lecture_ch clearfix">
	<a href="#">
		<li class="lecture_ch_li mg_on">오프라인</li>
	</a>
	<a href="#"><li class="lecture_ch_li">온라인</li></a>
</ul>

<div class="onlec_mg_list">

		<!--구분-->

		<h4 class="h4h4">클래스 정보</h4>
		<table class="onlec_mg_list_table">
			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스명</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
				<c:choose>
				        <c:when test="${fn:length(result.offline_lecture_name) gt 18}">
				       		 <c:out value="${fn:substring(result.offline_lecture_name, 0, 18)}">...
				        </c:out></c:when>
				        <c:otherwise>
				        	<c:out value="${result.offline_lecture_name}">
				        </c:out></c:otherwise>
				</c:choose>

				</p></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스 소개</th>
				<td class="onlec_mg_list_td"><p
						class="regi_textarea">
				<c:choose>
				        <c:when test="${fn:length(result.offline_lecture_introduce) gt 18}">
				       		 <c:out value="${fn:substring(result.offline_lecture_introduce, 0, 18)}">...
				        </c:out></c:when>
				        <c:otherwise>
				        	<c:out value="${result.offline_lecture_introduce}">
				        </c:out></c:otherwise>
				</c:choose>

						</p></td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">대표사진</th>
				<td class="onlec_mg_list_td">
					<div class="thumImg">
						<img src="/upload/offline/${result.offline_lecture_img}" alt="">
					</div>
				</td>
			</tr>
			<tr>
				<th class="onlec_mg_list_th">클래스 주소</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_address}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">최소인원</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_min}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">최대인원</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_max}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">등록 시작일</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_applyperiodstart}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">등록 종료일 </th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_applyperiodend}
				</p></td>
			</tr>

			<tr>
				<th class="onlec_mg_list_th">클래스 일정</th>
				<td class="onlec_mg_list_td"><p class="regi_input">
					${result.offline_lecture_schedule}
				</p></td>
			</tr>
			<tr>
				<td colspan="2" class="padding"></td>
			</tr>
		</table>

		<div class="submit_box">
			<p><a href="./offlineDetailSelect?offline_lecture_NO=${result.offline_lecture_NO}"><input type="button" name="" value="상 세 페 이 지" class="onlec_submit_btn"></a></p>
			</br></br>
			<p><a href="./applicationList?offline_lecture_NO=${result.offline_lecture_NO}"><input type="button" name="" value="신 청 현 황" class="onlec_submit_btn"></a></p>
		</div>

</div>