<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<h1 class="top_logo">
		<a href="/"><img src="/resources/images/logo.png" alt="logo"></a>
	</h1>
	<ul class="top_menu clearfix">
		<!-- 로그인 전 -->
		<sec:authorize access="isAnonymous()">
			<!-- 관리자로 로그인 시 -->
			<a href="/admin/login"><li class="top_menu_li">관리자</li></a>

			<a href="/member/join"><li class="top_menu_li">회원가입</li></a>
         	<a href="/member/login"><li class="top_menu_li">로그인</li></a>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/admin/member/list"><li class="top_menu_li">관리자</li></a>
			<a href="/admin/logout"><li class="top_menu_li">로그아웃</li></a>
		</sec:authorize>

		<!-- 로그인 후 -->
		<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_TEACHER')">
			<!-- 관리자 및 일반 회원 로그인 시 -->
          	<a href="/mypage/member/memberCertify"><li class="top_menu_li">마이페이지</li></a>
          	<a href="/shoppingBasket/list"><li class="top_menu_li">장바구니</li></a>
          	<a href="/member/logout"><li class="top_menu_li">로그아웃</li></a>
		</sec:authorize>
	</ul>
</div>
