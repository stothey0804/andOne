<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="eat" method="post" action="${contextPath}/project/p003_d001/eat/listAndOne.do">
	같이먹기 검색: <input type ="text" name="eat_id">
	<input type="submit" value="조회하기">
	</form>
</body>
</html>