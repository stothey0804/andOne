<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="fileForm" action="${contextPath}/requestupload1" method="post" enctype="multipart/form-data">
		<input type="file" name="file" />
		<input type="text" name="src" />
		<input type="submit" value="전송" />
	</form>
</body>
</html>
