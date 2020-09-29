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

h5{
	font-size: 90%;
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 250%;
}

h1 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 400%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

div.search {text-align =center;
	
}

.card {
	
}

div#review {
	background-color: rgb(228, 228, 228);
}

a {
	text-decoration: none;
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:active {
	color: black;
}

a:hover {
	color: black;
}
</style>
<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		popularSearch();
	})
	function popularSearch(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/popularSearchByAjax.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('.popular').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var output = "";
				output += "<div class='row'>";
				for (let i=0; i<3; i++) {
					console.log(jsonInfo[i].s_name);
					output += "<div style='margin: 20px'>";
					output += "<div class='card' style='width: 18rem;'>";
					output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
					output += "<img src='https://via.placeholder.com/150' class='card-img-top'alt='...'></a>";
					output += "<div class='card-body'><h5 class='card-title'><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>"+jsonInfo[i].s_name+"</a></h5>";
					output += "<p class='card-text'>"+jsonInfo[i].s_locate+"</p></div>";
					output += "<div class='card-body' id='review'>";
					output += "<p class='card-text'>";
					output += "<a href='#'>후기 "+jsonInfo[i].reviewCount+"건</a><br>";
					output += "<a href='#'>"+jsonInfo[i].shopReviewList[0].m_nickname+"</a>님의 후기 <br>";
					output += jsonInfo[i].shopReviewList[0].sr_score+"<br>";
					output += jsonInfo[i].shopReviewList[0].sr_content+"</p></div></div></div>";
				}
				output += "</div>";
				$('.popular').html(output);
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
			}
		});
	}




</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container my-5 center">
		<h1 align="center">우리동네 업체정보</h1><br><br><br>
		<div class="search" align="center">
			<form name="searchFrm" method="post"
				action="${contextPath }/shop/localShopSearch.do">
				<input type="hidden" name="searchCondition" value="ALLSEARCH" />
				<input type="text" placeholder="검색" name="searchKeyword" style="width:400px; height:30px;"> <input
					type="submit" value="&#xf002;">
			</form>
			<a href="#">#해쉬</a> <a href="#">#태그</a> <a href="#">#아직</a> <a
				href="#">#미구현</a>
			<br>
		</div>
		<br><br>
		<div class="category">
			<h3>카테고리로 찾기</h3>
			<div class="categoryList" align="center">
				<div class="row">
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=10"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=10">카페</a>
								</h5>
							</div>
						</div>
					</div>	
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=20"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=20">음식점</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=30"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=30">병원</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=40"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=40">학원</a>
								</h5>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=50"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=50">미용</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=60"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=60">마트/유통</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=70"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=70">공방/클래스</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=80"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=80">인테리어</a>
								</h5>
							</div>
						</div>
					</div>
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=90"><img src="https://via.placeholder.com/70" class="card-img-top"
								alt="..."></a>
							<div class="card-body">
								<h5 class="card-title">
									<a href="${contextPath }/shop/localShopSearch.do?filter=90">부동산</a>
								</h5>
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
		<br>
		<br>
		<h3>우리동네 인기업체></h3>
		<div class="popular">
				
		</div>
	</div>
</body>
</html>