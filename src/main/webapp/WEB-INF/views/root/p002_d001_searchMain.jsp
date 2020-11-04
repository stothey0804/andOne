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
    i.fas.fa-search{
		font-size: 150%; 
		color: #4da6ff;
    }
    
    div.hkim-1{
    	margin-top:6%;
    	margin-bottom:20%;
    	text-align: center;
    }
    
    div.innerBox{
    	display:inline-block;
    	
    }
</style>
</head>
<body>
	<div class="container-fluid hkim-1">
		<div class="innerBox">
			<img src="${contextPath }/resources/image/logo.png" width="360">
		</div><br><br>
		<div class="innerBox">
			<form class="form-inline" method="post" action="${contextPath }/fullSearch.do">
			<div class="form-group">
				<label for="searchKeyword" class="sr-only">검색어</label>
				<div class="input-group">
					<input type="text" id="searchKeyword" name="searchKeyword" 
						class="form-control input-lg" placeholder="키워드를 입력해주세요"/>
				</div>
			</div>
			&nbsp;<button type="submit" class="btn btn-primary">검색</button>
			</form>
		</div>
	</div>
</body>
</html>