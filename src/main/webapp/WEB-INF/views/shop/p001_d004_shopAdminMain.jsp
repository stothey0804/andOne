<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

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

i.fa-chevron-left{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-chevron-right{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-star-half-alt{
	color:rgb(255,234,0);
}

i.fa-star{
	color:rgb(255,234,0);
}

h5 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 150%;
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

img.noResult{
	display:block; margin:0px auto;
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

.map_wrap {position:relative;width:100%;height:350px;}
.map_title {font-weight:bold;display:block;}
.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#centerAddr {display:block;margin-top:2px;font-weight: normal;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}

#pop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 20%;
	left: 25%;
	width: 480px;
	height: auto;
	z-index: 10;
}

#imgPop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 15%;
	left: 25%;
	width: auto;
	height: auto;
	z-index: 99;
}

#imgPop #close{
	top:10px;
	right: 10px;
	position: absolute;
	z-index:9999;
}

#imgPop #prev{
  	top: 50%;
	left: 10px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

#imgPop #next{
	top: 50%;
	right: -40px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

table.shopInfo{
	width:100%;
}
</style>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
	$(document).ready(function(){
		$('#imgPop').hide();
		$('div#close').click(function(){
			$('#imgPop').hide();
		})
		$('div#prev').click(function(){
			prev();
		})
		$('div#next').click(function(){
			next();
		})
		$('img.clickImg').click(function(){
			$('#imgPopContent').html('<img src="'+(this.src)+'" id="'+(this.id)+'" width="720">');
			$('#imgPop').show();
		})
		var hashtag = '${resultVO.s_hashtag }';
		var hashtagArr = hashtag.split(',');
		for(let i=0; i<hashtagArr.length; i++){
			$('#hashtag').append('#'+hashtagArr[i]+'&nbsp;');
		}
	})
	function prev(){
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if(idx != 0){
			idx--;
			let path = '#'+m_id+'-split-'+idx+'-split-'+length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html('<img src="'+src+'" id="'+id+'" width="720">');
		}
	}
	
	function next(){
		let imgId = $('#imgPopContent img').attr('id');
		let idArr = imgId.split('-split-');
		let m_id = idArr[0];
		let idx = idArr[1];
		let length = idArr[2];
		if(idx != length){
			idx++;
			let path = '#'+m_id+'-split-'+idx+'-split-'+length;
			let src = $(path).attr('src');
			let id = $(path).attr('id');
			$('#imgPopContent').html('<img src="'+src+'" id="'+id+'" width="720">');
		}
	}
	
	function openMemberPopup(param){
		let m_id = param+'';
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	function blind(param1, param2, param3){
		if(param3 == 1){
			var checkPop = confirm('해당 리뷰를 숨김처리 하시겠습니까?');
		}else{
			var checkPop = confirm('해당 리뷰의 숨김처리를 해제하시겠습니까?');
		}
		if(checkPop){
			$.ajax({
				type: "post",
				async: true,
				url: "http://localhost:8090/andOne/biz/updateReviewPublicStatus.do",
				dataType: "text",
				data: 'm_id='+param2+'&s_id='+param1+'&sr_public='+param3,
				success: function (data, textStatus) {
					alert('처리가 완료되었습니다.')
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) {
					window.location.href='${contextPath }/biz/loginOk.do';
				}
			})
		}
	}
	
</script>
<meta charset="UTF-8">
<title>업체관리자페이지</title>
</head>
<body>
	<div class="container my-5 center">
		<c:choose>
			<c:when test="${isNull eq true}">
			등록된 가게 정보가 없습니다~~~ 등록하세요~~~~<br>
			등록은 나중에 만들거지롱~~~
			</c:when>
			<c:when test="${isNull eq false}">
			<h3>우리매장 정보</h3>
				<div class="row">
					<c:forEach var="i" begin="1" end="${(fn:length(resultVO.shopImage)) }">
						<div style="margin: 15px">
							<div class="card" style="width: 20rem;">
								<img src="data:image/jpg;base64,${resultVO.shopImage[i-1].si_encodedImg }" id="${resultVO.s_id }-split-${i-1 }-split-${(fn:length(resultVO.shopImage))-1 }" class="card-img-top clickImg" alt="...">
							</div>
						</div>
					</c:forEach>
				</div>
				<table class="shopInfo"><tr><td width="500" height="70">
				<h1>${resultVO.s_name }</h1></td><td width="350" height="70"></td>
				<td align="right" width="150" height="70">
				</td></tr><tr><td height="30">${resultVO.s_score }</td>
				<td align="right" colspan="2" rowspan="4">
				<div class="map_wrap" style="width:90%;height:90%;">
				<div id="map" style="width:100%;height:350px;position:relative;overflow:hidden;">
				</div>
				<div class="hAddr">
				<span class="map_title">업체 상세 주소</span>
				<span id="centerAddr"></span>
				</div>
				</div>
				</td>
				</tr><tr><td height="30">${resultVO.gc_name }</td>
				</tr><tr><td id="hashtag" height="30">
				</td></tr><tr>
				<td valign="top" height="300">${resultVO.s_content }</td>
				</tr></table>
				<h3><a href="${contextPath }/biz/shopReviewList.do">후기(${resultVO.reviewCount })</a></h3>
				<hr>
				<c:forEach var="list" items="${resultVO.shopReviewList }">
				<table id="${list.m_id }">
				<tr class="tr1">
					<td rowspan="3" width="80">
						<div style="margin: 10px">
							<div class="card" style="width: 5rem;">
								<a href="javascript:void(0);" onclick="openMemberPopup('${list.m_id }')">
									<c:choose>
										<c:when test="${empty list.m_encodedImg }">
											<img src="${contextPath }/resources/image/user.png" class="card-img-top" alt="...">
										</c:when>
										<c:otherwise>
											<img src="data:image/jpg;base64,${list.m_encodedImg }" class="card-img-top" alt="...">
										</c:otherwise>
									</c:choose>
								</a>
							</div>
						</div>
					</td>
					<td class="clickArea" id="${list.m_id }" width="680">
						${list.m_nickname }
						<c:if test="${list.sr_public eq 0 }"> (숨김 처리됨)</c:if>
					</td>
					<c:forEach var="i" begin="1" end="${3-(fn:length(list.shopReviewImage)) }">
						<td rowspan="3" width="80">
							<div style="margin:5px">
								<div style="width:5rem;">
									<img src="${contextPath}/resources/image/nbsp_img.png" class="card-img-top" alt="...">
								</div>
							</div>
						</td>
					</c:forEach>
					<c:forEach var="j" begin="1" end="${(fn:length(list.shopReviewImage)) }">
						<td rowspan="3" width="80">
							<div style="margin:5px">
								<div style="width:5rem;">
									<img src="data:image/jpg;base64,${list.shopReviewImage[j-1].ri_encodedImg }" id="${list.m_id }-split-${j-1 }-split-${fn:length(list.shopReviewImage)-1 }" class="card-img-top clickImg" alt="...">
								</div>
							</div>
						</td>
					</c:forEach>
					<c:choose>
						<c:when test="${list.sr_public eq 0 }">
							<td rowspan="2" align="center"><button class="btn btn-sm btn-info" onclick="blind('${list.s_id}','${list.m_id }','${list.sr_public }')">보이기</button></td>
						</c:when>
						<c:otherwise>
							<td rowspan="2" align="center"><button class="btn btn-sm btn-primary" onclick="blind('${list.s_id}','${list.m_id }','${list.sr_public }')">숨기기</button></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr class="tr2">
					<td class="clickArea" id="${list.m_id }" width="80">
						<c:choose>
							<c:when test="${list.sr_score eq 10}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 9}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 8}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 7}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 6}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 5}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 4}">
								<i class="fas fa-star"></i><i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 3}">
								<i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
							</c:when>
							<c:when test="${list.sr_score eq 2}">
								<i class="fas fa-star"></i>
							</c:when>
							<c:when test="${list.sr_score eq 1}">
								<i class="fas fa-star-half-alt"></i>
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr class="tr3">
					<td class="clickArea" id="${list.m_id }" width="80">
						${list.sr_content }
					</td>
					<td>
						${list.sr_date }
					</td>
				</tr>	
			</table>
			<hr>
		</c:forEach>
				<h3>최근 6개월 통계</h3>
				<div class="chartContainer"
					style="position: relative; height: 60%; width: 60%">
					<canvas id="myChart"></canvas>
					<canvas id="myChart2"></canvas>
				</div>
				<script
					src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
					integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
					crossorigin="anonymous"></script>
				<script
					src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
					integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
					crossorigin="anonymous"></script>
				<script>
					var ctx = document.getElementById('myChart').getContext(
							'2d');
					var chart = new Chart(ctx, {
						// 챠트 종류를 선택 
						type : 'line',
						// 챠트를 그릴 데이타 
						data : {
							labels : [ '6개월 전', '5개월 전', '4개월 전', '3개월 전',
									'2개월 전', '1개월 전', '이번달' ],
							datasets : [ {
								label : '가게평점',
								backgroundColor : 'transparent',
								borderColor : 'blue',
								data : [ '${scoreStatistics.six }', '${scoreStatistics.five }', 
									'${scoreStatistics.four }', '${scoreStatistics.three }', 
									'${scoreStatistics.two }', '${scoreStatistics.one }', '${scoreStatistics.recent }' ]
							} ]
						},
						// 옵션
						options : {
							scales : {
								yAxes : [ {
									ticks : {
										max : 10
									}
								} ]
							}
						}
					});
				</script>
				<script>
					var ctx = document.getElementById('myChart2').getContext(
							'2d');
					var chart = new Chart(ctx, {
						// 챠트 종류를 선택 
						type : 'line',
						// 챠트를 그릴 데이타 
						data : {
							labels : [ '6개월 전', '5개월 전', '4개월 전', '3개월 전',
									'2개월 전', '1개월 전', '이번달' ],
							datasets : [ {
								label : '등록된 리뷰 수',
								backgroundColor : 'transparent',
								borderColor : 'red',
								data : [ '${reviewStatistics.six }', '${reviewStatistics.five }',
									'${reviewStatistics.four }', '${reviewStatistics.three }', 
									'${reviewStatistics.two }', '${reviewStatistics.one }', '${reviewStatistics.recent }' ]
							} ]
						},
						// 옵션
						options : {}
					});
				</script>
				<script>
					//지도생성
					//위도, 경도
					var x = '${resultVO.s_locate_lat}';
					var y = '${resultVO.s_locate_lng}';
					console.log(x);
					console.log(y);
					//지도 그리기
					var container = document.getElementById('map');
					console.log(container);
					var options = {
						center: new kakao.maps.LatLng(x, y),
						level: 3
					};
					var map = new kakao.maps.Map(container, options);
					//마커 생성
					var markerPosition  = new kakao.maps.LatLng(x, y);
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					marker.setMap(map);
					//좌표로 주소 받아오기
					var geocoder = new kakao.maps.services.Geocoder();
					var coord = new kakao.maps.LatLng(x, y);
					var callback = function(result, status) {
					    if (status === kakao.maps.services.Status.OK) {
					        console.log('그런 너를 마주칠까 ' + result[0].address.address_name + '을 못가');
					        var infoDiv = document.getElementById('centerAddr');
					        infoDiv.innerHTML = result[0].address.address_name;
					    }
					};
					geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
					//인포윈도우
					var iwContent = '<div style="padding:5px;">${resultVO.s_name}</div>';
					var iwPosition = new kakao.maps.LatLng(x, y);
					var infowindow = new kakao.maps.InfoWindow({
					    position : iwPosition, 
					    content : iwContent 
					});
					infowindow.open(map, marker);
				</script>
			</c:when>
		</c:choose>
	</div>
	<div id='imgPop'>
		<div id='close'><img width='30' height='30' src='${contextPath }/resources/image/close2.png'></div>
		<div id='imgPopContent' style="width:auto;">
		
		</div>
		<div id='prev'><i class="fas fa-chevron-left"></i></div>
		<div id='next'><i class="fas fa-chevron-right"></i></div>
	</div>
</body>
	
</html>