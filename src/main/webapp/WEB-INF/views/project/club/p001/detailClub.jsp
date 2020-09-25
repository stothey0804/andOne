<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.left,.right {
	display: inline-block;
	margin: 0;
	width:500px;
}
.left{
	position:fixed;
	left:150px;
	top:150px;
}

.right{
	margin-left:300px;
	margin-top:17px;
}
.card-title,.pin{
	display:inline-block;
}
.card-title{
	width:428px;
}

.pin{
	width:30px;
}
</style>
</head>
<body>
	<div class="container my-5 center">
		<div class="left">
			<div class="card" style="width: 18rem;">
				<img src="https://static.toiimg.com/photo/msid-76940605/76940605.jpg?758247" class="card-img-top"
					alt="...">
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
					<a href="#" class="btn btn-warning btn-primary btn-block"
						style="margin-top: 3px;">글쓰기</a>
				</div>
			</div>
		</div>
		<div class="right">
			<div class="card">
				<div class="card-header">${clubInfo.c_name }</div>
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_content }</h5>
							<div class="pin"><i class="far fa-thumbtack"></i></div>
				</div>
			</div>
			<c:forEach var="club" items="${clubInfo.articleList }">
			<div class="card" style="width: 500px;height:300px">
				<div class="card-body">
					<h5 class="card-title">${club.m_id }</h5>
					<c:set var="ca_pin" value="${club.ca_pin }"/>
					<c:choose>
						<c:when test="${ca_pin eq 1}">
							<i class="far fa-thumbtack"></i>
						</c:when>
					</c:choose>				
					<h6 class="card-subtitle mb-2 text-muted">${club.ca_date }</h6>
					<p class="card-text">${club.ca_content }</p>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>