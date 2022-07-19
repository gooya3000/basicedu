<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/css/mypage_lecture_mylect_online_list.css">
<script src="/resources/js/review.js"></script>
<script src="/resources/js/add_my_on.js"></script>
<script src="/resources/js/textAr.js"></script>

		<ul class="lecture_ch clearfix">
          <a href="/mypage/offline/offlineMylecture">
          <li class="lecture_ch_li">오프라인</li></a>
          <a href="/mypage/online/myOnlineClass"><li class="lecture_ch_li mg_on">온라인</li></a>
        </ul>

        <div class="onlec_mg_list">

          <h3 class="title">&rtrif;&nbsp;수강 중인 온라인 클래스</h3>
          <c:if test="${size == 0}">
          	<p style="width: 100%; text-align: center; line-height: 1.5;">신청하신 클래스가 없습니다.</p>

          </c:if>
          <c:if test="${size != 0}">
			<c:forEach var="result" items="${list}" varStatus="status">

	          <div class="myClass_list">

	            <div class="review_modal">
		             <form action="/mypage/online/myOnlineReview" name="frm" method="post">
			              <h4 class="review_title">수강후기</h4>
			              <textarea name="onlineReview" class="review_textarea textAr"></textarea>
			              <input type="hidden" name="onlineLectureNo" value="${result.onlineLectureNo}"/>
			              <input type="hidden" name="onlineOrderNo" value="${result.onlineOrderNo}"/>
			              <div class="review_btns">
			                <input type="submit" name="" value="등록" class="btns_btn rebtn">
			                <input type="button" name="" value="취소" class="btns_btn reCancle">
			              </div>
		             </form>
	            </div>

	            <table class="onlec_myClass">
	              <tr>
	                <td rowspan="2" class="imgBox">
	                  <div class="onlec_img_box">
	                    <img src="/upload/onlec/thumb/${result.imgFile}" alt="">
	                  </div>
	                </td>
	                <td colspan="2"><h4 class="lecName" style="text-align: left; line-height:1.5;">${result.onlineLectureName}<h4></td>
	                <td rowspan="2" class="classBox">
	                  <a href="/mypage/online/myOnlineDetail?onlineLectureNo=${result.onlineLectureNo}&onlineOrderNo=${result.onlineOrderNo}"><div class="goClass">수강</div></a>
	                </td>
	              </tr>
	              <tr>
	                <td class="myclass_content">
	                	진행률
	                	</br>환급 포인트
	                </td>
	                <td class="alignRight myclass_content">
	                	<div class="progress_bar" style="width: 300px; height: 12px; border: 1px solid #000; display:inline-block;">
	                		<div class="prg_now" style="width: ${result.runtime}%; height: 12px; background-color:rgb(255,217,102);"></div>
	                	</div>&nbsp;&nbsp;
		                ${result.runtime } %</br>
		                <c:if test="${result.pointBack == 0}">
		                	<fmt:formatNumber type="number" maxFractionDigits="3" value="${result.price * 0.1}"/> P
		                </c:if>
		                <c:if test="${result.pointBack == 1}">
		                	-&nbsp;&nbsp;
		                </c:if>

					</td>
	              </tr>
	            </table>
	            <div class="btns">
	              <input type="button" name="" value="후기등록" class="btns_btn review_regi">
	              <input type="button" name="" value="강의삭제" class="btns_btn lecDelBtn">
	              <input type="hidden" class="link" value="/mypage/online/myOnlineDelete?onlineOrderNo=${result.onlineOrderNo }"/>
	            </div>
	            <c:if test="${result.runtime > 80}">
	            	<c:if test="${result.pointBack == 0}">
			            <div class="btns">

			              	<input type="button" name="" value="포인트 환급" class="point_btn" style="width: 100%;" id="pBackBtn">
			              	<input type="hidden" value="/mypage/online/pointBack?onlineOrderNo=${result.onlineOrderNo }&point=${result.price}" class="link"/>

			            </div>
			        </c:if>
			        <c:if test="${result.pointBack == 1}">
			            <div class="btns">
			              <button type="button" name="" class="point_btn" id="completeBack"
			              style="background-color: #000; color: #666; width: 100%;">
			              	<fmt:formatNumber type="number" maxFractionDigits="3" value="${result.price * 0.1}"/>P 환급 완료
			              </button>
			            </div>
			        </c:if>
	            </c:if>

	          </div>
			</c:forEach>
		  </c:if>




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

<script>

	$('.lecDelBtn').click(function(){

		var con = confirm("정말 강의를 삭제하시겠습니까?");
		var link = $(this).next('.link').val();

		if(con == true){
			location.href=link;
		}else{
			console.log("취소");
			return}

	});



	$('#pBackBtn').click(function(){

		var con = confirm("포인트를 환급 신청을 하시겠습니까?");
		var link = $(this).next('.link').val();

		if(con == true){
			location.href=link;
		}else{
			console.log("취소");
			return}

	});

	$('#completeBack').click(function(){
		alert('이미 포인트 환급이 완료된 클래스입니다.');
	});


</script>
