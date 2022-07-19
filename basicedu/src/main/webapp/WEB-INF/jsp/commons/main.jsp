<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>광클</title>
  	<link rel="stylesheet" href="/resources/css/reset.css">
    <link rel="stylesheet" href="/resources/css/header.css">
    <link rel="stylesheet" href="/resources/css/nav.css">
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
    <div id="contents" class="container">
    	<div class="mt30">
			<sitemesh:write property='body'/>
		</div>
    </div>

    <script>
	$(function() {
		var url = document.location.href;
		$(".nav_ul a").each(function(i) {
			$a = $(this);
			$href = $a.attr('href').split('/')[1];
			if(url.indexOf($href) != -1) {
				$a.children('li').addClass('on');
			}
		});
	});
    </script>
</body>
</html>