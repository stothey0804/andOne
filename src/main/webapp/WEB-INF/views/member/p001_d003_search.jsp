<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
	div.form-group{
		width: 450px;
		margin: 0 auto;
		margin-top: 100px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	
</style>
</head>
<body>
	<div class="container">
		<h2 class="m-5">비밀번호 찾기</h2>
		<hr class="m-5">
			<div class="m-5">
			<svg width="5em" height="5em" viewBox="0 0 16 16" class="bi bi-check-circle-fill text-success" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
			</svg>
			<h1 class="mt-4 mb-2">전송이 완료됐습니다.</h1>
			<h5>메일을 확인해주세요.</h5>
			<a href="${contextPath}/" class="btn btn-primary mt-4">메인으로 이동</a>
		</div>
	</div>
</body>
</html>