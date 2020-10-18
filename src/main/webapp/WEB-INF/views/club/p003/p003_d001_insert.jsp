<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
.left{
	float:left;
	cursor:pointer;
}
.info{
	margin-right:15px;
}

input[type="submit"] {
	margin: 0 auto;
}
.c_img {
	height: 100%;
	width: 100%;
	object-fit: cover;
}
.btn-success:hover {
    background-color: #00033D !important;
}
.btn-success{
	background-color:#002A87 !important;
	border-color:#002A87;
	color:white;
}
</style>

<body>
<div class="container my-5 center">
		<div class="left">
			<div class="card info" style="width: 18rem;" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${clubInfo.c_id}'">
			<c:set var="c_img" value="${clubImg}"/>
			<c:choose>
			<c:when test="${c_img eq ''}">
					<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img-top" alt="...">
				</c:when>
				<c:otherwise>
					<img src="data:image/jpg;base64, ${c_img}" class="c_img">
				</c:otherwise>
			</c:choose>
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
				</div>
			</div>
		</div>
</div>
<div class="container my-5 center">
<form action="${contextPath}/club/writeArticle.do" method="post" enctype="multipart/form-data">
	<textarea class="form-control col-sm-5" rows="13" name="ca_content">${articleInfo.ca_content }</textarea><br>
	<script>CKEDITOR.replace('ca_content')</script>
	<div class="btn" style="width:462px;">
	<input multiple="multiple" type="file" accept="image/*" name="ca_img"/>
	<br>
	<br>
	<input type="hidden" name="c_id" value="${clubInfo.c_id }">
	<input type="hidden" name="m_id" value="${member.m_id }">
	<input type="submit" class="btn btn-success btn-block"></div>
</form>
</div>

</body>
</html>