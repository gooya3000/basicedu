<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_regi.css">

<script>
	$(function(){
		var videoQty = ${videoQty};
		$('.onlec_select').val(videoQty);

	});

</script>
<script src="/resources/js/add_video.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/js/add_my_on2.js"></script>
<script src="/resources/js/textAr.js"></script>
<script src="/resources/js/fileCheck.js"></script>

	<div class="onlec_mg_list">
		<h3 class="title" style="width: 100%; border-bottom: 1px solid #000; padding-bottom: 10px;">
			&rtrif;&nbsp;온라인 클래스 관리 - 클래스 수정
		</h3>
		<form:form action="modifyPro" method="post" name="frm"
			commandName="onlecMgCommand" enctype="multipart/form-data"
			modelAttribute="onlecMgCommand">

			<input type="hidden" name="onlineLectureNo" value="${lectureInfo.onlineLectureNo}"/>
			<!--구분-->

			<h4 class="h4h4">클래스 정보</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">클래스명</th>
					<td class="onlec_mg_list_td"><input type="text"
						name="onlineLectureName" value="${lectureInfo.onlineLectureName}" class="regi_input" maxlength="30" required></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">클래스 소개</th>
					<td class="onlec_mg_list_td"><textarea name="onlineLectureInfo"
							rows="8" cols="80" class="regi_textarea" id="textAr"
							placeholder="클래스를 소개 내용을 작성해주세요.(최대 200자)">${lectureInfo.onlineLectureInfo}</textarea></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">대표사진</th>
					<td class="onlec_mg_list_td">
						<input type="file" name="lectureFiles" id="imgFile" accept=".gif, .jpg, .png" class="modiFiles">
						&nbsp;&nbsp;<input type="button" value="취소" class="uploadCancle"/>
						</br><span class="prFile">기존파일: </span>
						<div class="thumbFrame">
							<img src="/upload/onlec/thumb/${lectureInfo.imgFile}" alt="" class="thumImg">
						</div>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">가격(원)</th>
					<td class="onlec_mg_list_td"><input type="text" name="price"
						value="${lectureInfo.price}" class="regi_input" min="1" max="9999999" required></td>
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
						<input type="file" name="lectureFiles" class="modiFiles">
						&nbsp;&nbsp;<input type="button" value="취소" class="uploadCancle"/>
						</br><span class="prFile">기존파일:
							<c:if test="${empty lectureInfo.libraryFileOrg}">
								없음
							</c:if>
							<c:if test="${!empty lectureInfo.libraryFileOrg}">
								${lectureInfo.libraryFileOrg}
							</c:if></span>
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
					<td class="onlec_mg_list_td">${videoQty}강
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
						<th colspan="2" class="border_td">${status.count }강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text" name="videoName" value="${result.videoName}" class="video_input"
						maxlength="30" required></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo" rows="8" cols="80" id="textArVideo"
						placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)" required>${result.videoInfo}</textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput">
							<input type="file" name="lectureFiles" value="" id="videoFile" accept="video/mp4" class="modiFiles">
							&nbsp;&nbsp;<input type="button" value="취소" class="uploadCancle"/>
							</br><span class="prFile">기존파일: ${result.videoFileOrg}</span>

						</td>
					</tr>
				</table>
			</div>
			</c:forEach>


			<div class="submit_box">
				<input type="submit" name="" value="수 정 완 료" class="onlec_submit_btn" style="cursor:pointer">
				<p style="margin-top: 10px;">
					<a href="/admin/online/detail?onlineLectureNo=${lectureInfo.onlineLectureNo}">
						<input type="button" name="" value="취 소" class="onlec_submit_btn" style="background-color:#666; color: #fff; cursor:pointer;"/>
					</a>
				<p>
			</div>








		</form:form>



	</div>