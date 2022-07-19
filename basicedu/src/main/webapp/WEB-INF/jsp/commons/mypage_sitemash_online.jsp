<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>광클</title>
<link rel="stylesheet" href="/resources/css/reset.css">
    <link rel="stylesheet" href="/resources/css/header.css">
    <link rel="stylesheet" href="/resources/css/nav.css">
    <link rel="stylesheet" href="/resources/css/search.css">
    <link rel="stylesheet" href="/resources/css/side_nav.css">
    <link rel="stylesheet" href="/resources/css/pagination.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<header><jsp:include page="./include/header.jsp" /></header>

	<nav><jsp:include page="./include/nav.jsp" /></nav>

	<!--콘텐츠영역 시작-->
	<div id="contents" class="container clearfix">
		<section>
			<h2 class="my_page_h2">마이페이지</h2>
			<ul class="mypage">
				<a href="/mypage/member/memberCertify"><li class="sd_nav_li">회원정보 수정</li></a>
				<a href="/mypage/offline/offlineMylecture"><li class="sd_nav_li" id="myClass">내 클래스</li></a>
			<sec:authorize access="hasAnyRole('ROLE_TEACHER')">
				<a href="/mypage/offline/list"><li class="sd_nav_li" id="classMg">클래스 관리</li></a>
				<a href="/mypage/product/list"><li class="sd_nav_li">상품 관리</li></a>
			</sec:authorize>
				<a href="/mypage/purchaseHistory/list"><li class="sd_nav_li">상품 구매내역</li></a>
        	</ul>
      	</section>

		<div class="my_page_contents">
			<div>
				<sitemesh:write property='body'/>
			</div>
      	</div>
    </div>


</body>
</html>