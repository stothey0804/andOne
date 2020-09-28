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
		<div class="popular">
			<h3>우리동네 인기업체></h3>
			<div class="row">
				<c:forEach var="shop" items="${shopList}" begin="0" end="2" step="1">
					<div style="margin: 20px">
						<div class="card" style="width: 18rem;">
							<img src="https://via.placeholder.com/150" class="card-img-top"
								alt="...">
							<div class="card-body">
								<h5 class="card-title">
									<a href="#">${shop.s_name }</a>
								</h5>
								<p class="card-text">${shop.s_locate }</p>
							</div>
							<div class="card-body" id="review">
								<p class="card-text">
									<a href="#">후기 ${shop.reviewCount }건</a> 
									<br> 
									<a href="#">${shop.shopReviewList[0].m_id }</a>님의 후기 
									<br> 
									${shop.shopReviewList[0].sr_score } 
									<br> 
									${shop.shopReviewList[0].sr_content }
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>