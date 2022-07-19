<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	pageContext.setAttribute("cn", "\n");
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cr", "\r");
	pageContext.setAttribute("crcn", "\r\n");
%>

<link rel="stylesheet" href="/resources/css/search.css">
<link rel="stylesheet" href="/resources/css/onlec_detail.css">
<script src="/resources/js/chap_box.js"></script>
<script src="/resources/js/textAr.js"></script>

	<div class="onlec_thums">
        <table class="thum_table">
          <tr>
            <td rowspan="7">
              <div class="detail_img"><img src="/upload/onlec/${lectureInfo.imgFile}" alt=""></div>
            </td><td colspan="2" class="detail_td"><h2 class="detail_h2">${lectureInfo.onlineLectureName}<span class="lec_num">${videoQty}강</span></h2></td>
          </tr>
          <tr>
            <td colspan="2" class="detail_td detail_info">${fn:replace(lectureInfo.onlineLectureInfo,cn,br)}</tr>
          <tr><td colspan="2" class="line_td"><div class="line"></div></td></tr>
          <tr>
            <td class="detail_td detail_price_com">수강료</br>환급포인트</td>
            <td class="detail_td detail_price detail_price_com"><span class="red_price">
            	<fmt:formatNumber type="number" maxFractionDigits="3" value="${lectureInfo.price}"/> 원</span></br>
            	<fmt:formatNumber type="number" maxFractionDigits="3" value="${lectureInfo.price * 0.1}"/> 점</td>
          </tr>
          <tr><td colspan="2" class="line_td"><div class="line"></div></td></tr>
          <tr>
            <td colspan="2" class="detail_td">
            <c:if test="${isMy == null }">
            	<a href="apply?onlineLectureNo=${lectureInfo.onlineLectureNo}"><input type="button" name="" value="수 강 신 청" class="detail_btn"></a>
            </c:if>
            <c:if test="${isMy != null }">
            	<input type="button" name="" value="이미 수강중인 강의" class="detail_btn" style="background-color: #333; color: #666;" id="goMypage">
            	<input type="hidden" name="" value="/mypage/online/myOnlineClass" class="link">
            	<script>
            		$(function(){
                			$('#goMypage').click(function(){
                				var con = confirm("수강 페이지로 이동하시겠습니까?");
                				var link = $(this).next('.link').val();

                				if(con == true){
                					location.href=link;
                				}else{
                					console.log("취소");
                					return}
                    			});
                		});
            	</script>
            </c:if>

            </td>
          </tr>
        </table>


        <h2 class="small_title">클래스 목록</h2>
        <table class="chap_table">
         <c:forEach var="result" items="${videoList}" varStatus="status">
          <tr>
            <td class="chap_box">
              <h3 class="chap_title">${status.count}강. ${result.videoName}<div class="arrow">&dtrif;</div><div class="arrow_up">&utrif;</div></h3>
              <p class="chap_cont" style="line-height:1.5;">
              		${fn:replace(result.videoInfo,cn,br)}
              </p>
            </td>
          </tr>
         </c:forEach>

        </table>

        <h2 class="small_title">강사정보</h2>
        <table>

          <tr>
            <td class="lecturer_box">
              <div class="lecturer_img">
                <img src="/upload/lecturer/${lectureInfo.lecturerImg}" alt="" >
              </div>
              <h3 class="lecturer_name">${lectureInfo.name}</h3>
              <p class="lecturer_info" style="line-height:1.5;">${fn:replace(lectureInfo.lecturerInfo,cn,br)}</p>
              <a href="/onlineClass/lecturerList?id=${lectureInfo.lecturerId}&name=${lectureInfo.name}"><input type="button" name="" value="강사님의 다른 클래스 보러가기" class="another_class"></a>
            </td>
          </tr>
        </table>

        <h2 class="small_title">수강후기</h2>
        <div class="comment_output">
        	<c:if test="${reviewList == null}">
        		<p>등록된 후기가 없습니다.</p>
        	</c:if>
        	<c:if test="${reviewList != null }">
        		<ul>
        		  <c:forEach var="result2" items="${reviewList}" varStatus="status">
        			<li>
        				<h5 style="margin-bottom: 10px;margin-top: 10px;margin-left: 5px; font-size:16px;">${result2.id}
        				<span style="font-size:14px; color: #999; font-weight: normal;"><fmt:formatDate value="${result2.registerDate}" pattern="yyyy-MM-dd"/></span></h5>
        				<div style="
        					padding: 10px;
        					background-color: #fff;
        					border-radius: 5px;
        					line-height: 1.5;
        					box-shadow:  1px 1px 12px 1px rgba(0, 0, 0, 0.1);
        					margin-bottom:25px;

        				">${fn:replace(result2.contents,cn,br)}


        					<c:if test="${nowId eq result2.id }">
        						<div style="margin-top: 10px;">

	        							<input type="button" name="delReview" class="reviewBtn deleteReviewBtn" value="삭제"/>
	        							<input type="hidden" class="link" value="reviewDelete?reviewNo=${result2.reviewNo }&onlineLectureNo=${lectureInfo.onlineLectureNo}"/>


	        					</div>
        					</c:if>

        				</div>


        			</li>
        		  </c:forEach>
        		</ul>
        	</c:if>
        </div>
		<c:if test="${isMy != null }">
			<!--수강중인 회원에게만 보이는 인풋박스-->
			<form:form action="/mypage/online/myOnlineReview" name="frm" method="post" commandName="command"
			modelAttribute="command">
				<div class="comment_input_box">
	          		<textarea name="onlineReview" rows="8" cols="80" class="comment_input textAr"></textarea>
	          		<input type="hidden" name="onlineLectureNo" value="${lectureInfo.onlineLectureNo}">
	          		<input type="submit" name="" value="등 록" class="another_class1">
	        	</div>

			</form:form>

		</c:if>

		<h2 class="small_title">

	        <c:if test="${isMy == null }">
            	<a href="apply?onlineLectureNo=${lectureInfo.onlineLectureNo}"><input type="button" name="" value="수 강 신 청" class="detail_btn another_class_"></a>
            </c:if>
            <c:if test="${isMy != null }">
            	<input type="button" name="" value="이미 수강중인 강의" class="detail_btn another_class_" style="background-color: #333; color: #666;" id="goMypage2">
            	<input type="hidden" name="" value="/mypage/online/myOnlineClass" class="link">
            	<script>
            		$(function(){
                			$('#goMypage2').click(function(){
                				var con = confirm("수강 페이지로 이동하시겠습니까?");
                				var link = $(this).next('.link').val();

                				if(con == true){
                					location.href=link;
                				}else{
                					console.log("취소");
                					return}
                    			});
                		});
            	</script>
            </c:if>
		</h2>





      </div>

<script>

	$('.deleteReviewBtn').click(function(){

		var con = confirm("후기를 삭제하시겠습니까?");
		var link = $(this).next('.link').val();

		if(con == true){
			location.href=link;
		}else{
			console.log("취소");
			return}

	});

</script>