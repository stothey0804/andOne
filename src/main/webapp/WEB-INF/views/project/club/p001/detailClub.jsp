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
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
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
	margin-top:0;
	position:fixed;
}

.right{
	margin-left:300px;
	margin-top:17px;
}
.card-title,.pin,.card-subtitle{
	display:inline-block;
	margin-left:10px;
}
.art-title{
	width:330px;
	position:absolute;
}

.pin{
	width:30px;
	position: absolute;
	top: 20px;
    right: 20px;
}
.card-subtitle{
	margin-top:10px;
}

svg{
	fill:#ffcc00;
	display:inline-block; 
}
.show{
	position:fixed;
}
</style>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="container my-5 center top">
		<div class="left">
			<div class="card info" style="width: 18rem;">
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
			<div class="card article">
				<div class="card-header">${clubInfo.c_name }</div>
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_content }</h5>
				</div>
			</div>
			<c:forEach var="club" items="${clubInfo.articleList }">
			<div class="card" style="width: 500px;height:300px">
				<div class="card-body">
					<img style="position:relative;border-radius: 70px;
								-moz-border-radius: 70px;
								-khtml-border-radius: 70px;
								-webkit-border-radius: 70px;width:70px;height:70px;"
								src="https://www.vettedpetcare.com/vetted-blog/wp-content/uploads/2017/09/How-To-Travel-With-a-Super-Anxious-Cat-square.jpeg" />
					<h5 class="card-title art-title">${club.m_id }</h5>
					<c:set var="ca_pin" value="${club.ca_pin }"/>
					<c:choose>
						<c:when test="${ca_pin eq 1}">
					<div class="pin">
						<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-bookmark-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd" d="M4 0a2 2 0 0 0-2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4zm4.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098L8.16 4.1z"/>
						</svg>
							</div>		
						</c:when>
					</c:choose>
					<h6 class="card-subtitle mb-2 text-muted">${club.ca_date }</h6>
					<p class="card-text" style="margin-top:10px;">${club.ca_content }</p>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>