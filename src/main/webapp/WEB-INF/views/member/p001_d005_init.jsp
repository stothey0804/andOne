<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 체크</title>
<style>
	div.form-group{
		width: 300px;
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
		<h2 class="m-5">내 정보 변경</h2>
		<hr class="m-5">
		<form action="${contextPath}/member/checkUserPwd.do" class="" method="post">
			  <div class="form-group">
			  	<input type="hidden" name="m_id" value="${member.m_id}">
			    <label for="InputPassword">비밀번호 확인</label>
			    <input type="password" class="form-control" id="InputPassword" name="inputPwd">
				<button type="submit" class="btn btn-primary mt-2">확인</button>
			  </div>
		</form>
	</div>
</body>
</html>