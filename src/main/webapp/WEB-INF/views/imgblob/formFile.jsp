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
<form action="${contextPath}/saveImage2" enctype="multipart/form-data" method="post">
    <input type="file" name="imgFile" />
    <input type="text" name="text1" />
    <input type="submit" value="이미지저장"/>
</form>
</body>
</html>