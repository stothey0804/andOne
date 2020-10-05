<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdn.ckeditor.com/ckeditor5/22.0.0/classic/ckeditor.js"></script>
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
h2{
	font-family: 'YanoljaYacheR' !important;
	font-size: 300%;
	text-align:center;
}
</style>
<script>
	
</script>
</head>
<body>
<h2>소모임이 개설되었습니다.</h2><br>
  <button type="button" class="btn btn-primary"
   	onclick="location.href='${contextPath}/detailClub.do?c_id=${c_id}'">만든 소모임 확인하기</button>
  <button type="button" class="btn btn-primary"
   	onclick="location.href='${contextPath}/club/clubMain.do'">만든 소모임 확인하기</button>
</body>
</html>
