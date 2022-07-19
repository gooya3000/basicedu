<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<h1 class="top_logo">
		<a href="/admin/member/list"><img src="/resources/images/logo.png" alt="logo"></a>
	</h1>

	<ul class="top_menu clearfix">
		<a href="/"><li class="top_menu_li">사이트로 이동</li></a>

		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<!-- 관리자 로그인 시 -->
          	<a href="/admin/logout"><li class="top_menu_li">로그아웃</li></a>
		</sec:authorize>
	</ul>
</div>
