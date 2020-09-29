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
	var shopId = '${shopId}';
	
	$(document).ready(function(){
		getShopDetail();
	})
	
	function getShopDetail(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/getShopDetailByAjax.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('div.recommendShop').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			data: "s_id=" + shopId,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var shopImage = "";
				var shopInformation = "";
				var reviewList = "";
				var recommendShop = "";
				
				var imageCount = Object.keys(jsonInfo.shopImage).length;
				var reviewCount = Object.keys(jsonInfo.shopReviewList).length;
				
				console.log('======> 가게 이름');
				console.log(jsonInfo.s_name);
				console.log('======> 리뷰 갯수');
				console.log(reviewCount);
				console.log('======> 가게 이미지 갯수');
				console.log(imageCount);
				
				shopImage += '<div class="row">';
				for(let i=0; i<imageCount; i++){
					shopImage += '<div style="margin: 15px">';
					shopImage += '<div class="card" style="width: 20rem;">';
					shopImage += '<a href="#">';
					shopImage += '<img src="https://via.placeholder.com/150" class="card-img-top" alt="...">';
					shopImage += '</a></div></div>';
				}
				for(let i=0; i<3-imageCount; i++){
					shopImage += '<div style="margin: 15px">';
					shopImage += '<div class="card" style="width: 20rem;">';
					shopImage += '<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
					shopImage += '</div></div>';
				}
				shopImage += '</div>';
				
				shopInformation += '<table><tr><td width="500" height="70">';
				shopInformation += '<h1>'+jsonInfo.s_name+'</h1></td><td width="350" height="70"></td>';
				shopInformation += '<td align="right" width="150" height="70">';
				shopInformation += '<button id="all" type="button" class="btn btn-outline-info" onclick="">리뷰 쓰기</button>';
				shopInformation += '</td></tr><tr><td colspan="3" height="30">'+jsonInfo.s_score+'</td>';
				shopInformation += '</tr><tr><td colspan="3" height="30">'+jsonInfo.gc_name+'</td>';
				shopInformation += '</tr><tr><td colspan="3" height="30">'+jsonInfo.s_hashtag+'</td></tr><tr>';
				shopInformation += '<td valign="top" colspan="3" height="100">'+jsonInfo.s_content+'</td>';
				shopInformation += '</tr></table>';
				
				
				reviewList += '<hr><h3>후기('+jsonInfo.reviewCount+')</h3>';
				for(let i=0; i<reviewCount; i++){
					reviewList += '<table><tr><td rowspan="3" width="80">';
					reviewList += '<div style="margin: 10px">';
					reviewList += '<div class="card" style="width: 5rem;">';
					reviewList += '<a href="#">';
					reviewList += '<img src="${contextPath }/resources/image/basicProfileImg.png" class="card-img-top" alt="...">';
					reviewList += '</a></div></div></td>';
					reviewList += '<td width="680">'+jsonInfo.shopReviewList[i].m_nickname+'</td>';
					for(let j=0; j<Object.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++){
						reviewList += '<td rowspan="3" width="80">';
						reviewList += '<div style="margin: 5px">';
						reviewList += '<div class="card" style="width: 5rem;">';
						reviewList += '<a href="#">';
						reviewList += '<img src="https://via.placeholder.com/50" class="card-img-top" alt="...">';
						reviewList += '</a></div></div>';
						reviewList += '</td>';
					}
					for(let j=0; j<3 - Object.keys(jsonInfo.shopReviewList[i].shopReviewImage).length; j++){
						reviewList += '<td rowspan="3" width="80">';
						reviewList += '<div style="margin: 5px">';
						reviewList += '<div class="card" style="width: 5rem;">';
						reviewList += '<img src="${contextPath }/resources/image/ina.png" class="card-img-top" alt="...">';
						reviewList += '</div></div>';
						reviewList += '</td>';
					}
					reviewList += '</tr><tr><td width="80">'+jsonInfo.shopReviewList[i].sr_score+'</td></tr>';
					reviewList += '<tr><td width="80">'+jsonInfo.shopReviewList[i].sr_content+'</td>';
					reviewList += '<td>'+jsonInfo.shopReviewList[i].sr_date+'</td></tr></table><hr>';
				}
				
				
				recommendShop += '<h3>업체추천</h3>'
				
				
				
				
				
				
				
				
				
				
				
				
				
				$('div.shopImage').html(shopImage);
				$('div.shopInformation').html(shopInformation);
				$('div.reviewList').html(reviewList);
				$('div.recommendShop').html(recommendShop);
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
		<div class="shopImage">
		
			
		</div>
		
		<div class="shopInformation">
		
			
		</div>	
			
		
		<div class="reviewList">
		
			
		</div>	
			
		
		
		<div class="recommendShop">
		
			<div class="row" id="result">
				<div class='col-sm-6 mb-3' style='max-width: 540px;'>
					<div class='row no-gutters'>
						<div class='col-sm-6'>
							<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'>
						</div>
						<div class='col-sm-6'>
							<div class='card-body' style='height: 225px'>
								<h5 class='card-title' style='height: 20%'>가게이르ㅡㅡㅡ음</h5>
								<p class='card-text' style='height: 40%'>가게소개애ㅐㅐㅐㅐ</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>리뷰내용요ㅛㅛ</small>
								</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>가게평점
										평저어어어ㅓㅓㅇㅁ</small>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class='col-sm-6 mb-3' style='max-width: 540px;'>
					<div class='row no-gutters'>
						<div class='col-sm-6'>
							<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'>
						</div>
						<div class='col-sm-6'>
							<div class='card-body' style='height: 225px'>
								<h5 class='card-title' style='height: 20%'>가게이르ㅡㅡㅡ음</h5>
								<p class='card-text' style='height: 40%'>가게소개애ㅐㅐㅐㅐ</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>리뷰내용요ㅛㅛ</small>
								</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>가게평점
										평저어어어ㅓㅓㅇㅁ</small>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class='col-sm-6 mb-3' style='max-width: 540px;'>
					<div class='row no-gutters'>
						<div class='col-sm-6'>
							<img src='https://via.placeholder.com/100x100' class='card-img' alt='...'>
						</div>
						<div class='col-sm-6'>
							<div class='card-body' style='height: 225px'>
								<h5 class='card-title' style='height: 20%'>가게이르ㅡㅡㅡ음</h5>
								<p class='card-text' style='height: 40%'>가게소개애ㅐㅐㅐㅐ</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>리뷰내용요ㅛㅛ</small>
								</p>
								<p class='card-text'>
									<small class='text-muted' style='height: 14px'>가게평점
										평저어어어ㅓㅓㅇㅁ</small>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
	
		</div>
	</div>
	<br>

</body>

</html>