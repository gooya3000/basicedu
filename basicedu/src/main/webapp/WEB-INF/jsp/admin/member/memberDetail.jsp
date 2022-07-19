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
			&rtrif;&nbsp;회원 관리 - 회원정보 상세
		</h3>
			<!--구분-->
			<h4 class="h4h4">회원 정보</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">구분</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">
							<c:if test="${member.memberCategory == 1 }">
									일반회원
							</c:if>
							<c:if test="${member.memberCategory == 2}">
									강사
							</c:if>
						</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">회원ID</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.id}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">회원명</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.name}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">연락처</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">
							<c:set var="phoneNumber" value="${member.phoneNumber}"/>
							<c:if test="${not empty phoneNumber}">
								${fn:substring(phoneNumber,0,3)}-${fn:substring(phoneNumber,3,7)}-${fn:substring(phoneNumber,7,11)}
							</c:if>
						</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">이메일</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.email}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">주소</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.address}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">인증</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.authstatus}</p>
					</td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">가입일시</th>
					<td class="onlec_mg_list_td">
						<p class="regi_input">${member.registerDate}</p>
					</td>
				</tr>
				<!--<tr>
					<th class="onlec_mg_list_th">프로필 사진</th>
					<td class="onlec_mg_list_td">
						<div class="regi_input" style="border: 0px solid #ddd; width: 200px; height: 200px; background-color: #000;
						border-radius: 5px; overflow:hidden;"><img src="/upload/onlec/thumb/${lectureInfo.lecturerImg}"/></div>
					</td>
				</tr>  -->
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>

			<!--구분-->
			<c:if test="${member.memberCategory == 2}">
			<h4 class="h4h4">강사 정보</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">소개</th>
					<td class="onlec_mg_list_td"><p class="regi_textarea" style="line-height:1.5;">${fn:replace(member.lecturerInfo,cn,br)}</p></td>
				</tr>
				<tr>
					<th class="onlec_mg_list_th">프로필</th>
					<td class="onlec_mg_list_td">
						<div class="regi_input" style="border: 0px solid #ddd; width: 200px; height: 200px; background-color: #000;
						border-radius: 5px; overflow:hidden; padding-left: 0; padding-right: 0;">
							<img src="/upload/lecturer/${member.lecturerImg}" style="width: 100%;"/>
						</div>
					</td>
				</tr>

				<tr>
					<td colspan="2" class="padding"></td>
				</tr>
			</table>
			</c:if>

			<!--구분-->
			<h4 class="h4h4">포인트 내역</h4>
			<table class="onlec_mg_list_table">
				<tr>
					<td class="padding"></td>
				</tr>

				<tr>

					<td class="onlec_mg_list_td">

						<table class="add_video">
							<tr>

								<th style="padding-bottom: 20px;" colspan="3">
									현재 포인트: <span style="color:red">
									<fmt:formatNumber type="number" maxFractionDigits="3" value="${member.point}"/> P
									</span>
								</th>

							</tr>


								<tr>
									<th class="border_td tdtd">번호</th><th class="border_td tdtd">내용</th>
									<th class="border_td tdtd">포인트</th>
								</tr>

								<c:if test="${size != 0}">
									<c:forEach var="result3" items="${point}" varStatus="status">

										<tr>
											<td class="border_td tdtd">${status.index+1 }</td>
											<td class="border_td tdtd">${result3.contents }</td>
											<td class="border_td tdtd">${result3.point }</td>


										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${size == 0}">
									<tr><td colspan="4" class="border_td tdtd">포인트 내역이 없습니다.</td></tr>
								</c:if>




						</table>

					</td>
				</tr>
				<tr>
					<td class="padding"></td>
				</tr>
			</table>


			<!--  <div class="submit_box">
				<p><a href="modify?onlineLectureNo=${lectureInfo.onlineLectureNo}"><input type="button" name="" value="수 정 하 기" class="onlec_submit_btn"></a></p>
				<p>
					<input type="button" name="" value="삭 제 하 기" class="onlec_submit_btn delLec" id="deleteBtn">
					<input type="hidden" name="" value="delete?onlineLectureNo=${lectureInfo.onlineLectureNo}" class="link">

				</p>
			</div>-->


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