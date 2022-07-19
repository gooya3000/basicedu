<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/reset.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/side_nav.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

</head>
<body>
	<section>
      <h2 class="my_page_h2">마이페이지</h2>
      <ul class="mypage">
        <a href="#"><li class="sd_nav_li my_on">회원정보 수정</li></a>
        <a href="#"><li class="sd_nav_li">내 클래스</li></a>
        <a href="#"><li class="sd_nav_li">클래스 관리</li></a>
        <a href="#"><li class="sd_nav_li">상품 관리</li></a>
        <a href="#"><li class="sd_nav_li">상품 구매내역</li></a>
      </ul>
    </section>

</body>
</html>