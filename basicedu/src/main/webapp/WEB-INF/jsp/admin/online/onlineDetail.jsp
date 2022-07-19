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

	<div class="onlec_mg_list">
		<h3 class="title" style="width: 100%; border-bottom: 1px solid #000; padding-bottom: 10px;">
			&rtrif;&nbsp;온라인 클래스 관리 - 클래스 상세
		</h3>
			<!--구분-->
			<h4 class="h4h4">강사 정보</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">회원ID</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${lectureInfo.lecturerId}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">강사명</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${lectureInfo.name}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">강사소개</th>
					<td class="onlec_mg_list_td">
						<p class="regi_textarea" style="line-height:1.5;">${fn:replace(lectureInfo.lecturerInfo,cn,br)}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">프로필 사진</th>
					<td class="onlec_mg_list_td">
						<div class="regi_input" style="border: 0px solid #ddd; width: 200px; height: 200px; background-color: #000;
						border-radius: 5px; overflow:hidden; padding-left: 0; padding-right: 0;">
							<img src="/upload/lecturer/${lectureInfo.lecturerImg}" style="width: 100%;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>

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
							class="regi_textarea" style="line-height:1.5;">${fn:replace(lectureInfo.onlineLectureInfo,cn,br)}</p></td>
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
							<p style="line-height:1.5;">
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
						<form class="frm" name="frm" action="/admin/online/deleteReviews" method="post" id="frm">
						<input type="hidden" name="onlineLectureNo" value="${lectureInfo.onlineLectureNo}"/>
						<table class="add_video">
							<c:if test="${reviewList == null}">
								<tr>
									<td colspan="3">등록된 후기가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${reviewList != null }">


								<tr>
									<th class="border_td" style="font-size:14px; ">선택</th>
									<th class="border_td" style="font-size:14px;">수강회원 ID</th>
									<th class="border_td" style="font-size:14px;">내용</th>
									<th class="border_td" style="font-size:14px;">등록일</th>
								</tr>
								<c:forEach var="result2" items="${reviewList}" varStatus="status">
									<tr>
										<td class="border_td tdtd" style="width: 50px; ">
											<input type="checkbox" name="reviewNo" value="${result2.reviewNo}"/>
										</td>
										<td class="border_td tdtd">${result2.id}</td>
										<td class="border_td tdinput">
											<p>
												${result2.contents}
											</p>
										</td>
										<td class="border_td tdtd"><fmt:formatDate value="${result2.registerDate}" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
								<tr><td colspan="4" style="text-align: right; padding-top: 10px;">
									<input type="button" value="후기 삭제" id="reviewsDelBtn"
									style="background-color:#000; color: #fff; width: 100px; border-radius: 5px;
						height: 32px; line-height: 1.5;"/>
								</td></tr>





							</c:if>

						</table>
						</form>

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
				<p><a href="modify?onlineLectureNo=${lectureInfo.onlineLectureNo}"><input type="button" name="" value="수 정 하 기" class="onlec_submit_btn"></a></p>
				<p>
					<input type="button" name="" value="삭 제 하 기" class="onlec_submit_btn delLec" id="deleteBtn">
					<input type="hidden" name="" value="delete?onlineLectureNo=${lectureInfo.onlineLectureNo}" class="link">

				</p>
			</div>


	</div>

<script>

	$('#reviewsDelBtn').click(function(){

		var con = confirm("후기를 삭제하시겠습니까?");

		if(con == true){
			$('#frm').submit();
		}else{
			console.log("취소");
			return}

	});

	$('#deleteBtn').click(function(){

		var con2 = confirm("정말 강의를 삭제하시겠습니까?");
		var link = $(this).next('.link').val();

		if(con2 == true){
			location.href=link;
		}else{
			console.log("취소");
			return}

	});

</script>