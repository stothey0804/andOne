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
</style>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
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
	
	function blind(param1, param2){
		alert('s_id : ' + param1 + ' / m_id : ' + param2);
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
				<table><tr><td width="500" height="70">
				<h1><a href="${contextPath }/shop/localShopDetail.do?s_id=${resultVO.s_id }">${resultVO.s_name }</a></h1></td><td width="350" height="70"></td>
				<td align="right" width="150" height="70">
				<button id="all" type="button" class="btn btn-outline-info" onclick="writeButton()">수정하기</button>
				</td></tr><tr><td colspan="3" height="30">${resultVO.s_score }</td>
				</tr><tr><td colspan="3" height="30">${resultVO.gc_name }</td>
				</tr><tr><td colspan="3" height="30">
				</td></tr><tr>
				<td valign="top" colspan="3" height="100">${resultVO.s_content }</td>
				</tr></table>
				<h3><a href="${contextPath }/shop/getShopReviewList.do?s_id=${resultVO.s_id }">후기(${resultVO.reviewCount })</a></h3>
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
					<td rowspan="2" align="center"><button class="btn btn-sm btn-primary" onclick="blind('${list.s_id}','${list.m_id }')">숨기기</button></td>
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
				<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
					integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
					crossorigin="anonymous"></script>
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