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
	.aa{
		padding: 15px; 
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
		font-size: 80px;
		text-align: center; 
	}
	.searchInput{
		padding-bottom : 10px;
	}
	</style>
	<script>
		function init(){
			let times = document.querySelectorAll("span.time");
			let timeResults = document.querySelectorAll("span.timeResult");
	  		
	  		for(let i=0; i<times.length; i++){
	  			var result = times[i].textContent;
	  			timeResults[i].innerHTML = timeForToday(result);
	  		}
	  		// 주소-좌표 변환 객체를 생성합니다
	  		var geocoder = new kakao.maps.services.Geocoder();
	  		
	  		
	  		let distane01 = document.querySelectorAll("span.addr");
	  		let addrResults = document.querySelectorAll("span.addrResult");
	  		
	  		var distances = [];
	  		var ti = [];
	  		for(let i=0; i<distane01.length; i++){
	  			distances[i] = distane01[i].textContent;
	  			var x_memLocate = distances[i].slice(0,distances[i].indexOf(","));
	  			console.log(">>>x_memLocate "+x_memLocate);
	  			var y_memLocate = distances[i].slice(distances[i].indexOf(",")+1,distances[i].length-1);
	  			console.log(">>>y_memLocate "+y_memLocate );
	  			ti[i] = new daum.maps.LatLng(x_memLocate,y_memLocate);
	  		}
	  		var detail = [];
	  		
	  		for(i=0; i<ti.length; i++){
	  			searchDetailAddrFromCoords(ti[i], function(result, status) {
	  				if (status === kakao.maps.services.Status.OK) {
			  			var detailAddr = result[0].address.address_name;
			  			detail = detailAddr;
			  			console.log(detail);
	  				}
		  		})
			  			addrResults[i].innerHTML = detail[i];
	  		}
	  		
	  		function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback(detail));
			}
	  		
	  		/* ti.forEach(function (andOnePosition){
				var polyline = new daum.maps.Polyline({
					path: [
						memPosition,
						andOnePosition
					]
				});
				console.log("길이>>>>"+polyline.getLength());
				var leng = [];
				leng = polyline.getLength();
				console.log(leng[1]);
				}) */
	  		
	  		/* var distance = [];
			for(var i in andOneLocate){
				/* one_locate_Lat = andOneLocate[i].ONE_LOCATE_LAT;
				one_locate_Lng = andOneLocate[i].ONE_LOCATE_LNG;
				console.log("1111"+one_locate_Lat);
				console.log("2222"+one_locate_Lng);
				console.log(typeof one_locate_Lng); 
				pathh[i] = new daum.maps.LatLng(andOneLocate[i].ONE_LOCATE_LAT,andOneLocate[i].ONE_LOCATE_LNG);
				} */
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
		//거리계산
		
		//회원이 설정한 위치
		/* var memLocate_Lat = "${memLocate.m_locate_Lat}";
		var memLocate_Lng = "${memLocate.m_locate_Lng}";
		console.log(memLocate_Lat);
		console.log(memLocate_Lng);
		
		var andOneLocate = JSON.parse('${andOneLocate}');
		console.log(andOneLocate[6].ONE_LOCATE_LAT,andOneLocate[6].ONE_LOCATE_LNG)
		
		var memPosition = new kakao.maps.LatLng(memLocate_Lat, memLocate_Lng); 
		console.log("멤버위치:"+memPosition); */
	
	    /* var pathh = [];
		for(var i in andOneLocate){
			one_locate_Lat = andOneLocate[i].ONE_LOCATE_LAT;
			one_locate_Lng = andOneLocate[i].ONE_LOCATE_LNG;
			console.log("1111"+one_locate_Lat);
			console.log("2222"+one_locate_Lng);
			console.log(typeof one_locate_Lng); 
			pathh[i] = new daum.maps.LatLng(andOneLocate[i].ONE_LOCATE_LAT,andOneLocate[i].ONE_LOCATE_LNG);
			}
		
		pathh.forEach(function (andOnePosition){
			var polyline = new daum.maps.Polyline({
				path: [
					memPosition,
					andOnePosition
				]
			});
			console.log("길이>>>>"+polyline.getLength());
			}) */

	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="init()">
	<c:set var="g_id" value="${g_id}" />
	<h1 class="and">
	<c:choose>
		<c:when test="${g_id == '010'}">
			같이먹기 <i class="fas fa-utensils"></i>
		</c:when>
		<c:when test="${g_id == '011'}">
			같이사기 <i class="fas fa-shopping-cart"></i>
		</c:when>
		<c:when test="${g_id == '012'}">
			같이하기 <i class="fas fa-user-friends"></i>
		</c:when>
	</c:choose>
	</h1> 
	<div style="width:350px; margin: 0 auto">
	<c:choose>
		<c:when test="${g_id == '010'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/andeat/searchAndOne.do">
				<div class="form-group mx-sm-3 mb-2 searchInput">
					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목">
					<input type ="hidden" name="g_id" value="${g_id}">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<div class="resisterBtn" style="width:200px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-outline-dark "> 새로운 같이먹기 등록하기 </button>
				</div>
		</c:when>
		<c:when test="${g_id == '011'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/andbuy/searchAndOne.do">
				<div class="form-group mx-sm-3 mb-2">
					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목">
					<input type ="hidden" name="g_id" value="${g_id}">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<div class="resisterBtn" style="width:200px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-outline-dark "> 새로운 같이사기 등록하기 </button>
				</div>
		</c:when>
		<c:when test="${g_id == '012'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/anddo/searchAndOne.do">
				<div class="form-group mx-sm-3 mb-2">
					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목">
					<input type ="hidden" name="g_id" value="${g_id}">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<div class="resisterBtn" style="width:200px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-outline-dark "> 새로운 같이하기 등록하기 </button>
				</div>
		</c:when>
	</c:choose>
	</div>
	<br>
	<div class="aa">
		<h4>카테고리</h4><br>
		<c:choose>
			<c:when test="${g_id == '010'}">
				<div style="width:650px; margin: 0 auto">
				<c:forEach var ="ctg" items="${ctg_eat}" > 
				<button type="button" class="btn btn-outline-dark mb-3" onclick="location.href='${contextPath}/andeat/searchAndOne.do?one_category=${ctg.gc_id}&g_id=${g_id}'">${ctg.gc_name}</button>
				</c:forEach>
				</div>
			</c:when>
			<c:when test="${g_id == '011'}">
				<div style="width:650px; margin: 0 auto">
				<c:forEach var ="ctg" items="${ctg_eat}" > 
				<button type="button" class="btn btn-outline-dark mb-3" onclick="location.href='${contextPath}/andbuy/searchAndOne.do?one_category=${ctg.gc_id}&g_id=011'">${ctg.gc_name}</button>
				</c:forEach>
				</div>
			</c:when>
			<c:when test="${g_id == '012'}">
				<div style="width:800px; margin: 0 auto">
				<c:forEach var ="ctg" items="${ctg_eat}" > 
				<button type="button" class="btn btn-outline-dark mb-3" onclick="location.href='${contextPath}/anddo/searchAndOne.do?one_category=${ctg.gc_id}&g_id=012'">${ctg.gc_name}</button>
				</c:forEach>
				</div>
			</c:when>
		</c:choose>
	</div>
	<br><br>
		<h4 style="text-align: center;">
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
		</h4><br>
	<div class="container">
		<h5 style="text-align: right;"><span class="sortDistance">거리순</span>/<span class="sortDay">마감순</span></h5><br>
		<div class="row">
			<c:forEach var ="andone" items="${recentAndOneList}" > 
				<div class="col-sm-6 mb-3">
					<div class="card">
						<a href="${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}"><div class="card-body">
				<c:choose>
					<c:when test="${g_id == '010'}"> 
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state}<span class="date">${andone.one_date}수령예정</span></h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
						<p class="card-text"> #${andone.one_hashTag}  </p>
						<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
						<p class="card-text"><span class="addrResult"></span><span class="addr">${andone.one_locate_Lat},${andone.one_locate_Lng} </span></p>
					</c:when>
					<c:when test="${g_id == '011'}">
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}수령예정</h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
						<p class="card-text"> #${andone.one_hashTag}  </p>
					</c:when>
					<c:when test="${g_id == '012'}">
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}수령예정 </h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
						<p class="card-text"> #${andone.one_hashTag}  </p>
						<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone.one_time}</span></p>
					</c:when>
				</c:choose>
						</div></a>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>	
</body>
</html>