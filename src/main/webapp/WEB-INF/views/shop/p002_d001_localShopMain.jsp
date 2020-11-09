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

h5 {
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

.card {
	
}

i.fa-star-half-alt {
/* 	color: rgb(255, 234, 0); */
	color: #ffc107;
}

i.fa-star {
/* 	color: rgb(255, 234, 0); */
	color: #ffc107;
}

img.noResult {
	display: block;
	margin: 0px auto;
}

div#review {
/* 	background-color: rgb(228, 228, 228); */
}

a {
	text-decoration: none;
}

.mi_box {
	    width: 80px;
	    height: 80px; 
	    border-radius: 70%;
	    overflow: hidden;
	    cursor: pointer;
	}
	
.ri_box {
	width: 80px;	
	height: 80px; 
    overflow: hidden;
    cursor: pointer;
	}
	
/* .si_box{ */
/* 	width: 285px; */
/* 	height: 230px;  */
/*     overflow: hidden; */
/*     cursor: pointer; */
/*     text-align: center; */
/* 	} */

.thumb{
	height: 230px;
	object-fit: cover;
}

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
<script>
	$(document).ready(function(){
		getUserLocation();
		getPopularHashtag();
	})
	
	var lat = '';
	var lng = '';
	
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
					output += '<a class="btn btn-sm btn-outline-primary" href="${contextPath }/shop/localShopSearch.do?searchCondition=SEARCHBYHASHTAG&searchKeyword='+hashtagArr[i]+'">#'+hashtagArr[i]+'</a>&nbsp;';
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
	
	function popularSearch(lat, lng){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/popularSearchByAjax.do",
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('.popular').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
			},
			data:"M_LOCATE_LAT="+lat+"&M_LOCATE_LNG="+lng,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var output = "";
				if(Object.keys(jsonInfo).length == 0){
					output += '<div class="col-12 m-3 bg-light card"><div class="cord-body p-5 text-center">등록된 지역업체가 없습니다.<br>위치정보가 설정되어있는지 확인해주세요 :)</div></div>';
				}else{
					output += "<div class='mt-4 row'><div class='mx-auto'>";
					for (let i=0; i<Object.keys(jsonInfo).length; i++) {
						console.log(jsonInfo[i].s_name);
						output += "<div class='mx-3 d-inline-block align-top'>";
						output += "<div class='card' style='width: 18rem;'>";
// 						output += "<div class='si_box'>"
						output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
						if(Object.keys(jsonInfo[i].shopImage).length != 0){
							output += "<img src='data:image/jpg;base64,"+jsonInfo[i].shopImage[0].si_encodedImg+"' class='card-img-top thumb' alt='...'>";
						}else{
							output += "<img src='${contextPath }/resources/image/ina.png' class='card-img-top thumb' alt='...'>";
						}
						output += "</a>";
// 						output += "</div>";
						//카테고리 표시
						output += "<div class='card-body'><small class='text-secondary'>"+jsonInfo[i].gc_name+"</small>";
						output += "<h4 class='card-title'><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>"+jsonInfo[i].s_name+"</a></h4>";
						output += "<div id='popularAddr"+i+"'></div>"
						output += "<p class='text-right mt-2 mb-0'><i class='fas fa-map-marker-alt mr-1 text-muted'></i>";
						if(jsonInfo[i].distance<1){
							output += (jsonInfo[i].distance * 1000) + "m";
						}else{
							output += jsonInfo[i].distance + "km";
						}
						output += "</p></div>";
						output += "<div class='card-body border-top clearfix' id='review'>";
						output += "<p class='mb-0 card-text float-left'>";
						output += "<a href='#'>후기 "+jsonInfo[i].reviewCount+"건</a></p>";
						output += "<p class='mb-0 card-text float-right'>"+printStar(jsonInfo[i].s_score)+"</p></div></div></div>";
					}
					output += "</div></div>";
					
				}
				$('.popular').html(output);
				
				//위치정보 입력
				for(let i=0; i<Object.keys(jsonInfo).length; i++){
					//위도, 경도
					var x = jsonInfo[i].s_locate_lat;
					var y = jsonInfo[i].s_locate_lng;
					//좌표로 주소 받아오기
					var geocoder = new kakao.maps.services.Geocoder();
					var coord = new kakao.maps.LatLng(x, y);
					var callback = function(result, status) {
					    if (status === kakao.maps.services.Status.OK) {
					        console.log('그런 너를 마주칠까 ' + result[0].address_name + '을 못가');
					        var infoDiv = document.getElementById('popularAddr'+i);
					        infoDiv.innerHTML = "<p class='card-text'>" + result[0].address_name + "</p>"
					    }
					};
					geocoder.coord2RegionCode(coord.getLng(), coord.getLat(), callback);
				}
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		});
	}

	function getUserLocation(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/member/selectLocate.do",
			dataType: "text",
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				console.log(jsonInfo.M_LOCATE_LAT);
				lat = jsonInfo.M_LOCATE_LAT;
				console.log(jsonInfo.M_LOCATE_LNG);
				lng = jsonInfo.M_LOCATE_LNG;
				if(lat == 0 && lng == 0){
					lat = '37.57045622903788';
					lng = '126.98529300126489';
				}
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				popularSearch(lat, lng);
			}
		});
	}


</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="bg-light">
	<div class="container my-5 center">
	<h1 class="and text-primary mt-4 text-center">우리동네 업체정보</h1>
	<div style="width:500px; margin: 0 auto">
			<form name="searchFrm" method="post"
				action="${contextPath }/shop/localShopSearch.do">
				<div class="form-group mx-3 searchInput">
				  <div class="p-1 rounded rounded-pill border border-primary" style="border-width:2px !important">
		            <div class="input-group">
		              <input type="search" placeholder="검색" aria-describedby="button-addon1" name="searchKeyword" class="form-control border-0 m-1 bg-light">
		              <div class="input-group-append">
		                <button id="button-addon1" type="submit" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
		              </div>
		            </div>
		          </div>
		         </div>
			<input type="hidden" name="searchCondition" value="ALLSEARCH" />
			</form>
			<div class="text-center">
				<span class="mr-1">추천검색어 <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
				</svg></span>
				<div class="hashtag d-inline-block">
			</div>
		
		</div>
	</div>

		<br><br>
		<div class="category">
		<p class="h5">카테고리
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
			<div class="categoryList" align="center">
				<div class="mx-auto">
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=10"><img src="${contextPath }/resources/image/shopCategory/cafe.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=10">카페</a>
								</h4>
						</div>
					</div>	
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=20"><img src="${contextPath }/resources/image/shopCategory/restaurant.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=20">음식점</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block" >
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=30"><img src="${contextPath }/resources/image/shopCategory/hospital.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=30">병원</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block" >
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=40"><img src="${contextPath }/resources/image/shopCategory/academy.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=40">학원</a>
								</h4>
						</div>
					</div>
				</div>
				<div class="mx-auto">
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=50"><img src="${contextPath }/resources/image/shopCategory/beauty.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=50">미용</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=60"><img src="${contextPath }/resources/image/shopCategory/mart.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=60">마트/유통</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=70"><img src="${contextPath }/resources/image/shopCategory/pottery.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=70">공방/클래스</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=80"><img src="${contextPath }/resources/image/shopCategory/interior.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=80">인테리어</a>
								</h4>
						</div>
					</div>
					<div class="d-inline-block">
						<div class="m-4" style="width: 120px;">
							<a href="${contextPath }/shop/localShopSearch.do?filter=90"><img src="${contextPath }/resources/image/shopCategory/real_estate.png" class="card-img-top"
								alt="..."></a>
								<h4 class="mt-3 ">
									<a class="text-dark" href="${contextPath }/shop/localShopSearch.do?filter=90">부동산</a>
								</h4>
						</div>
					</div>
				</div>	
			</div>
		</div>	
		<br>
		

		<p class="h5 mt-5">우리동네 인기업체
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		<div class="popular">
				
		</div>
	</div>
</body>
</html>