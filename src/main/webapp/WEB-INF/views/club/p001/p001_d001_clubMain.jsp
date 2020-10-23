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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@import url(https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css);
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
@font-face {
  font-family:'Nanum Myeongjo', serif;
}
.card_img{
	object-fit: cover;
}
input[type="submit"] {
	font-family: FontAwesome;
}

.search {
	text-align: center;
}

.create {
	width: 350px;
	margin: auto;
}
body{
	background: white;
}
<<<<<<< HEAD
=======
/* .card,.mainClub{ */
/* 	background:#f5f7f8; */
/* } */
.mainClub{
	background:#f5f7f8;
}
>>>>>>> branch 'master' of https://github.com/stothey0804/andOne.git

.mainClub:hover{
	top: -2px;
  	box-shadow: 0 4px 5px rgba(0,0,0,0.2);
  	cursor: pointer;
}

.card:hover{
	top: -2px;
  	box-shadow: 0 4px 5px rgba(0,0,0,0.2);
  	cursor: pointer;
}

.btn-outline-info{
    border-color: #002A87;
    color: #002A87;
}

.btn-outline-info:hover,
.btn-outline-info:focus {
    border-color: #002A87;
    background-color: #002A87;
    color: #FFF; }
    
div.img{
	line-height:225px;
}
div.img > img{
	object-fit: cover;
<<<<<<< HEAD
    height: 270px 
=======
	height: 270px 
/* 	vertical-align:middle; */
>>>>>>> branch 'master' of https://github.com/stothey0804/andOne.git
}
* {box-sizing: border-box;}
.mySlides {display: none;}
.s {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

    html,
    body {
      position: relative;
      height: 100%;
    }

    body {
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }

    .swiper-container {
      width: 100%;
      height: 500px;
    }

    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;
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
    .swiper-slide > img{
    	object-fit: contain;
    	width: 100%;
    }
    #search{
    	display:inline-block;
    	width:650px;
    }
    .category{
    	border:0;
    	background-color:white;
    	margin-right:5px;
    	margin-left:10px;
    	width:13rem;
    	border-radius: 13px 13px 0px 0px;
    }
    .category > img{
    	border-radius: 13px;
		-moz-border-radius: 13px;
		-khtml-border-radius: 13px;
		-webkit-border-radius: 13px;
    }
    .category > .card-body{
    	padding-left:10px;
    	padding-top:10px;
    }
.btn-success:hover {
    background-color: #00033D !important;
}
.btn-success{
	background-color:#002A87 !important;
	border-color:#002A87;
	color:white;
}
.swiper-text{
	font-family: 'NanumSquare', sans-serif;
	position: absolute;
 	font-weight:bold;
 	background-color: rgba(0,0,0,0.3);
 	height:100%;
 	width:100%; 
}

 	
</style>
<script>
function init(){
	var txt = document.getElementsByClassName("str");
	for(i=0;i<txt.length;i++){
		document.getElementsByClassName("str")[i].innerHTML = txt[i].innerText;
	}
}
 
function removeHTML(text){
	text = text.toString().replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
	text = text.toString().replace(/<br\/>/ig, "\n");
	return text;
}

</script>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

  <!-- Link Swiper's CSS -->
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

</head>

<body onload="init();">
  <!-- Swiper -->
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
      	<img src="https://cdn.pixabay.com/photo/2015/09/02/13/26/glasses-919071_1280.jpg">
      	<div class="swiper-text">
      		<h1 class="display-4" style="color:white;margin-top:180px;">&분의 일 사람들과 <br>꾸준히 함께하고 싶나요?</h1>
      	</div>
      </div>
      <div class="swiper-slide">
      	<img src="https://cdn.pixabay.com/photo/2014/11/17/13/17/crossfit-534615_1280.jpg">
      	<div class="swiper-text">
      		<h1 class="display-4" style="color:white;margin-top:180px;">&분의 일 사람들과<br> 꾸준히 함께하고 싶나요?</h1>
      	</div>
      </div>
      <div class="swiper-slide">
      	<img src="https://cdn.pixabay.com/photo/2015/01/08/18/27/startup-593341_1280.jpg">
      	<div class="swiper-text">
      		<h1 class="display-4" style="color:white;margin-top:180px;">&분의 일 사람들과<br> 꾸준히 함께하고 싶나요?</h1>
      	</div>
      </div>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>

  <!-- Swiper JS -->
  <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper-container', {
      spaceBetween: 30,
      centeredSlides: true,
      autoplay: {
        delay: 2500,
        disableOnInteraction: false,
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  </script>
	<div class="container my-5 center">
		<h3>카테고리</h3>
		<p>관심있는 소모임을 주제별로  찾아보세요</p>
		<div class="row">
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=10'">
				<img
					src="https://cdn.pixabay.com/photo/2017/06/05/11/01/airport-2373727_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">아웃도어/여행</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=20'">
				<img
					src="https://cdn.pixabay.com/photo/2017/01/20/11/44/yoga-1994667_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">운동/스포츠</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=30'">
				<img
					src="https://cdn.pixabay.com/photo/2015/05/15/14/21/books-768426_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">인문학/책/글</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=40'">
				<img
					src="https://cdn.pixabay.com/photo/2018/07/08/08/45/abc-3523453_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">외국/언어</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=50'">
				<img
					src="https://cdn.pixabay.com/photo/2016/11/29/06/17/audience-1867754_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">문화/공연</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=60'">
				<img
					src="https://cdn.pixabay.com/photo/2016/03/26/22/36/music-1281642_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">음악/악기</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=70'">
				<img
					src="https://cdn.pixabay.com/photo/2019/12/08/21/10/potter-4682257_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">공예/만들기</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=80'">
				<img
					src="https://cdn.pixabay.com/photo/2016/03/09/09/22/workplace-1245776_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">사교/인맥</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=90'">
				<img
					src="https://cdn.pixabay.com/photo/2017/01/16/09/49/greek-dancing-at-sunset-1983650_1280.jpg"
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">댄스/무용</p>
				</div>
			</div>
			<div class="card category" onclick="location.href='${contextPath}/club/searchClubCategory.do?c_category=100'">
				<img
					src="https://media.istockphoto.com/photos/small-group-of-people-working-on-humanitarian-aid-project-picture-id1218067733?b=1&k=6&m=1218067733&s=170667a&w=0&h=KfFISXayvV6KJfNnVsgT0d4cTSd9MzeOc81l3DSfsuI="
					class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-text">봉사활동</p>
				</div>
			</div>
		</div>
		<div style="margin-top:10px;margin-bottom:4px;">
			<h3 style="display:inline-block">인기 소모임</h3>
			<button onclick="location.href='#myList'" class="btn btn-success" style="float:right;">나의 소모임</button>
		</div>
		<br>
		<div class="row">
			<c:forEach var="club" items="${clubList}">
				<div class="col-sm-6 mb-3 card" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${club.c_id}'"
					style="max-width: 540px; max-height:270px; margin-left: 25px;padding:0">
					<div class="row no-gutters">
						<div class="col-sm-6 img">
						<c:choose>
						<c:when test="${club.resultImg eq null}">
							<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img" alt="...">
						</c:when>
						<c:otherwise>
							<img src="data:image/jpg;base64,${club.resultImg}" class="card-img"
								alt="...">
						</c:otherwise>
						</c:choose>
						</div>
						<div class="col-sm-6">
							<div class="card-body" style="height: 225px">
								<h5 class="card-title" style="height: 20%">${club.c_name}</h5>
								<div class="str">
								<p class="card-text" style="height: 40%">${club.c_content}</p>
								</div>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">${club.c_category}</small>
								</p>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">함께하는 사람 ${club.c_membercnt}</small>
								</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="container my-5 center">
		<div class="search">
			<a href="#">#운동</a> <a href="#">#산책</a> <a href="#">#볼링</a> <a href="#">#독서</a> <br>
			<form name="searchFrm" method="post"
				action="${contextPath}/club/searchClub.do">
				<div>
				<input type="text" class="form-control" placeholder="검색" name="searchWord" id="search"> 
				<input class="btn btn-secondary" type="submit" value="&#xf002;" style="margin-top:-6px;margin-left:-4px;width:80px;">
				</div>
			</form>
			<br>
			<p style="font-size: 18px;">원하시는 소모임이 없나요? 한번 만들어보세요!</p>
			<button type="button"
				class="btn btn-outline-info btn-block search create"
				style="font-size: 18px;"
				onclick="location.href='${contextPath}/club/createClubForm.do'">소모임 만들기</button>
		</div>
		<br>

		<div id="myList"><h3>나의 소모임</h3></div>
		<c:set var="myClubCnt" value="${myClubCnt}" />
		<c:choose>
			<c:when test="${myClubCnt eq 0}">
				<div class="card">
					<div class="card-body" style="text-align: center;">
					가입된 소모임이 없습니다. 함께 해봐요!</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<c:forEach var="club" items="${myClubList}">
						<div class="club"
							style="margin-left: 45px; margin-right: 45px; margin-top: 20px" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${club.c_id}'">
							<div class="card" style="width: 18rem;">
							<div class="img">
								<c:choose>
								<c:when test="${club.resultImg eq null}">
									<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img" alt="...">
								</c:when>
								<c:otherwise>
									<img src="data:image/jpg;base64,${club.resultImg}" class="card-img" alt="...">
								</c:otherwise>
								</c:choose>
							</div>
								<div class="card-body">
									<h5 class="card-title">${club.c_name }</h5>
									<p class="card-text">함께하는 사람 ${club.c_membercnt }</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>