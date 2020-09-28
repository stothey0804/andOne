<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	div.inner{
		margin-top:	6em;
		margin-bottom: 10em;
	}
</style>
</head>
<body>
	<div class="container col-lg-6 col-sm-10 mx-auto">
		<div class="inner">
			<svg width="5em" height="5em" viewBox="0 0 16 16" class="bi bi-check-circle-fill text-success" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
			</svg>
			<h1 class="mt-4 mb-2">회원가입이 완료되었습니다.</h1>
			<h5>로그인 후 이용하실 수 있습니다.</h5>
			<a href="${contextPath}/member/login.do" class="btn btn-primary mt-4">로그인페이지로 이동</a>
		</div>
	</div>
</body>
</html>