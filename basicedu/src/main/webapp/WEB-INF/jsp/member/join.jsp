<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="/resources/css/common.css">

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<div class="join_wrap">
	<h1 id="join">회원가입</h1>

		<a href="./nomalJoin"><button type="button" onclick="joinBtn();" style="width: 222px; height: 50px; margin-top: 100px; background-color: #2c77bc; border-radius: 5px; font-size: large; font-weight: bold; color:#ffffff;">일반회원으로 가입하기</button></a>
		<div style="width:222px; margin: 0 auto; margin-top: 10px; margin-bottom: 10px;"><a id="kakao-login-btn" href="javascript:;" ></a></div>
		<a href="/" class="btn is-grey ml5" onclick="return confirm('회원가입을 취소하시겠습니까?');">돌아가기</a>

</div>



<script>
$(function() {
	Kakao.init('5e7ec9586360743077c6de6e5fbd3fa2');
	Kakao.isInitialized();

	console.log("Kakao.isInitialized()", Kakao.isInitialized());

	Kakao.Auth.createLoginButton({
		container: '#kakao-login-btn',
		success: function(response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function(response) {
					var userID = response.id;
					var useEmail = response.kakao_account.email;
					var useNickName = response.properties.nickname;

					$.post('./idCheck', {'id':useEmail}, function(result) {
						if(result == "success") {

							document.write('<form action="./kakaoJoin" id="form" method="post"><input type="hidden" id="id" name="id" value="'+ useEmail +'"><input type="hidden" name="name" name="name" value="'+ useNickName +'"></form>');
							document.getElementById("form").submit();

						} else {
							alert('이미 가입된 카카오 회원입니다.');
						}
					});

					console.log("userID", userID);
					console.log("useEmail", useEmail);
					console.log("useNickName", useNickName);

				},
				fail: function(error) {
					console.log("request fail", error);
				}
			});

		},
		fail: function(error) {
			console.log("fail", error);
		},
	});

});



</script>