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

i.fa-star-half-alt{
	color:rgb(255,234,0);
}

i.fa-star{
	color:rgb(255,234,0);
}

img.noResult{
	display:block; margin:0px auto;
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
<script>
	$(document).ready(function(){
		getPopularHashtag();
		popularSearch();
	})
	
	function printStar(score){
		var calScore = score;
		var resultStar = '';
		while(true){
			if(calScore>=2){
				resultStar += '<i class="fas fa-star"></i>';
				calScore -= 2;
				continue;
			}else if(calScore>0){
				resultStar += '<i class="fas fa-star-half-alt"></i>';
				break;
			}else{
				break;
			}
		}
		return resultStar;
	}
	
	function getPopularHashtag(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/getPopularHashtag.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('.hashtag').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:30px; height:30px;'>");
			},
			success: function (data, textStatus) {
				var hashtagArr = data.split(',');
				var output = '';
				for(let i=0; i<hashtagArr.length; i++){
					output += '<a href="${contextPath }/shop/localShopSearch.do?searchCondition=SEARCHBYHASHTAG&searchKeyword='+hashtagArr[i]+'">#'+hashtagArr[i]+'</a>&nbsp;';
				}
				$('.hashtag').html(output);
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		});
	}
	
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
				if(Object.keys(jsonInfo).length == 0){
					output += '<img class="noResult" src="${contextPath }/resources/image/no_result.png">';
				}else{
					output += "<div class='row'>";
					for (let i=0; i<3; i++) {
						console.log(jsonInfo[i].s_name);
						output += "<div style='margin: 20px'>";
						output += "<div class='card' style='width: 18rem;'>";
						output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
						if(Object.keys(jsonInfo[i].shopImage).length != 0){
							output += "<img src='data:image/jpg;base64,"+jsonInfo[i].shopImage[0].si_encodedImg+"' class='card-img-top'alt='...'>";
						}else{
							output += "<img src='${contextPath }/resources/image/ina.png' class='card-img-top'alt='...'>";
						}
						output += "</a>";
						output += "<div class='card-body'><h5 class='card-title'><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>"+jsonInfo[i].s_name+"</a></h5>";
						output += "<p class='card-text'>"+jsonInfo[i].s_locate+"</p></div>";
						output += "<div class='card-body' id='review'>";
						output += "<p class='card-text'>";
						output += "<a href='#'>후기 "+jsonInfo[i].reviewCount+"건</a><br>";
						output += ""+printStar(jsonInfo[i].s_score)+"</p></div></div></div>";
					}
					output += "</div>";
				}
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
			<div class="hashtag">
			
			</div>
			<br>
		</div>
		<br><br>
		<div class="category">
			<h3>카테고리로 찾기</h3>
			<div class="categoryList" align="center">
				<div class="row">
					<div style="margin: 15px">
						<div class="card" style="width: 8rem;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=10"><img src="${contextPath }/resources/image/shopCategory/cafe.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=20"><img src="${contextPath }/resources/image/shopCategory/restaurant.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=30"><img src="${contextPath }/resources/image/shopCategory/hospital.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=40"><img src="${contextPath }/resources/image/shopCategory/academy.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=50"><img src="${contextPath }/resources/image/shopCategory/beauty.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=60"><img src="${contextPath }/resources/image/shopCategory/mart.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=70"><img src="${contextPath }/resources/image/shopCategory/pottery.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=80"><img src="${contextPath }/resources/image/shopCategory/interior.png" class="card-img-top"
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
							<a href="${contextPath }/shop/localShopSearch.do?filter=90"><img src="${contextPath }/resources/image/shopCategory/real_estate.png" class="card-img-top"
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