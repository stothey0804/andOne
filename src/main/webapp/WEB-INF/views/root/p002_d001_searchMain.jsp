<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script type="text/javascript">
 
</script>
<style type="text/css">
    
</style>
</head>
<body>
	<div class="container my-5 center">
		<form class="form-horizontal">
			<div class="form-group">
				<input type="text" name="searchKeyword" class="form-control input-lg" />
				<button type="submit" class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>
</body>
</html>