<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 변경 완료</title>
<style type="text/css">
	div.form-group{
		width: 650px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	.container{
		margin: 0 auto;
	}
	h1.logotype{
		font-size: 5rem;
	}

</style>
<!-- Custom Source CSS -->
 <link rel="stylesheet" href="${contextPath}/resources/css/font.css">
 <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
 <!-- bootstrap -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
	<div class="container m-5">
		<h1 class="logotype">&분의일</h1>
		<h2 class="mt-2">비밀번호 변경이 완료되었습니다.</h2>
		<a href="${contextPath}/member/login.do" class="btn btn-primary mt-4">로그인페이지로 이동</a>
	</div>
</body>
</html>