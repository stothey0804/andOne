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

input[type="submit"] {
	font-family: FontAwesome;
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 250%;
}

.searchClub {
	margin-top: 50px;
	text-align:center;
}

.text-bold {
	font-weight: bold;
}

.card:hover {
	top: -2px;
	box-shadow: 0 4px 5px rgba(0, 0, 0, 0.2);
	cursor: pointer;
}

.c_img{
	width: 100%;
	object-fit: cover;
	height: 270px;
}

</style>

<meta charset="UTF-8">
<title>소모임 검색 결과</title>
<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->
<script>
	$(document).ready(
			function() {
				var searchWord = '${searchWord}';
				console.log(searchWord);
				$(".result:contains('" + searchWord + "')").each(
						function() {
							var regex = new RegExp(searchWord, 'gi');
							$(this).html(
									$(this).text().replace(
											regex,
											"<span class='text-bold'>"
													+ searchWord + "</span>"))
						})
			})
</script>
</head>
<body>
	<form class="searchClub container center" name="searchFrm"
		method="post" action="${contextPath}/club/searchClub.do">
<a href="#">#운동</a> <a href="#">#산책</a> <a href="#">#볼링</a> <a href="#">#독서</a> <br>
		<input type="text" value="${searchWord}" name="searchWord"> <input
			type="submit" value="&#xf002;">
	</form>
	<br>
	<br>
	<div class="container center">
		<c:set var="cnt" value="${cnt }" />
		<c:choose>
			<c:when test="${cnt eq 0 }">
				<h3 style="text-align:center;">검색결과가 없습니다. 다른 검색어로 찾아보세요(ノω<。)ノ))☆.。</h3>
			</c:when>
			<c:otherwise>
				<h3 style="text-align: center">검색결과 ${cnt}건</h3>
			</c:otherwise>
		</c:choose>
		<c:forEach var="club" items="${resultList}">
			<div class="card my-3 center"
				style="max-width: 540px;">
				<div class="row no-gutters"
					onclick="location.href='${contextPath }/club/detailClub.do?c_id=${club.c_id}'">
					<div class="col-md-4" style="width: 500px">
						<c:set var="c_img" value="${club.resultImg}" />
						<c:choose>
							<c:when test="${c_img eq null}">
								<img
									src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg"
									class="card-img-top" alt="...">
							</c:when>
							<c:otherwise>
								<img src="data:image/jpg;base64, ${c_img}" class="c_img">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<h5 class="card-title result">${club.c_name}</h5>
							<p class="card-text result">${club.c_content}</p>
							<p class="card-text result">
								<small class="text-muted">카테고리 ${club.c_category }</small>
							</p>
							<p class="card-text result">
								<small class="text-muted">#${club.c_hashtag }</small>
							</p>
							<p class="card-text">
								<small class="text-muted">함께하는 사람 ${club.c_membercnt }</small>
							</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>