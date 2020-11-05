<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

	<script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
	<!-- font awesome -->
	<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
	<!--kakao map-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
	<style>
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
	.aa{
		display: block;
		text-align: center; 
	 }
	.bb{
		display: block;
		text-align: center; 
	 }
	 .cc{
	 	text-align: center; 
	 }
	 .swifer-container {
	 	width: 800px;
	 	height : 800px;
	 }
	 .and{
		padding : 20px;
		font-family: 'YanoljaYacheR' !important;
		font-size: 70px;
		text-align: center; 
	}
	.searchInput{
		padding-bottom : 10px;
	}
	.and_card{
		cursor: pointer;
	}
	</style>
	<script>
		var m_id = '${m_id}';
		function init(){
			// 주소클릭시 맵설정 창 띄우기
			document.getElementById('centerAddr').addEventListener("click", function(){
				var mapNode = document.querySelector(".map-container");
				mapNode.classList.add('visible');
				var closeNode = mapNode.querySelector("#map-close");
				closeNode.addEventListener("click",function(){
					mapNode.classList.remove('visible');
				});
			});

			let times = document.querySelectorAll("span.time");
			let timeResults = document.querySelectorAll("span.timeResult");
	  		
	  		for(let i=0; i<times.length; i++){
	  			var result = times[i].textContent;
	  			timeResults[i].innerHTML = timeForToday(result);
	  		}
		}
		//글 올라온시점 계산 함수
	    function timeForToday(value) {
	    const today = new Date();
	    const timeValue = new Date(value);
	
	    const betweenTime = Math.floor((today.getTime() - timeValue.getTime())/1000/60);
	        if (betweenTime < 1) return '방금전';
	        if (betweenTime < 60) {
	            return betweenTime+'분전';
	        }
	
	    const betweenTimeHour = Math.floor(betweenTime / 60);
	        if (betweenTimeHour < 24) {
	            return betweenTimeHour+'시간전';
	        }
	
	    const betweenTimeDay = Math.floor(betweenTime/ 60 / 24);
	        if (betweenTimeDay < 365) {
	            return betweenTimeDay+'일전';
	        }
	    return Math.floor(betweenTimeDay / 365)+'년전';
		}
	   
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="init()" class="bg-light">

	<!-- 위치정보 -->
	<div class="container my-5">
		<p class="h5">
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-geo-alt-fill text-primary" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			</svg>
			내 위치
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
			</svg>
			<small class="text-muted" id="centerAddr"></small>
		</p>
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

	<c:set var="g_id" value="${g_id}" />
	<h1 class="and text-primary mt-4">
	<c:choose>
		<c:when test="${g_id == '010'}">
		<img src="${contextPath}/resources/image/main/eat.png" width="100px" height="100px"> 같이먹기 
		</c:when>
		<c:when test="${g_id == '011'}">
		<img src="${contextPath}/resources/image/main/buy.png" width="100px" height="100px"> 같이사기
		</c:when>
		<c:when test="${g_id == '012'}">
		<img src="${contextPath}/resources/image/main/do.png" width="100px" height="100px">	같이하기 
		</c:when>
	</c:choose>
	</h1> 
	<div style="width:500px; margin: 0 auto">
	<c:choose>
		<c:when test="${g_id == '010'}">
			<form name="eat" method="get" action="${contextPath}/andeat/searchAndOne.do">
		</c:when>
		<c:when test="${g_id == '011'}">
			<form name="eat" method="get" action="${contextPath}/andbuy/searchAndOne.do">
		</c:when>
		<c:when test="${g_id == '012'}">
			<form name="eat" method="get" action="${contextPath}/anddo/searchAndOne.do">
		</c:when>
	</c:choose>
				<div class="form-group mx-3 searchInput">
				  <div class="p-1 rounded rounded-pill border border-primary" style="border-width:2px !important">
		            <div class="input-group">
		              <input type="search" placeholder="카테고리/지역/제목" aria-describedby="button-addon1" name="totalSearch" class="form-control border-0 m-1 bg-light">
		              <div class="input-group-append">
		                <button id="button-addon1" type="submit" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
		              </div>
		            </div>
		          </div>
<!-- 					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목"> -->
					<input type ="hidden" name="g_id" value="${g_id}">
<!-- 					<input type="submit" class="btn btn-outline-dark" value="검색"><br><br> -->
				</div>
			</form>

	</div>
	<br>
	<div class="container clearfix">
		<p class="h5 float-left">카테고리
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		</svg>
		<div class="aa">
			<div style="width:800px; margin: 0 auto">
			<c:choose>
				<c:when test="${g_id == '010'}">
					<c:forEach var ="ctg" items="${ctg}" > 
					<button type="button" class="btn btn-outline-primary mb-3" onclick="location.href='${contextPath}/andeat/searchAndOne.do?one_category=${ctg.gc_id}&g_id=${g_id}'">${ctg.gc_name}</button>
					</c:forEach>
				</c:when>
				<c:when test="${g_id == '011'}">
					<c:forEach var ="ctg" items="${ctg}" > 
					<button type="button" class="btn btn-outline-primary mb-3" onclick="location.href='${contextPath}/andbuy/searchAndOne.do?one_category=${ctg.gc_id}&g_id=${g_id}'">${ctg.gc_name}</button>
					</c:forEach>
				</c:when>
				<c:when test="${g_id == '012'}">
					<c:forEach var ="ctg" items="${ctg}" > 
					<button type="button" class="btn btn-outline-primary mb-3" onclick="location.href='${contextPath}/anddo/searchAndOne.do?one_category=${ctg.gc_id}&g_id=${g_id}'">${ctg.gc_name}</button>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</div>
	</div>

	
	<div class="container clearfix mt-5">
		<p class="h5 float-left">
	<c:choose>
		<c:when test="${g_id == '010'}">
			최근등록된 같이먹기
		</c:when>
		<c:when test="${g_id == '011'}">
			최근등록된 같이사기
		</c:when>
		<c:when test="${g_id == '012'}">
			최근등록된 같이하기
		</c:when>
	</c:choose>
	<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
	</svg></p>
	<p class="float-right"><a href="${contextPath}/and?g_id=${g_id}&flag=distance">거리순</a>/<a href="${contextPath}/and?g_id=${g_id}&flag=date">마감순</a></p>
	</div>
		
	<div class="container">
		<div class="row">
		<c:if test="${empty recentAndOneList}">
			<div class="col-12 m-3 bg-light card">
				<div class="cord-body p-5 text-center">
				등록된 &amp;분의 일이 없습니다.<br>
				위치정보가 설정되어있는지 확인해주세요 :)
				</div>
			</div>
		</c:if>
			<c:forEach var ="andone" items="${recentAndOneList}" > 
				<div class="col-sm-6 mb-3">
					<div class="card and_card" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}'">
						<div class="card-body">
							<div class="card-title clearfix">
								<p class="h5 "><span class="text-primary">[${andone.one_category}]</span> ${andone.one_title}</p>
								<p class="h6 font-weight-bold mb-1 float-left">
								<c:if test="${andone.one_state eq '모집중'}">
									<span class="text-primary">
								</c:if>
								<c:if test="${andone.one_state eq '결제완료'}">
									<span class="text-success">
								</c:if>
								<c:if test="${andone.one_state eq '진행완료'}">
									<span class="text-secondary">
								</c:if>
								<c:if test="${andone.one_state eq '취소'}">
									<span class="text-danger">
								</c:if>
								${andone.one_state} </span>
								</p>
								<p class="card-subtitle mb-3 text-muted float-right"><span class="date">${andone.one_date} 수령예정</span></p>
							</div>
							<div class="clearfix">
								<p class="card-text float-left"> #${andone.one_hashTag}  </p>
								<p class="card-text float-right h6"> 예상 <b>${andone.one_price}</b> <span class="text-secondary"> <i class="fas fa-user-friends"></i> ${andone.one_member}/${andone.one_memberMax} </span></p>
							</div>
							<p class="card-text float-left"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
							<p class="card-text float-right h6"> ${andone.addrDetail} / ${andone.distance}km  </p>
						</div>
					</div>
				</div>
			</c:forEach>
			</div>
	</div>	
				<div class="resisterBtn" style="width:500px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-primary rounded btn-block"> 새로운 활동 등록하기 </button>
			</div>
</body>
</html>