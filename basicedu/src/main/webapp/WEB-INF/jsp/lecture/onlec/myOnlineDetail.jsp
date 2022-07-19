<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	pageContext.setAttribute("cn", "\n");
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cr", "\r");
	pageContext.setAttribute("crcn", "\r\n");
%>
<link rel="stylesheet" href="/resources/css/onlec_mylec.css">
<script src="/resources/js/review.js"></script>
<script src="/resources/js/chap_box.js"></script>
<script src="/resources/js/add_my_on.js"></script>
<script src="/resources/js/textAr.js"></script>

        <ul class="lecture_ch clearfix">
          <a href="/mypage/offline/offlineMylecture">
          <li class="lecture_ch_li">오프라인</li></a>
          <a href="/mypage/online/myOnlineClass"><li class="lecture_ch_li mg_on">온라인</li></a>
        </ul>

        <div class="onlec_mg_list">

          <h3 class="title">&rtrif;&nbsp;클래스 수강</h3>


          <div class="myClass_list">



            <table class="thum_table">
              <tr>
                <td rowspan="4" class="img_td">
                    <div class="detail_img">
                  		<img src="/upload/onlec/${classInfo.imgFile}" alt="" >
                    </div>
                </td>
                <td colspan="2" class="detail_td">
                	<h2 class="detail_h2">${classInfo.onlineLectureName}<span class="lec_num">${videoQty}강</span></h2>
                </td>
              </tr>
              <tr>
                <td colspan="2" class="detail_td detail_info">${fn:replace(classInfo.onlineLectureInfo,cn,br)}</td>
              </tr>
              <tr>
              	<td colspan="2" class="line_td"><div class="line"></div></td>
              </tr>
              <tr>
                <td class="detail_td detail_price_com">진행률</br>환급포인트</td>
                <td class="detail_td detail_price detail_price_com"><span class="red_price">${myclass.runtime} %</span></br>
                	<fmt:formatNumber type="number" maxFractionDigits="3" value="${classInfo.price * 0.1}"/> P</td>
              </tr>
              <tr>
              </tr>
            </table>

            <h2 class="small_title">수업자료</h2>
            <table class="chap_table">
              <tr>
                <td class="chap_box alignCenter">
                	<c:if test="${empty classInfo.libraryFileOrg}">
					 	없음
					</c:if>
					<c:if test="${!empty classInfo.libraryFileOrg}">
						<a href="/mypage/online/myFileDown?fileDir=/upload/onlec/&fileNameStr=${classInfo.libraryFileStr}&fileNameOrg=${classInfo.libraryFileOrg}">${classInfo.libraryFileOrg}</a>
					</c:if>
                  </td>
              </tr>
            </table>

            <h2 class="small_title">클래스 목록</h2>
            <table class="chap_table">
              <c:forEach var="result" items="${video}" varStatus="status">
              <tr>
                <td class="chap_box">
                  <h3 class="chap_title">${status.count }강. ${result.videoName }<div class="arrow">&dtrif;</div><div class="arrow_up">&utrif;</div></h3>
                  <p class="chap_cont" style="line-height:1.5;">${fn:replace(result.videoInfo,cn,br)}</br>

                      <a href="/mypage/online/myOnlineVideo?onlineLectureNo=${classInfo.onlineLectureNo}&videoNo=${result.videoNo}&nowVideo=${status.index+1}&onlineOrderNo=${myclass.onlineOrderNo}"><button type="button" class="chap_video"><span class="bigger">&rtrif;</span>영상플레이</button></a>

                  </p>

                </td>
              </tr>
             </c:forEach>

            </table>

			<h2 class="small_title"></h2>
            <div class="detail_td_div"><input type="button" name="" value="강사정보" class="detail_btn_">
                    <input type="button" name="" value="후기등록" class="detail_btn detail_review_regi" >
            </div>

            <div class="review_modal">
	            <form action="/mypage/online/myOnlineReview" name="frm" method="post">
	              <h4 class="review_title">수강후기</h4>
	              <textarea name="onlineReview" class="review_textarea textAr"></textarea>
	              <input type="hidden" name="onlineLectureNo" value="${classInfo.onlineLectureNo}"/>
	              <div class="review_btns">
	                <input type="submit" name="" value="등록" class="btns_btn rebtn">
	                <input type="button" name="" value="취소" class="btns_btn reCan">
	              </div>
	            </form>
            </div>

            <div class="review_modal2">

              <h4 class="review_title">강사정보</h4>
              <table style="width: 90%; margin: 0 auto; margin-top: 25px;">
               <tr>
               	<td rowspan="2" style="width: 210px;">
               		<div style="width: 200px; height:200px; border-radius:5px; background-color: #ddd; overflow:hidden;">
               			<img src="/upload/lecturer/${classInfo.lecturerImg}" alt="" style="width:100%;"/>
               		</div>
               	</td>
               	<td style="text-align: left; border-bottom: 1px solid #ddd;
               	padding-left:5px;padding-right:5px;
               	height: 50px;"><h3>${classInfo.name}</h3></td>
               </tr>
               <tr>
               	<td style="text-align: left; border: 1px solid #ddd; padding-left:10px; padding-right:10px;"><p>
               	${fn:replace(classInfo.lecturerInfo,cn,br)}</p></td>
               </tr>
               <tr>
               	<td colspan="2" style="padding-top:15px;">
               		<a href="/onlineClass/lecturerList?id=${classInfo.lecturerId}&name=${classInfo.name}">
               			<input type="button" name="" value="강사님의 다른 클래스" class="btns_btn rebtn">

               		</a>
               		<input type="button" name="" value="닫기" class="btns_btn close">
               	</td>
               </tr>
              </table>


            </div>



          </div>






        </div>

