<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_regi.css">
<script src="/resources/js/fileCheck.js"></script>

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
		<form:form action="onlecModifyPro" method="post" name="frm"
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
					<td class="onlec_mg_list_td"><input type="file" name="lectureFiles" id="imgFile"
					accept=".gif, .jpg, .png" class="modiFiles">&nbsp;&nbsp;<input type="button" value="취소" class="uploadCancle"/>
					</br><span class="prFile">기존파일: </span>
						<div class="thumbFrame">
							<img src="/upload/onlec/thumb/${lectureInfo.imgFile}" alt="" class="thumImg">
						</div>
						<!-- <p class="upload_info">&check; 이미지를 업로드하면 기존 이미지는 삭제됩니다.</p> -->
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
						<!--  <p class="upload_info" required>&check; 첨부파일를 업로드하면 기존 자료는 삭제됩니다.</p>-->
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
						<td class="border_td tdinput">
							<input type="text" name="videoName" value="${result.videoName}" class="video_input" maxlength="30" required>
						</td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo" rows="8" cols="80" id="textArVideo"
						placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)" required>${result.videoInfo}</textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file" name="lectureFiles" value="" id="videoFile" accept="video/mp4" class="modiFiles">
							&nbsp;&nbsp;<input type="button" value="취소" class="uploadCancle"/>
							</br><span class="prFile">기존파일: ${result.videoFileOrg}</span>
							<!--  <p class="upload_info">&check; 영상을 업로드하면 기존 영상은 삭제됩니다.</p>-->
						</td>
					</tr>
				</table>
			</div>
			</c:forEach>

			<div class="submit_box">
				<p><input type="submit" name="" value="수 정 완 료" class="onlec_submit_btn" style="cursor:pointer;"></p>
				<p style="margin-top: 10px;">
					<a href="/mypage/online/onlecmgDetail?onlineLectureNo=${lectureInfo.onlineLectureNo}">
						<input type="button" name="" value="취 소" class="onlec_submit_btn" style="background-color:#666; color: #fff; cursor:pointer;"/>
					</a>
				<p>
			</div>

		</form:form>
	</div>