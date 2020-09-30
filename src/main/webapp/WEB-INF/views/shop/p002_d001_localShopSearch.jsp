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
	font-size: 200%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

button#search {
	font-family: FontAwesome;
}

div.search {
	text-align: center;
}

.card {
	
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
		var usedFilter = '${filter}';
		var usedKeyword = '${usedKeyword}';
		$(document).ready(function () {
			console.log(usedKeyword);
			console.log(usedFilter);
			$('#searchWindow').val(usedKeyword);
			search();
			$('button#10').click(function () {
				usedFilter = '10';
				search();
			})
			$('button#20').click(function () {
				usedFilter = '20';
				search();
			})
			$('button#30').click(function () {
				usedFilter = '30';
				search();
			})
			$('button#40').click(function () {
				usedFilter = '40';
				search();
			})
			$('button#50').click(function () {
				usedFilter = '50';
				search();
			})
			$('button#60').click(function () {
				usedFilter = '60';
				search();
			})
			$('button#70').click(function () {
				usedFilter = '70';
				search();
			})
			$('button#80').click(function () {
				usedFilter = '80';
				search();
			})
			$('button#90').click(function () {
				usedFilter = '90';
				search();
			})
			$('button#all').click(function () {
				usedFilter = '';
				search();
			})
			$('#sel').change(function () {
				search();
			})
		})
		
		function searchButton(){
			usedKeyword = $('#searchWindow').val();
			search();
		}
		
		function search(){
			$.ajax({
				type: "post",
				async: true,
				url: "http://localhost:8090/andOne/shop/searchByAjax.do",
				dataType: "text",
				beforeSend:function(data, textStatus){
					$('#result').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
				},
				data: "searchKeyword=" + usedKeyword + "&filter=" + usedFilter +"&status=" + $('#sel').val(),
				success: function (data, textStatus) {
					var jsonStr = data;
					var jsonInfo = JSON.parse(jsonStr);
					var output = "";
					for (var i in jsonInfo) {
						console.log(jsonInfo[i].s_name);
						output += "<div class='col-sm-6 mb-3' style='max-width: 540px;'>";
						output += "<div class='row no-gutters'>";
						output += "<div class='col-sm-6'>";
						output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
						output += "<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'></a>";
						output += "</div>";
						output += "<div class='col-sm-6'>";
						output += "<div class='card-body' style='height: 225px'>";
						output += "<h5 class='card-title' style='height: 20%'><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>" + jsonInfo[i].s_name + "</a></h5>";
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
					$('div.row#result').html(output);
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
		<div class="search" align="center">
			<input type="text" id="searchWindow"
				placeholder="검색" name="searchWindow"
				style="width: 400px; height: 30px;">
			<button id="search" onClick="searchButton();">&#xf002;</button>
			<br>
			<br>
			<button id="all" type="button" class="btn btn-outline-info"
				onclick="">전체</button>
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
		<select id="sel">
			<option value="SCORE" selected>평점순</option>
			<option value="REVIEW">후기많은순</option>
		</select> <br><br>
		<div class="row" id="result"></div>
	</div>
	<br>

</body>

</html>