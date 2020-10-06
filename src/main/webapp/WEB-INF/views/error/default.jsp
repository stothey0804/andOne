<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
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
		<h2 class="mt-2">에러가 발생했습니다 :(</h2>
		<p>이용에 불편을 드려 대단히 죄송합니다.</p>
		<a href="${contextPath}/" class="btn btn-primary mt-4">메인페이지로</a>
	</div>
</body>
</html>