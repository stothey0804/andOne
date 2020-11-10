<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- kakao map-->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8"></script> -->
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
<!-- <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"> -->
<!-- JQuery -->

 <script type="text/javascript">
 
 	var m_id = '${m_id}';
 	
 	
 	$(document).ready(function(){
 		
		// 주소클릭시 맵설정 창 띄우기
		document.getElementById('centerAddr').addEventListener("click", function(){
			var mapNode = document.querySelector(".map-container");
			mapNode.classList.add('visible');
			var closeNode = mapNode.querySelector("#map-close");
			closeNode.addEventListener("click",function(){
				mapNode.classList.remove('visible');
			});
		});
		
		// 클럽 html 지우기
		var txt = document.getElementsByClassName("str");
		for(i=0;i<txt.length;i++){
			document.getElementsByClassName("str")[i].innerHTML = txt[i].innerText;
		}
		
		// 인기지역업체 받기
			$.ajax({
				type: "post",
				async: true,
				url: "${contextPath}/shop/popularSearchByAjax.do",
				dataType: "text",
				beforeSend:function(data, textStatus){
					$('.popular').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
				},
				data:"M_LOCATE_LAT="+getCookie("locate_lat")+"&M_LOCATE_LNG="+getCookie("locate_lng"),
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
							output += "<div class='col-3 px-1 d-inline-block align-top'>";
							output += "<div class='card mx-1'>";
//	 						output += "<div class='si_box'>"
							output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo[i].s_id+"'>";
							if(Object.keys(jsonInfo[i].shopImage).length != 0){
								output += "<img src='data:image/jpg;base64,"+jsonInfo[i].shopImage[0].si_encodedImg+"' class='card-img-top thumb' alt='...'>";
							}else{
								output += "<img src='${contextPath }/resources/image/ina.png' class='card-img-top thumb' alt='...'>";
							}
							output += "</a>";
//	 						output += "</div>";
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

		
 		// swiper
	    var swiper = new Swiper('.swiper-container', {
	      slidesPerView: 3,
	      spaceBetween: 30,
	      slidesPerGroup: 3,
	      loop: true,
	      loopFillGroupWithBlank: true,
	      autoplay: {
	          delay: 2500,
	          disableOnInteraction: false,
	        },
	    });
 			

		
		let prices = document.querySelectorAll("span.price");
			let priceResults = document.querySelectorAll("span.priceResult");
			
			for(let i=0; i<prices.length; i++){
				var pResult = prices[i].textContent;
				priceResults[i].innerHTML = pointToNumFormat(pResult);
  		}

 	});
 	
 	function getCookie(name) {
 		  var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
 		  return value? value[2] : null;
 	}
 	
	function printStar(score){
		var calScore = score;
		var resultStar = '';
		while(true){
			if(calScore>=2){
				resultStar += '<i class="fas fa-star text-warning"></i>';
				calScore -= 2;
				continue;
			}else if(calScore>0){
				resultStar += '<i class="fas fa-star-half-alt text-warning"></i>';
				break;
			}else{
				break;
			}
		}
		return resultStar;
	}


 </script>
 <style type="text/css">
     .swiper-container {
      width: 100%;
      height: 100%;
    }

    .swiper-slide {
      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }
    
    .map-container {
    	z-index: 9999;
    	visibility: hidden;
    	position: fixed;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%, -50%);
    	border: solid 2px black;
    }
    #map {
   		position: relative;
   		width: 500px;
 		height: 400px;
    }
    #map-close{
    	font-size: 3.5em;
    	margin-top: -0.3em;
    	margin-right: -0.3em;
    	cursor: pointer;
    }
    .andMenu{
    	font-family: 'YanoljaYacheR' !important;
    	font-size: 2.5em;
    }
    .card-img-top{
    	height: 10em;
    	object-fit: cover;
    }
 </style>
</head>
<body class="bg-light">
<%
   request.setCharacterEncoding( "utf-8" );
%>
	<!-- 위치정보 -->
	<div class="container my-5 clearfix">
		<p class="h5 float-left">
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-geo-alt-fill text-primary" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			</svg>
			<spring:message code="myLocation" />
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
			<small class="text-muted" id="centerAddr"></small>
		</p>
		<!-- 언어설정 -->
		  <div class="btn-group float-right" style="margin-top:-4px">
			  <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			     <spring:message code="menu.lang" />
			  </button>
			  <div class="dropdown-menu dropdown-menu-lg-right">
			    <a class="dropdown-item" href="${contextPath}/?lang=ko"><spring:message code="lang.ko" /></a>
			    <a class="dropdown-item" href="${contextPath}/?lang=en"><spring:message code="lang.en" /></a>
			  </div>
		  </div>
	</div>
	<!-- MAP 영역 -->
	<div class="map-container p-4 bg-light m-auto">
		<div class="row m-1">
			<p class="h4">
				<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-map" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M15.817.113A.5.5 0 0 1 16 .5v14a.5.5 0 0 1-.402.49l-5 1a.502.502 0 0 1-.196 0L5.5 15.01l-4.902.98A.5.5 0 0 1 0 15.5v-14a.5.5 0 0 1 .402-.49l5-1a.5.5 0 0 1 .196 0L10.5.99l4.902-.98a.5.5 0 0 1 .415.103zM10 1.91l-4-.8v12.98l4 .8V1.91zm1 12.98l4-.8V1.11l-4 .8v12.98zm-6-.8V1.11l-4 .8v12.98l4-.8z"/>
				</svg>
				지도에서 위치 선택	
			</p>		
			<div class="ml-auto">
				<svg width="1em" height="1em" viewBox="0 0 16 16" id="map-close" class="bi bi-x" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
				</svg>
			</div>
		</div>
		<div class="row mx-3 mt-3 mb-2"><span class="pt-1 mr-1 text-primary" id="selectGeoLocation">
			<svg width="1em" height="1.0625em" viewBox="0 0 16 17" class="bi bi-compass" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M8 16.016a7.5 7.5 0 0 0 1.962-14.74A1 1 0 0 0 9 0H7a1 1 0 0 0-.962 1.276A7.5 7.5 0 0 0 8 16.016zm6.5-7.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
				  <path d="M6.94 7.44l4.95-2.83-2.83 4.95-4.949 2.83 2.828-4.95z"/>
				</svg>		
			현재 위치 자동선택 
			</span>
		</div>
		<div class="row mx-3 mb-3"><span class="pt-1 mr-1">선택한 위치
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-double-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M3.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L9.293 8 3.646 2.354a.5.5 0 0 1 0-.708z"/>
			  <path fill-rule="evenodd" d="M7.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L13.293 8 7.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</span><span id="selectedAddr" class="text-muted pt-1"></span>
		<button id="setAddr" class="btn btn-secondary btn-sm ml-2 my-auto">저장</button>
		</div>
		<div id="map"></div>
	</div>
	<!-- MAP 영역 END -->
	<script src="${contextPath}/resources/js/kakaoMapMain.js"></script>
	
	<!-- &분의일 링크 -->
	<div class="container mt-5 my-4">
		<div class="row col-10 mx-auto">
			<div class="col-lg-4">
				<p class="text-center">
					<a href="${contextPath}/andeat?g_id=010">
					<img src="${contextPath}/resources/image/main/eat.png" width="150px" height="150px">
					</a>
				</p>
        		<p class="text-center"><a class="andMenu" href="${contextPath}/andeat?g_id=010" role="button"><spring:message code="andEat" /></a></p>
      		</div>
			<div class="col-lg-4">
				<p class="text-center">
					<a href="${contextPath}/andbuy?g_id=011">
					<img src="${contextPath}/resources/image/main/buy.png" width="150px" height="150px">
					</a>
				</p>
        		<p class="text-center"><a class="andMenu" href="${contextPath}/andbuy?g_id=011" role="button"><spring:message code="andBuy" /></a></p>
      		</div>
			<div class="col-lg-4">
				<p class="text-center">
					<a href="${contextPath}/anddo?g_id=012">
					<img src="${contextPath}/resources/image/main/do.png" width="150px" height="150px">
					</a>
				</p>
        		<p class="text-center"><a class="andMenu" href="${contextPath}/anddo?g_id=012" role="button"><spring:message code="andDo" /></a></p>
      		</div>
		</div>
	</div>
	
	<!-- /// 검색창 /// -->
	<div style="width:600px; margin: 0 auto">
			<!-- 경로 및 Form 설정 -->
			<form name="searchFrm" method="post" action="${contextPath }/fullSearch.do">
				<div class="form-group mx-3 searchInput">
				  <div class="p-1 rounded rounded-pill border border-primary" style="border-width:4px !important">
		            <div class="input-group">
		              <input type="search" placeholder="<spring:message code="searchInput" />" aria-describedby="button-addon1" name="searchKeyword" class="form-control border-0 m-1 bg-light">
		              <div class="input-group-append">
		                <button id="button-addon1" type="submit" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
		              </div>
		            </div>
		          </div>
		         </div>
<!-- 			<input type="hidden" name="searchCondition" value="ALLSEARCH" /> -->
			</form>
			<div class="text-center">
				<span class="mr-1">추천검색어 <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
				</svg></span>
				<div class="hashtag d-inline-block">
					<!-- 인기 해시태그 넣고 지워주세요  -->
					<a href="${contextPath }/fullSearch.do?searchKeyword=${hashtag[0] }" class="btn btn-outline-primary">&num;${hashtag[0] }</a>
					<a href="${contextPath }/fullSearch.do?searchKeyword=${hashtag[1] }" class="btn btn-outline-primary">&num;${hashtag[1] }</a>
					<a href="${contextPath }/fullSearch.do?searchKeyword=${hashtag[2] }" class="btn btn-outline-primary">&num;${hashtag[2] }</a>
					<a href="${contextPath }/fullSearch.do?searchKeyword=${hashtag[3] }" class="btn btn-outline-primary">&num;${hashtag[3] }</a>
					<!-- 인기 해시태그 넣고 지워주세요  END -->
				</div>
		</div>
	</div>
	
	<!-- 추천검색어 -->

	
	<!-- 최근등록된  같이먹기-->
	<div class="container my-5">
		<h5 class="mb-3"><spring:message code="main.recentEat" />
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		</h5>
			 <div class="container">
				<div class="row">
					<c:if test="${empty andEatList}">
						<div class="col-12 m-3 bg-light card">
							<div class="cord-body p-5 text-center"><spring:message code="emptyMsg" /></div>
						</div>
					</c:if>
					<c:forEach var ="andone" items="${andEatList}" > 
						<div class="col-sm-6 mb-3">
							<div class="card and_card" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}'">
								<div class="card-body">
									<div class="card-title clearfix">
										<p class="h5 "><span class="text-primary">[${andone.one_category}]</span> ${andone.one_title}</p>
										<p class="h6 font-weight-bold mb-1 float-left">
										<c:if test="${andone.one_state eq '모집중'}"><span class="text-primary"></c:if>
										<c:if test="${andone.one_state eq '결제완료'}"><span class="text-success"></c:if>
										<c:if test="${andone.one_state eq '진행완료'}"><span class="text-secondary"></c:if>
										<c:if test="${andone.one_state eq '취소'}"><span class="text-danger">	</c:if>
										${andone.one_state} </span>
										</p>
										<p class="card-subtitle mb-3 text-muted float-right"><span class="date">${andone.one_date} 수령예정</span></p>
									</div>
									<div class="clearfix">
										<p class="card-text float-left mb-0 text-truncate" style="max-width:260px"> #${andone.one_hashTag}  </p>
										<p class="card-text float-right h6"><span class="price invisible"><b>${andone.one_price}</b></span> 예상 <span class="priceResult"></span>  <span class="text-secondary"> <i class="fas fa-user-friends"></i> ${andone.one_member}/${andone.one_memberMax} </span></p>
									</div>
									<p class="card-text float-left"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
									<p class="card-text float-right h6"> ${andone.addrDetail} / ${andone.distance}km  </p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
	</div>
	<!-- 최근등록된 같이사기 -->
	<div class="container my-5">
		<h5 class="mb-3"><spring:message code="main.recentBuy" />
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		</h5>
			 <div class="container">
				<div class="row">
					<c:if test="${empty andBuyList}">
						<div class="col-12 m-3 bg-light card">
							<div class="cord-body p-5 text-center"><spring:message code="emptyMsg" /></div>
						</div>
					</c:if>
					<c:forEach var ="andone" items="${andBuyList}" > 
						<div class="col-sm-6 mb-3">
							<div class="card and_card" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}'">
								<div class="card-body">
									<div class="card-title clearfix">
										<p class="h5 "><span class="text-primary">[${andone.one_category}]</span> ${andone.one_title}</p>
										<p class="h6 font-weight-bold mb-1 float-left">
										<c:if test="${andone.one_state eq '모집중'}"><span class="text-primary"></c:if>
										<c:if test="${andone.one_state eq '결제완료'}"><span class="text-success"></c:if>
										<c:if test="${andone.one_state eq '진행완료'}"><span class="text-secondary"></c:if>
										<c:if test="${andone.one_state eq '취소'}"><span class="text-danger">	</c:if>
										${andone.one_state} </span>
										</p>
										<p class="card-subtitle mb-3 text-muted float-right"><span class="date">${andone.one_date} 수령예정</span></p>
									</div>
									<div class="clearfix">
										<p class="card-text float-left mb-0"> #${andone.one_hashTag}  </p>
										<p class="card-text float-right h6"><span class="price invisible"><b>${andone.one_price}</b></span> 예상 <span class="priceResult"></span>  <span class="text-secondary"> <i class="fas fa-user-friends"></i> ${andone.one_member}/${andone.one_memberMax} </span></p>
									</div>
									<p class="card-text float-left"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
									<p class="card-text float-right h6"> ${andone.addrDetail} / ${andone.distance}km  </p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
	</div>
	<!-- 최근등록된 같이하기 -->
	<div class="container my-5">
		<h5 class="mb-3"><spring:message code="main.recentDo" />
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		</h5>
			 <div class="container">
				<div class="row">
					<c:if test="${empty andDoList}">
						<div class="col-12 m-3 bg-light card">
							<div class="cord-body p-5 text-center"><spring:message code="emptyMsg" /></div>
						</div>
					</c:if>
					<c:forEach var ="andone" items="${andDoList}" > 
						<div class="col-sm-6 mb-3">
							<div class="card and_card" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}'">
								<div class="card-body">
									<div class="card-title clearfix">
										<p class="h5 "><span class="text-primary">[${andone.one_category}]</span> ${andone.one_title}</p>
										<p class="h6 font-weight-bold mb-1 float-left">
										<c:if test="${andone.one_state eq '모집중'}"><span class="text-primary"></c:if>
										<c:if test="${andone.one_state eq '결제완료'}"><span class="text-success"></c:if>
										<c:if test="${andone.one_state eq '진행완료'}"><span class="text-secondary"></c:if>
										<c:if test="${andone.one_state eq '취소'}"><span class="text-danger">	</c:if>
										${andone.one_state} </span>
										</p>
										<p class="card-subtitle mb-3 text-muted float-right"><span class="date">${andone.one_date} 수령예정</span></p>
									</div>
									<div class="clearfix">
										<p class="card-text float-left mb-0"> #${andone.one_hashTag}  </p>
										<p class="card-text float-right h6"><span class="price invisible"><b>${andone.one_price}</b></span> 예상 <span class="priceResult"></span>  <span class="text-secondary"> <i class="fas fa-user-friends"></i> ${andone.one_member}/${andone.one_memberMax} </span></p>
									</div>
									<p class="card-text float-left"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
									<p class="card-text float-right h6"> ${andone.addrDetail} / ${andone.distance}km  </p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
	</div>
	
	<!-- 소모임 -->
	<div class="container my-5">
		<h5 class="mb-3"><spring:message code="main.hotClub" />
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</h5>
		<div class="row px-3">
		<!-- start card  -->
		  <c:forEach var="club" items="${clubList}" >	
<%-- 			 <c:url var="url"  value="searchMod.do"  > --%>
<%-- 			   <c:param  name="c_id" value="${club.c_id}" /> --%>
<%-- 			 </c:url>      --%>
		  <div class="col-lg-2 col-sm-6 p-1">
		    <div class="card">
			<c:choose>
			<c:when test="${club.resultImg eq null}">
				<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img-top" alt="...">
			</c:when>
			<c:otherwise>
				<img src="data:image/jpg;base64,${club.resultImg}" class="card-img-top"
					alt="...">
			</c:otherwise>
			</c:choose>
		      <div class="card-body">
		        <h5 class="card-title text-truncate" style="height:28px">${club.c_name}</h5>
		        <div class="card-text text-truncate str" style="height:40px">${club.c_content}</div>
		        <p class="card-text">${club.c_hashtag}</p>
		        <a href='${contextPath}/club/detailClub.do?c_id=${club.c_id}' class="btn btn-sm btn-primary text-right">자세히 보기</a>
		      </div>
		    </div>
		  </div>
		  </c:forEach>
		<!-- end card -->
	</div>
	
	<!-- 지역업체  -->
	
	
	<div class="container my-5">
		<h5 class="mb-3"><spring:message code="main.localShop" />
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</h5>
		
		<div class="popular">
				
		</div>
<!-- 	<div class="mt-4 row mx-1"> -->
<!-- 		<div class="mx-auto"> -->
<%-- 		<c:forEach var="shop" items="${shopList}" > --%>
<!-- 			<div class="col-3 px-1 d-inline-block align-top"> -->
<!-- 				<div class="card mx-1"><a href="/andOne/shop/localShopDetail.do?s_id=20200917-3"> -->
<!-- 				<img src="" class="card-img-top thumb" alt="..."></a> -->
<%-- 				<div class="card-body"><small class="text-secondary">${shop.gc_name}</small> --%>
<%-- 					<h4 class="card-title"><a href="/andOne/shop/localShopDetail.do?s_id=${shop.s_id}">${shop.s_name}</a></h4> --%>
<!-- 					<p class="card-text">경기도 고양시 덕양구 원흥동</p> -->
<!-- 					<p class="text-right mt-2 mb-0"> -->
<%-- 					<i class="fas fa-map-marker-alt mr-1 text-muted" aria-hidden="true"></i>${shop.distance}km</p> --%>
<!-- 				</div> -->
<!-- 				<div class="card-body border-top clearfix" id="review"> -->
<%-- 				<p class="mb-0 card-text float-left"><a href="#">후기 ${shop.reviewCount}건</a></p> --%>
<!-- 				<p class="mb-0 card-text float-right"></p> -->
<!-- 				</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<%-- 		</c:forEach> --%>
<!-- 		</div> -->
<!-- 	</div> -->
		<!-- Swiper -->
<!-- 		  <div class="swiper-container"> -->
<!-- 		    <div class="swiper-wrapper"> -->
<!-- 		    </div> -->
<!-- 		  </div>end swiper -->
	</div>

	
</body>
</html>