<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<style type="text/css">
	.login-form{
		width: 300px;
    	position: absolute;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%, -50%);
	}
	h1.logotype{
		font-size: 4em;
	}
	.login-form input[type="email"]{
		margin-bottom: -1px;
		border-bottom-right-radius: 0;
		border-bottom-left-radius: 0;
	}
	.login-form input[type="password"]{
		border-top-right-radius: 0;
		border-top-left-radius: 0;
	}
</style>
<script type="text/javascript">
	function init(){
		// warning 메시지  존재시
		var warning = '${warning}';
		if(warning!='' && warning!=null){
			alert(warning);
		}
	}
</script>
</head>
<body onload="init()" class="text-center bg-light">
	<div class="login-form m-auto">
		<form action="${contextPath}/member/login.do" method="post">
			<a href="${contextPath}/"><h1 class="logotype">&분의일</h1></a>
			<p class="h5 mb-4 font-weight-normal">로그인페이지</p>
			<label for="inputEmail" class="sr-only">이메일주소</label>
			<input type="email" id="inputEmail" class="form-control" placeholder="이메일 주소" required="" autofocus="" name="email">
			<label for="inputPassword" class="sr-only">비밀번호</label>
			<input type="password" id="inputPassword" class="form-control" placeholder="비밀번호" required="" name="pwd">
		    <button class="btn btn-lg btn-primary btn-block mt-2" type="submit">로그인</button>
		</form>
		    <p class="m-3"><a class="text-muted" herf="#">비밀번호를 잊으셨나요?</a></p>
		    <a class="btn btn-lg btn-outline-primary btn-block" href="./join.do">회원가입</a><p class="mt-5 mb-3 text-muted">© 2020 능력있는사람들</p>
	</div>
</body>
</html>