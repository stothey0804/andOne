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
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 250%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

.search {
	text-align: center;
}

.create {
	width: 350px;
	margin: auto;
}
body{
	background: white;
}
.card,.mainClub{
	background:#f5f7f8;
}

.mainClub:hover{
	top: -2px;
  	box-shadow: 0 4px 5px rgba(0,0,0,0.2);
  	cursor: pointer;
}

.card:hover{
	top: -2px;
  	box-shadow: 0 4px 5px rgba(0,0,0,0.2);
  	cursor: pointer;
}

.btn-outline-info{
    border-color: #002A87;
    color: #002A87;
}

.btn-outline-info:hover,
.btn-outline-info:focus {
    border-color: #002A87;
    background-color: #002A87;
    color: #FFF; }
</style>
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container my-5 center">
		<h3>인기 소모임></h3>
		<br>
		<div class="row">
			<c:forEach var="club" items="${clubList}">
				<div class="col-sm-6 mb-3 mainClub" onclick="location.href='${contextPath }/detailClub.do?c_id=${club.c_id}'"
					style="max-width: 540px; margin-left: 25px;padding:0">
					<div class="row no-gutters">
						<div class="col-sm-6">
							<img src="https://t1.daumcdn.net/cafeattach/1IHuH/76e8170e8985e795b1536d4d7ca4224247e71a5c" class="card-img"
								alt="...">
						</div>
						<div class="col-sm-6">
							<div class="card-body" style="height: 225px">
								<h5 class="card-title" style="height: 20%">${club.c_name}</h5>
								<p class="card-text" style="height: 40%">${club.c_content}</p>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">${club.c_category}</small>
								</p>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">함께하는 사람 ${club.c_membercnt}</small>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="container my-5 center">
		<div class="search">
			<a href="#">#운동</a> <a href="#">#산책</a> <a href="#">#볼링</a> <a
				href="#">#독서</a> <br>
			<form name="searchFrm" method="post"
				action="${contextPath }/club/p001/searchClub.do">
				<input type="text" placeholder="검색" name="searchWord"> <input
					type="submit" value="&#xf002;">
			</form>
			<br>
			<p style="font-size: 18px;">원하시는 소모임이 없나요? 한번 만들어보세요!</p>
			<button type="button"
				class="btn btn-outline-info btn-block search create"
				style="font-size: 18px;"
				onclick="location.href='${contextPath}/createClub.do'">소모임
				만들기</button>
		</div>
		<br>

		<h3>나의 소모임></h3>
		<c:set var="myClubCnt" value="${myClubCnt}" />
		<c:choose>
			<c:when test="${myClubCnt eq 0}">
				<div class="card">
					<div class="card-body" style="text-align: center;">가입된 소모임이
						없습니다. 함께 해봐요!</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<c:forEach var="club" items="${myClubList}">
						<div class="club"
							style="margin-left: 45px; margin-right: 45px; margin-top: 20px" onclick="location.href='${contextPath }/detailClub.do?c_id=${club.c_id}'">
							<div class="card" style="width: 18rem;">
								<img src="https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg" class="card-img-top"
									alt="...">
								<div class="card-body">
									<h5 class="card-title">${club.c_name }</h5>
									<p class="card-text">함께하는 사람 ${club.c_membercnt }</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>