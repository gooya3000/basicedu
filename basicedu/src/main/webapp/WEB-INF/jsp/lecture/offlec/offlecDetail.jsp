<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/search.css">
<link rel="stylesheet" href="/resources/css/onlec_detail.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="/resources/js/chap_box.js"></script>

<div class="onlec_thums">
	<table class="thum_table">
		<tr>
			<td rowspan="7">
				<div class="detail_img">
					<img src="/upload/offline/${result.offline_lecture_img}" alt="">
				</div>
			</td>
			<td colspan="2" class="detail_td"><h2 class="detail_h2">${result.offline_lecture_name}<span
						class="lec_num"></span>
				</h2></td>
		</tr>
		<tr>
		<tr>
			<td colspan="2" class="line_td"><div class="line"></div></td>
		</tr>
		<tr>
			<td class="detail_td detail_price_com">클래스 하는 곳</br> </br>강의 신청 기간
			</td>
			<td class="detail_td detail_price detail_price_com"><span>${result.offline_lecture_address }</br>
					</br> ${result.offline_lecture_applyperiodstart} ~
					${result.offline_lecture_applyperiodend}
			</span></br></td>
		</tr>
		<tr>
			<td colspan="2" class="line_td"><div class="line"></div></td>
		</tr>
		<tr>
			<td colspan="2" class="detail_td"><c:if test="${check eq 0}">
					<c:if test="${result.offline_lecture_applyperiodend<=curTime}">
						<input type="button" name="" value="신 청 기 간 만 료" class="detail_btn">

					</c:if>

					<c:if test="${nowPeople lt maxPeople && result.offline_lecture_applyperiodend>curTime}">
						<input type="button" name="" id="apply" title="${result.offline_lecture_NO}" value="수 강 신 청" class="detail_btn" style="cursor: pointer;">
					</c:if>
					<c:if test="${nowPeople-rejectPeople ge maxPeople && result.offline_lecture_applyperiodend>curTime}">
							<input type="button" name="" value="신 청 마 감" class="detail_btn">

					</c:if>

				</c:if> <c:if test="${check>0}">
					<c:if test="${result.offline_lecture_applyperiodend<=curTime}">
							<input type="button" name="" value="기 간 만 료" class="detail_btn">
					</c:if>

					<c:if test="${result.offline_lecture_applyperiodend>curTime}">
						<a
							href="./offlec_myApplication?application_no=${check}&offline_lecture_NO=${result.offline_lecture_NO}"
							onclick="window.open(this.href,'_blanck','width=600, height=700');return false">
							<input type="button" name="" value="내 신청서 보기" class="detail_btn">
						</a>
					</c:if>
				</c:if></td>
		</tr>
	</table>
	<input type="hidden" value="${result.offline_lecture_NO}"
		id="offlecNum">

	<h2 class="small_title">클래스 소개</h2>
	<table class="chap_table">

		<tr>
			<div class="comment_output"><p style="white-space: pre-line; line-height: 25px; font-weight: 500;">${result.offline_lecture_introduce}</p></div>

		</tr>


	</table>

	<h2 class="small_title">강사정보 </h2>
	<table>

		<tr>
			<td class="lecturer_box">
				<div class="lecturer_img">
					<img src="/upload/lecturer/thumb/${img}" alt="sample">
				</div>
				<h3 class="lecturer_name"></h3>
				<p class="lecturer_info"></p><a href="./offlecSearch?searchCondition=lecName&search_keyword=${member.name}"> <input type="button" name=""
				value="강사님의 다른 클래스 보러가기" class="another_class"></a>
			</td>
		</tr>
	</table>

	<h2 class="small_title">수강후기</h2>
	<div class="comment_output">

		<c:if test="${reviewSize == 0}">
        		<p style="font-weight: 700; text-align: center;">등록된 후기가 없습니다.</p>
        	</c:if>
        	<c:if test="${reviewSize != 0 }">
        		<ul>
        		  <c:forEach var="list" items="${list}" varStatus="status">
        			<li>
        				<h5 style="margin-bottom: 10px;margin-top: 10px;margin-left: 5px; font-size:16px;">${list.id}
        				<span style="font-size:14px; color: #999; font-weight: normal;"><fmt:formatDate value="${list.registerDate}" pattern="yyyy-MM-dd"/></span></h5>
        				<div id="${list.reviewNo}" style="
        					padding: 10px;
        					background-color: #fff;
        					border-radius: 5px;
        					line-height: 1.5;
        					box-shadow:  1px 1px 12px 1px rgba(0, 0, 0, 0.1);
        					margin-bottom:25px;
        				"><p style="white-space: pre-line; line-height: 25px; font-weight: 500;">${list.contents}</p>


        					<c:if test="${id eq list.id }">
        						<div style="margin-top: 10px;">
	        						<input type="button" name="mdfReview" class="reviewBtn updateReview" value="수정" title="${list.contents}" id="${list.reviewNo}"/>
	        						<input type="button" name="delReview" class="reviewBtn delReview"  value="삭제" title="${list.reviewNo}"/>
	        					</div>
        					</c:if>

        				</div>
							<div id="con${list.reviewNo}"></div>

        			</li>
        		  </c:forEach>
        		</ul>
        	</c:if>

	</div>

	<c:if test="${id ne null}">
		<input type="hidden" value="${id}" id="loginId">
	</c:if>

	<!--수강중인 회원에게만 보이는 인풋박스-->
	<c:if test="${check>0}">
		<form role="form" method="post" autocomplete="off">
			<div class="comment_input_box">
				<textarea name="name" rows="8" cols="80" class="comment_input"
					id="contents"></textarea>
				<button type="button" id="reply_btn" class="another_class1">등록</button>
			</div>
		</form>
	</c:if>


	<h2 class="small_title">
		<c:if test="${check eq 0}">
					<c:if test="${result.offline_lecture_applyperiodend<=curTime}">
						<input type="button" name="" value="신 청 기 간 만 료" class="detail_btn">

					</c:if>

					<c:if test="${nowPeople lt maxPeople && result.offline_lecture_applyperiodend>curTime}">
							<input type="button" name="" id="apply2" title="${result.offline_lecture_NO}" value="수 강 신 청" class="detail_btn" style="cursor: pointer;">
					</c:if>
					<c:if test="${nowPeople-rejectPeople ge maxPeople && result.offline_lecture_applyperiodend>curTime}">
							<input type="button" name="" value="신 청 마 감" class="detail_btn">

					</c:if>

				</c:if> <c:if test="${check>0}">
					<c:if test="${result.offline_lecture_applyperiodend<=curTime}">
							<input type="button" name="" value="기 간 만 료" class="detail_btn">
					</c:if>

					<c:if test="${result.offline_lecture_applyperiodend>curTime}">
						<a
							href="./offlec_myApplication?application_no=${check}&offline_lecture_NO=${result.offline_lecture_NO}"
							onclick="window.open(this.href,'_blanck','width=600, height=700');return false">
							<input type="button" name="" value="내 신청서 보기" class="detail_btn">
						</a>
					</c:if>
				</c:if>
	</h2>

</div>

<script>
	$("#reply_btn").click(function() {

		var contents = $("textarea#contents").val();
		var keyNo = ${result.offline_lecture_NO};

		$.ajax({
			url : "/offlineClass/replyInsert",
			type : "post",
			traditional : true,
			data : {
				contents : contents,
				keyNo : keyNo
			},
			success : function(data) {
				alert("등록되었습니다.");
				location.reload();
			}
		});
	});

	$(".delReview").click(function() {
		var id = $("#loginId").val();
		var reviewNo = $(this).attr('title');
		var result = confirm("정말 삭제하시겠습니까?");
		if(result){
		 	$.ajax({
				url : "/mypage/review/delete",
				type : "post",
				traditional : true,
				data : {
					id : id,
					reviewNo : reviewNo
				},
				success : function(data) {
					alert("삭제되었습니다.");
					location.reload();
				}
			});
		}
	});

	$(".updateReview").click(function() {
		//$("#reviewCotents").remove();
		var contents = $(this).attr('title');
		var reviewNo = $(this).attr('id');
		$("#"+reviewNo).hide();
		var html = '<textarea name="name" rows="4" cols="40" class="comment_input" id="contents2">'+contents+'</textarea> <button type="button" id="replyUpCancel" class="btn is-blue" title='+reviewNo+'>취소</button> <button type="button" id="replyUpOk" class="btn is-blue" title='+reviewNo+' >수정</button>';

		console.log(reviewNo);


		$("#con"+reviewNo).append(html);

	});

	$(document).on("click","#replyUpCancel",function(){
		var reviewNo = $(this).attr('title');
		$("#con"+reviewNo).empty();
		$("#"+reviewNo).show();
	});


	$(document).on("click","#replyUpOk",function(){
		var contents = $("textarea#contents2").val()
		var reviewNo = $(this).attr('title');
		var result = confirm("수정 하시겠습니까?");

		if(result){
		 	$.ajax({
				url : "/mypage/review/update",
				type : "post",
				traditional : true,
				data : {
					contents : contents,
					reviewNo : reviewNo
				},
				success : function(data) {
					alert("수정되었습니다.");
					location.reload();
				}
			});
		}
	});


	$("#apply").click(function() {
		var fn = $(this).attr('title');

		document.write('<form action="./offline_application" id="smb_form" method="post"><input type="hidden" id="offline_lecture_NO" name="offline_lecture_NO" value="'+ fn +'"></form>');
		document.getElementById("smb_form").submit();
	});

	$("#apply2").click(function() {
		var fn = $(this).attr('title');

		document.write('<form action="./offline_application" id="smb_form" method="post"><input type="hidden" id="offline_lecture_NO" name="offline_lecture_NO" value="'+ fn +'"></form>');
		document.getElementById("smb_form").submit();
	});

</script>

