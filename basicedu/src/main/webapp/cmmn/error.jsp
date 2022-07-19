<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>광클</title>
	<style>
	* { padding: 0; margin: 0; }
	body { font-size: 16px; }
	h1 { font-size: 26px; }
	h1 em { color: #ff4e00; }
	.error_wrap { margin-top: 15%;}
	.error_box {
		width: 470px;
		margin: 0 auto;
		padding: 20px;
		border: 1px solid #e5e4e1;
	}
	p { margin-top: 3px; }
	</style>
</head>
<body>
	<div class="error_wrap">
		<div class="error_box">
			<div class="error_msg">
				<h1>페이지가 <em>없거나 잘못된 경로</em>입니다.</h1>
				<p>경로를 다시 확인하시고 이용해 주시기 바랍니다.</p>
				<p>이용에 불편을 드려 대단히 죄송합니다.</p>
			</div>
		</div>
	</div>
</body>
</html>