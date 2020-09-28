<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>

<head>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		@font-face {
			font-family: 'YanoljaYacheR';
			src:
				url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff') format('woff');
			font-weight: normal;
			font-style: normal;
		}

		h3 {
			font-family: 'YanoljaYacheR' !important;
			font-size: 200%;
		}

		input[type="submit"] {
			font-family: FontAwesome;
		}

		div.search {
			text-align: center;

		}

		.card {}

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
		$(document).ready(function () {
			console.log('123');
			console.log('${usedKeyword }')
			$('button#10').click(function () {
				search('10', '${usedKeyword }');
			})
			$('button#20').click(function () {
				search('20', '${usedKeyword }');
			})
			$('button#30').click(function () {
				search('30', '${usedKeyword }');
			})
			$('button#40').click(function () {
				search('40', '${usedKeyword }');
			})
			$('button#50').click(function () {
				search('50', '${usedKeyword }');
			})
			$('button#60').click(function () {
				search('60', '${usedKeyword }');
			})
			$('button#70').click(function () {
				search('70', '${usedKeyword }');
			})
			$('button#80').click(function () {
				search('80', '${usedKeyword }');
			})
			$('button#90').click(function () {
				search('90', '${usedKeyword }');
			})
			$('button#all').click(function () {
				search('all', '${usedKeyword }');
			})
		})

		function search(p_filter, p_keyword) {
			var filter = p_filter;
			var keyword = p_keyword;
			$.ajax({
				type: "post",
				async: true,
				url: "http://localhost:8090/andOne/shop/filteringByAjax.do",
				dataType: "text",
				data: "searchKeyword=" + keyword + "&filter=" + filter,
				success: function (data, textStatus) {
					var jsonStr = data;
					var jsonInfo = JSON.parse(jsonStr);
					var output = "";
					for (var i in jsonInfo) {
						console.log(jsonInfo[i].s_name);
						output += "<div class='col-sm-6 mb-3' style='max-width: 540px;'>";
						output += "<div class='row no-gutters'>";
						output += "<div class='col-sm-6'>";
						output += "<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'>";
						output += "</div>";
						output += "<div class='col-sm-6'>";
						output += "<div class='card-body' style='height: 225px'>";
						output += "<h5 class='card-title' style='height: 20%'>" + jsonInfo[i].s_name + "</h5>";
						output += "<p class='card-text' style='height: 40%'>" + jsonInfo[i].s_content + "</p>";
						output += "<p class='card-text'>";
						output += "<small class='text-muted' style='height: 14px'>" + jsonInfo[i].shopReviewList[0].sr_content + "</small>";
						output += "</p>";
						output += "<p class='card-text'>";
						output += "<small class='text-muted' style='height: 14px'>가게평점 ";
						output += jsonInfo[i].s_score + "</small>";
						output += "</p>";
						output += "</div>";
						output += "</div>";
						output += "</div>";
						output += "</div>";
					}
					console.log('11');
					//console.log(output);
					$('div.row#result').html(output);
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) { }
			});
		}
	</script>

	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>
	<div class="container my-5 center">
		<div class="search" align="center">
			<form name="searchFrm" method="post" action="${contextPath }/shop/localShopSearch.do">
				<input type="hidden" name="searchCondition" value="ALLSEARCH" />
				<input type="text" value="${usedKeyword }" id="searchKeyword" placeholder="검색" name="searchKeyword"
					style="width:400px; height:30px;"> <input type="submit" value="&#xf002;">
			</form>
			<br>
			<button id="all" type="button" class="btn btn-outline-info" onclick="">전체</button>
			<button id="10" type="button" class="btn btn-outline-info" onclick="">카페</button>
			<button id="20" type="button" class="btn btn-outline-info" onclick="">음식점</button>
			<button id="30" type="button" class="btn btn-outline-info" onclick="">병원</button>
			<button id="40" type="button" class="btn btn-outline-info" onclick="">학원</button>
			<button id="50" type="button" class="btn btn-outline-info" onclick="">미용</button>
			<button id="60" type="button" class="btn btn-outline-info" onclick="">마트/유통</button>
			<button id="70" type="button" class="btn btn-outline-info" onclick="">공방/클래스</button>
			<button id="80" type="button" class="btn btn-outline-info" onclick="">인테리어</button>
			<button id="90" type="button" class="btn btn-outline-info" onclick="">부동산</button>
		</div>
		<hr>
		<h3>업체 리스트</h3>
		<br>
		<div class="row" id="result">
			<c:forEach var="shop" items="${shopList}">
				<div class='col-sm-6 mb-3' style='max-width: 540px;'>
					<div class='row no-gutters'>
						<div class='col-sm-6'>
							<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'>
						</div>
						<div class='col-sm-6'>
							<div class='card-body' style='height: 225px'>
								<h5 class='card-title' style='height: 20%'>${shop.s_name}</h5>
								<p class='card-text' style='height: 40%'>${shop.s_content}</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>${shop.shopReviewList[0].sr_content}</small>
								</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>가게평점
										${shop.s_score}</small>
								</p>
							</div>
						</div>
					</div>
				</div>


			</c:forEach>
		</div>
	</div>
	<br>

</body>

</html>