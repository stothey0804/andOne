<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--font awesome-->
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- kakao map-->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8"></script> -->
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

 <script type="text/javascript">

 	function init(){
 		
 		//지도에서 위치선택 적용
 		document.getElementById('setAddr').addEventListener("click", function(){
			// 행정동 주소정보 요청 및 메인 set
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
 		});
 		
 		// 주소클릭시 맵설정 창 띄우기
 		document.getElementById('centerAddr').addEventListener("click", function(){
 			var mapNode = document.querySelector(".map-container");
 			mapNode.classList.add('visible');
 			var closeNode = mapNode.querySelector("#map-close");
 			closeNode.addEventListener("click",function(){
				mapNode.classList.remove('visible');
 			});
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
 		
 		// rate 배열 얻기
 		let rates = document.querySelectorAll("span.rate");
		let stars = document.querySelectorAll("span.star");
		
		// star 출력
		for(let i = 0; i < rates.length; i++){
			let score = rates[i].textContent;
			let result = "";
				let k = 5;
				
				for(let j = 0 ; j < score/2; j++, k--){
					if(j == Math.ceil(score/2)-1 && score % 2 != 0){
						result += "<i class='fas fa-star-half-alt'></i>";
						k--;
						break;
					}
					result += "<i class='fas fa-star'></i>";
				}

				for(k; k > 0; k--){
					result += "<i class='far fa-star'></i>";
				}
// 			console.log(result);
			stars[i].innerHTML = result;
		}

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
 </style>
</head>
<body onload="init()">
<%
   request.setCharacterEncoding( "utf-8" );
%>
	<!-- 위치정보 -->
	<div class="container my-5">
		<p class="h5">
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-geo-alt-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			</svg>
			내 위치
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
			<a href="#"><small class="text-muted" id="centerAddr"></small></a>
		</p>
	</div>
	<!-- MAP 영역 -->
	<div class="map-container p-4 bg-light m-auto">
		<div class="row m-1">
			<p class="h4">
				<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-geo-alt-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
				</svg>
				지도에서 위치 선택	
			</p>		
			<div class="ml-auto">
				<svg width="1em" height="1em" viewBox="0 0 16 16" id="map-close" class="bi bi-x" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
				</svg>
			</div>
		</div>
		<div class="row m-3"><span class="pt-1 mr-1">선택한 위치
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-double-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M3.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L9.293 8 3.646 2.354a.5.5 0 0 1 0-.708z"/>
			  <path fill-rule="evenodd" d="M7.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L13.293 8 7.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</span><span id="selectedAddr" class="text-muted pt-1"></span>
		<button id="setAddr" class="btn btn-secondary btn-sm ml-2 my-auto">적용</button>
		</div>
		<div id="map"></div>
	</div>
	<!-- MAP 영역 END -->
	<script src="${contextPath}/resources/js/kakaoMapMain.js"></script>
	<!-- &분의일 링크 -->
	<div class="container my-5">
		<div class="row">
			<div class="col-lg-4">
				<p class="text-center">
					<a href="#"><img src="https://via.placeholder.com/150"></a>
				</p>
        		<p class="text-center"><a class="btn btn-link" href="#" role="button">같이먹기</a></p>
      		</div>
			<div class="col-lg-4">
				<p class="text-center">
					<a href="#"><img src="https://via.placeholder.com/150"></a>
				</p>
        		<p class="text-center"><a class="btn btn-link" href="#" role="button">같이사기</a></p>
      		</div>
			<div class="col-lg-4">
				<p class="text-center">
					<a href="#"><img src="https://via.placeholder.com/150"></a>
				</p>
        		<p class="text-center"><a class="btn btn-link" href="#" role="button">같이하기</a></p>
      		</div>
		</div>
	</div>
	<!-- 추천검색어 -->
	<div class="container my-5">
		<p class="h5">추천 검색어
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
			<a href="#" class="btn btn-outline-primary">#치킨</a>
			<a href="#" class="btn btn-outline-primary">#영화</a>
			<a href="#" class="btn btn-outline-primary">#과일</a>
			<a href="#" class="btn btn-outline-primary">#나눔</a>
		</p>
	</div>
	
	<!-- 최근등록된  -->
	<div class="container my-5">
		<h5 class="mb-3">최근등록된 같이 먹기
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		</h5>
			 <div class="container">
				<div class="row">
					<c:forEach var ="andone" items="${andoneList}" > 
					<c:url var="url"  value="add.do"  >
					 </c:url> 
					<div class="col-sm-6 mb-3">
						<div class="card">
							<a href="#"><div class="card-body">
								<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h5>
								<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}주문  </h6>
								<p class="card-text"> 예상 ${andone.one_totalPrice}원  n/${andone.one_memberMax}</p>
							</div></a>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
	</div>
	
	<!-- 소모임 -->
	<div class="container my-5">
		<h5 class="mb-3">지금 뜨는 소모임
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</h5>
		<div class="row">
		<!-- start card  -->
		  <c:forEach var="club" items="${clubList}" >	
<%-- 			 <c:url var="url"  value="searchMod.do"  > --%>
<%-- 			   <c:param  name="c_id" value="${club.c_id}" /> --%>
<%-- 			 </c:url>      --%>
		
		  <div class="col-lg-3">
		    <div class="card">
		    <img src="https://via.placeholder.com/100x100" class="card-img-top" alt="...">
		      <div class="card-body">
		        <h5 class="card-title">${club.c_name}</h5>
		        <p class="card-text">${club.c_content}</p>
		        <p class="card-text">${club.c_hashtag}</p>
		        <a href='#' class="btn btn-primary text-right">자세히 보기</a>
		      </div>
		    </div>
		  </div>
		  </c:forEach>
		<!-- end card -->
		</div><!-- end row -->
	</div>
	
	<!-- 지역업체  -->
	
	
	<div class="container my-5">
		<h5 class="mb-3">우리동네 업체 후기
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
		</h5>
		
		<!-- Swiper -->
		  <div class="swiper-container">
		    <div class="swiper-wrapper">
				<c:forEach var="shop" items="${shopList}" >
			      <div class="swiper-slide">
					  <div class="col p-0">
					    <div class="card">
					    <img src="https://via.placeholder.com/150x100" class="card-img-top" alt="...">
					      <div class="card-body">
					        <h5 class="card-title">${shop.s_name}</h5>
					        <p class="card-text">${shop.s_content}</p>
					        <p class="card-text h6 text-right">후기 ${shop.review_cnt}건</p>
					      </div>
					      <div class="card-body bg-light m-2">
					        <h6 class="card-title">${shop.m_nickname}님의 후기</h6>
					        <p class="card-text text-warning text-right"><span class="star "></span><span class="rate ml-1">${shop.sr_score}</span></p>
					        <p class="card-text">${shop.sr_content}</p>
					      </div>
					    </div>
					  </div>	
			      </div>
				</c:forEach>
		    </div>
		  </div><!-- end swiper -->
	</div>


</body>
</html>