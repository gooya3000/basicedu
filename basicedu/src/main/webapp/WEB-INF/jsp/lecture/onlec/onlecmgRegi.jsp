<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/mypage_lecture_mg_online_regi.css">
<script src="/resources/js/add_video.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/js/add_my_on2.js"></script>
<script src="/resources/js/textAr.js"></script>
<script src="/resources/js/fileCheck.js"></script>


	<ul class="lecture_ch clearfix">
		<a href="/mypage/offline/list">
			<li class="lecture_ch_li">오프라인</li>
		</a>
		<a href="/mypage/online/onlecmgList"><li class="lecture_ch_li mg_on">온라인</li></a>
	</ul>

	<div class="onlec_mg_list">
		<form:form action="onlecmgRegistPro" method="post" name="frm"
			commandName="onlecMgCommand" enctype="multipart/form-data"
			modelAttribute="onlecMgCommand" id="form">
			<!--구분-->

			<h4 class="h4h4">클래스 정보 입력</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">클래스명</th>
					<td class="onlec_mg_list_td"><input type="text"
						name="onlineLectureName" value="" class="regi_input" maxlength="30" required></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">클래스 소개</th>
					<td class="onlec_mg_list_td"><textarea name="onlineLectureInfo"
							rows="8" cols="80" class="regi_textarea" id="textAr"
							placeholder="클래스를 소개 내용을 작성해주세요.(최대 200자)"></textarea></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">대표사진</th>
					<td class="onlec_mg_list_td"><input type="file" name="lectureFiles" id="imgFile" required
						value="" accept=".gif, .jpg, .png"> <p class="upload_info">대표사진은 gif, jpg, png 형식의 파일만 업로드 가능합니다.</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">가격(원)</th>
					<td class="onlec_mg_list_td"><input type="number" name="price"
						value="" class="regi_input" placeholder="숫자만 입력 가능" min="1" max="9999999" required></td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>


			<!--구분-->
			<h4 class="h4h4">수업 자료 업로드</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">첨부파일</th>
					<td class="onlec_mg_list_td"><input type="file"
						name="lectureFiles" value=""> <!--<p class="upload_info">&check; 강의 자료가 여러 개라면 폴더에 모아 압축 파일로 한 번에 업로드해주세요.</p>-->

					</td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>


			<!--구분-->
			<h4 class="h4h4">수업 영상 업로드</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">영상 수</th>
					<td class="onlec_mg_list_td"><select class="onlec_select"
						name="videoQty">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select> &nbsp;&nbsp; <span class="choice">먼저 클래스 영상의 수를 선택해주세요!</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>
			<div class="video_box box1">
				<table class="add_video">
					<tr>
						<th colspan="2" class="border_td">1강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text"
							name="videoName" value="" class="video_input" maxlength="30" required></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo"
								rows="8" cols="80" id="textArVideo"
								placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)" required></textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file" id="videoFile"
							name="lectureFiles" value="" class="videos" accept="video/mp4" required>
							<p class="upload_info">강의 영상은 mp4 형식의 파일만 업로드 가능합니다.</p></td>
					</tr>
				</table>
			</div>
			<div class="video_box box2">
				<table class="add_video">
					<tr>
						<th colspan="2" class="border_td">2강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text"
							name="videoName" value="" class="video_input video_input2" maxlength="30"></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo"
								rows="8" cols="80" class="textArVideo textArVideo2"
								placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)"></textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file"
							name="lectureFiles" value="" class="videos videoFile videoFile2" accept="video/mp4">
							<p class="upload_info">강의 영상은 mp4 형식의 파일만 업로드 가능합니다.</p></td>
					</tr>
				</table>
			</div>
			<div class="video_box box3">
				<table class="add_video">
					<tr>
						<th colspan="2" class="border_td">3강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text"
							name="videoName" value="" class="video_input video_input3" maxlength="30"></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo"
								rows="8" cols="80" class="textArVideo textArVideo3"
								placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)"></textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file"
							name="lectureFiles" value="" class="videos videoFile videoFile3" accept="video/mp4">
							<p class="upload_info">강의 영상은 mp4 형식의 파일만 업로드 가능합니다.</p></td>
					</tr>
				</table>
			</div>
			<div class="video_box box4">
				<table class="add_video">
					<tr>
						<th colspan="2" class="border_td">4강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text"
							name="videoName" value="" class="video_input video_input4" maxlength="30"></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo"
								rows="8" cols="80" class="textArVideo textArVideo4"
								placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)"></textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file"
							name="lectureFiles" value="" class="videos videoFile videoFile4" accept="video/mp4">
							<p class="upload_info">강의 영상은 mp4 형식의 파일만 업로드 가능합니다.</p></td>
					</tr>
				</table>
			</div>
			<div class="video_box box5">
				<table class="add_video">
					<tr>
						<th colspan="2" class="border_td">5강</th>
					</tr>
					<tr>
						<td class="border_td tdtd">영상제목</td>
						<td class="border_td tdinput"><input type="text"
							name="videoName" value="" class="video_input video_input5" maxlength="30"></td>
					</tr>
					<tr>
						<td class="border_td tdtd">내용요약</td>
						<td class="border_td tdinput"><textarea name="videoInfo"
								rows="8" cols="80" class="textArVideo textArVideo5"
								placeholder="강의 영상에 대한 내용을 작성해주세요.(최대 200자)"></textarea></td>
					</tr>
					<tr>
						<td class="border_td tdtd">영상파일</td>
						<td class="border_td tdinput"><input type="file"
							name="lectureFiles" value="" class="videos videoFile videoFile5" accept="video/mp4">
							<p class="upload_info">강의 영상은 mp4 형식의 파일만 업로드 가능합니다.</p></td>
					</tr>
				</table>
			</div>

			<div class="submit_box">
				<input type="submit" name="" value="등 록 하 기" class="onlec_submit_btn" style="width: 50%; height: 50px; cursor:pointer;">
				<p style="margin-top: 10px; ">
					<a href="/mypage/online/onlecmgList">
						<input type="button" name="" value="취 소" class="onlec_submit_btn" style="background-color:#666; color: #fff; cursor:pointer;"/>
					</a>
				<p>
			</div>








		</form:form>



	</div>