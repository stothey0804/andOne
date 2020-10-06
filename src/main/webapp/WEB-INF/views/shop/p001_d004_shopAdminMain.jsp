<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업체관리자페이지</title>
</head>
<body>
	<h3>업체관리자페이지</h3>
	<h3>로그인 성공!!!!!!!!!!!!!!!!!!!</h3>
	${bMember.bm_name}님 안녕하세요<br>
	<button onclick="location.href='${contextPath}/biz/logout.do'">로그아웃</button>
</body>
</html>