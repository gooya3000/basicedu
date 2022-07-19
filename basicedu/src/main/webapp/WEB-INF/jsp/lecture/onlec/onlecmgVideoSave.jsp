<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="/resources/css/mypage_lecture_mg_online_regi.css">
<script src="/resources/js/add_video.js"></script>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/js/add_my_on2.js"></script>

<ul class="lecture_ch clearfix">
	<a href="/mypage/offline/list">
		<li class="lecture_ch_li">오프라인</li>
	</a>
	<a href="/mypage/online/onlecmgList"><li class="lecture_ch_li mg_on">온라인</li></a>
</ul>

<div class="onlec_mg_list">
	<form:form action="onlecmgRegistPro" method="post" name="frm"
		commandName="onlecMgCommand" enctype="multipart/form-data"
		modelAttribute="onlecMgCommand">
		<!--구분-->

		<h4 class="h4h4">클래스 정보 입력</h4>


		<div class="submit_box">
			<input type="submit" name="" value="목 록 으 로" class="onlec_submit_btn">
		</div>








	</form:form>



</div>