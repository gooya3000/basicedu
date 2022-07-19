<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
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
<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_detail.css">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/js/add_my_on2.js"></script>

<script>
	$(function(){
		var msg = $('#msgId').val();
		if(msg != null && msg !=""){
			alert(msg);
			location.href="/mypage/online/onlecmgList";
		}
	});
</script>

	<input type="hidden" value="${msg }" id="msgId"/>

	<ul class="lecture_ch clearfix">
		<a href="/mypage/offline/list">
			<li class="lecture_ch_li">오프라인</li>
		</a>
		<a href="/mypage/online/onlecmgList"><li class="lecture_ch_li mg_on">온라인</li></a>
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
					<td class="onlec_mg_list_td"><p class="regi_input">${lectureInfo.onlineLectureName}</p></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">클래스 소개</th>
					<td class="onlec_mg_list_td"><p
							class="regi_textarea" style="line-height: 1.5;">${fn:replace(lectureInfo.onlineLectureInfo,cn,br)}</p></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">대표사진</th>
					<td class="onlec_mg_list_td">
						<div class="thumImg">
							<img src="/upload/onlec/${lectureInfo.imgFile}" alt="">
						</div>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">가격</th>
					<td class="onlec_mg_list_td"><p class="regi_input">
						<fmt:formatNumber type="number" maxFractionDigits="3" value="${lectureInfo.price}"/> 원</span></br>
					</p></td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>


			<!--구분-->
			<h4 class="h4h4">수업 자료</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">첨부파일</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">
							<c:if test="${empty lectureInfo.libraryFileOrg}">
								없음
							</c:if>
							<c:if test="${!empty lectureInfo.libraryFileOrg}">
								${lectureInfo.libraryFileOrg}
							</c:if>




						</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>


			<!--구분-->
			<h4 class="h4h4">수업 영상</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">영상 수</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${videoQty}</p>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>
			<c:forEach var="result" items="${videoList}" varStatus="status">
			<div class="video_box box1">
				<table class="add_video">

					<tr>
						<th colspan="2" class="border_td">${status.count}강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput">
							<p>
								${result.videoName}
							</p>
						</td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput">
							<p style="line-height: 1.5;">
								${fn:replace(result.videoInfo,cn,br)}
							</p>
						</td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput">
							<p>
								${result.videoFileOrg}
							</p>
						</td>
					</tr>


				</table>
			</div>
			</c:forEach>
			<!--  <div class="plusVideo">
				<input type="button" value="+ 영상추가" class="plusVideo_btn"/>&nbsp;
			</div>-->

			<!--구분-->
			<h4 class="h4h4">수업 후기</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td class="padding"></td>
				</tr>

				<tr>

					<td class="onlec_mg_list_td">

						<table class="add_video">
							<c:if test="${reviewList == null}">
								<tr>
									<td colspan="3">등록된 후기가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${reviewList != null }">
								<tr>
									<th class="border_td" style="font-size:14px;">수강회원 ID</th><th class="border_td" style="font-size:14px;">내용</th><th class="border_td" style="font-size:14px;">등록일</th>
								</tr>
								<c:forEach var="result2" items="${reviewList}" varStatus="status">
									<tr>
										<td class="border_td tdtd">${result2.id}</td>
										<td class="border_td tdinput">
											<p>
												${result2.contents}
											</p>
										</td>
										<td class="border_td tdtd"><fmt:formatDate value="${result2.registerDate}" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</c:if>

						</table>

					</td>
				</tr>
				<tr>
					<td class="padding"></td>
				</tr>
			</table>

			<!--구분-->
			<h4 class="h4h4">수강 회원</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td class="padding"></td>
				</tr>

				<tr>

					<td class="onlec_mg_list_td">

						<table class="add_video">
							<tr>
								<th style="padding-bottom: 20px;">총 수강인원</th>
								<th style="color:red; padding-bottom: 20px;">
									<c:if test="${qty != null}">${qty }</c:if><c:if test="${qty == null}">0</c:if> 명
								</th>
								<th style="padding-bottom: 20px;">총 매출액</th>
								<th style="color:red; padding-bottom: 20px;">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${lectureInfo.price * qty}"/> 원
								</th>
							</tr>


								<tr>
									<th class="border_td tdtd">번호</th><th class="border_td tdtd">수강회원 ID</th>
									<th class="border_td tdtd">진행률</th><th class="border_td tdtd">신청일</th>
								</tr>
								<c:if test="${size != 0}">
									<c:forEach var="result3" items="${classOrderList}" varStatus="status">

										<tr>
											<td class="border_td tdtd">${status.index+1 }</td><td class="border_td tdtd">${result3.id }</td>
											<td class="border_td tdtd">${result3.runtime } %</td>
											<td class="border_td tdtd">
												<fmt:formatDate value="${result3.registerDate}" pattern="yyyy-MM-dd"/>
											</td>

										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${size == 0}">
									<tr><td colspan="4" class="border_td tdtd">수강 중인 회원이 없습니다.</td></tr>
								</c:if>



						</table>

					</td>
				</tr>
				<tr>
					<td class="padding"></td>
				</tr>
			</table>



			<div class="submit_box">
				<p><a href="onlecModify?onlineLectureNo=${lectureInfo.onlineLectureNo}"><input type="button" name="" value="수 정 하 기" class="onlec_submit_btn"></a></p>
				<p>
					<input type="button" name="" value="삭 제 하 기" class="onlec_submit_btn delLec" id="deleteBtn">
					<input type="hidden" name="" value="onlecDelete?onlineLectureNo=${lectureInfo.onlineLectureNo}" class="link" >

				</p>
			</div>

	</div>

<script>

	$('#deleteBtn').click(function(){

		var con = confirm("정말 강의를 삭제하시겠습니까?");
		var link = $(this).next('.link').val();

		if(con == true){
			location.href=link;
		}else{
			console.log("취소");
			return}

	});

</script>




