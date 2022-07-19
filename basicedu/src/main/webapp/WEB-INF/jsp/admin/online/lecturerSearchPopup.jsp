<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/pagination.css">
<script src="/resources/js/search.js"></script>
<script>
	$(document).ready(function(){
		  window.resizeTo(580, 600);
	});

	$(function() {

		var condition = '${condition}';
		if(condition == "lecturerId"){
			$('.search_condition option:eq(0)').prop("selected", true);
			}else{
				$('.search_condition option:eq(1)').prop("selected", true);
				}
		var keyword = '${keyword}';
		$('.search_keword').val(keyword);

	});
</script>

</head>
<body>
	<form:form action="lecturerSearch" method="post" commandName="command" modelAttribute="command" id="searchFrm">

		<select class="search_condition" name="condition">
				<option value="lecturerId">강사ID</option>
				<option value="lecturerName">강사명</option>
		</select>
		<input type="text" value="${keyword}" name="keyword" class="search_keword"/>
		<input type="submit" value="강사검색" class="search_btn"/>
	</form:form>
	<table>
		<tr><th>번호</th><th>아이디</th><th>이름</th><th>선택</th></tr>
		<c:if test="${list == null}">
			<tr><td colspan="4" style="color:red;">강사를 검색해주세요.</td></tr>
		</c:if>
		<c:if test="${list != null}">
			<c:forEach var="result" items="${list}" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${result.id }</td>
				<td>${result.name }</td>
				<td><input type="radio" value="${result.id }" class="lecId" name="lecId"/></td>
			</tr>
		</c:forEach>
		<c:if test="${size==0 }">
			<tr><td colspan="4" style="color:red;">검색 결과가 없습니다.</td></tr>
		</c:if>
		<tr><td colspan="4"><input type="button" value="확인" id="chck" class="search_btn"/></td></tr>
		</c:if>


	</table>

	<c:if test="${fn:length(list) != 0 }">
		<div class="pagination_wrap">
			<div class="pagination">
				<c:set var="pageIndex" value="${pagination.pageIndex}" />
				<c:set var="totalPageCount" value="${pagination.totalPageCount}" />
				<c:url var="link" value="./list" />

				<c:if test="${pageIndex eq 1}">
					<a>이전</a>
				</c:if>
				<c:if test="${pageIndex ne 1}">
					<a href="${link}&pageIndex=${pageIndex-1}">이전</a>
				</c:if>
				<c:forEach var="num" begin="${pagination.firstPageNo}"
					end="${pagination.lastPageNo}">
					<c:choose>
						<c:when test="${pageIndex eq num}">
							<a class="active">${num}</a>
						</c:when>
						<c:otherwise>
							<a href="${link}&pageIndex=${num}">${num}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pageIndex eq totalPageCount}">
					<a>다음</a>
				</c:if>
				<c:if test="${pageIndex ne totalPageCount}">
					<a href="${link}&pageIndex=${pageIndex+1}">다음</a>
				</c:if>
			</div>
		</div>
	</c:if>

<style>
	table{
		width: 90%;
		margin: 0 auto;
		margin-top: 30px;
		}
		th, td{
		border: 1px solid #000;
		text-align: center;
		padding: 10px;
	}

	td{
		font-size: 14px;
	}
	.search_condition{

	  margin-top: 30px;
	  margin-left: 29px;
	  box-shadow:  1px 1px 12px 1px rgba(0, 0, 0, 0.1);
	  width: 120px;
	  padding: 7px;
	}
	.search_keword{
	  box-shadow:  1px 1px 12px 1px rgba(0, 0, 0, 0.1);
	  padding: 8px;
	  width: 282px;

	}
	.search_btn{
	  width: 80px;
	  background-color: #000;
	  padding: 10px;
	  line-height: 1;
	  font-weight: bold;
	  color: #fff;
	  box-shadow:  2px 2px 12px 2px rgba(0, 0, 0, 0.1);
	  border-radius: 5px;
	}
	#chck{
	 background-color: rgb(255,217,102);
	 color: #000;
	 width: 130px;
	}
</style>
<script>
	$(function(){
		$('#chck').click(function(){
			var id = $('input[name="lecId"]:checked').val();
			console.log(id);

			$("#lecId", parent.opener.document).val(id);
			self.close();

			});

		});
</script>
</body>
</html>