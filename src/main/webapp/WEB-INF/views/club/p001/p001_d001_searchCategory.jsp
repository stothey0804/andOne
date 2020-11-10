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
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
.card-img{
	width: 100%;
	object-fit: cover;
	height: 270px;
}
input[type="submit"] {
	font-family: FontAwesome;
}

.search {
	text-align: center;
}

body{
	background: white;
}

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
    width:300px;
    margin:0 auto;
}

.btn-outline-info:hover,
.btn-outline-info:focus {
    border-color: #002A87;
    background-color: #002A87;
    color: #FFF; }
   
div.img > img{
	vertical-align:middle;
}
* {box-sizing: border-box;}
.mySlides {display: none;}
.s {vertical-align: middle;}

    #search{
    	display:inline-block;
    	width:650px;
    }
    .category{
     	border:0; 
    	background-color:white;
    }
    .category{
    	border:0;
    	background-color:white;
    	margin-right:5px;
    	margin-left:10px;
    	width:13rem;
    }
    .category > img{
    	border-radius: 20px;
		-moz-border-radius: 20px;
		-khtml-border-radius: 20px;
		-webkit-border-radius: 20px;
    }
  
</style>
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
function init(){
	var txt = document.getElementsByClassName("str");
	for(i=0;i<txt.length;i++){
		console.log(txt[i]);
		document.getElementsByClassName("str")[i].innerHTML = txt[i].innerText;
	}
}
 
function removeHTML(text){
	text = text.toString().replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
	text = text.toString().replace(/<br\/>/ig, "\n");
	text = substring.text(0,100);
	return text;
}

</script>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

  <!-- Link Swiper's CSS -->
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

</head>

<body onload="init();">
	<div class="container my-5 center">
		<h3>카테고리</h3>
		<p>관심있는 주제별로 소모임을 찾아보세요</p>
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
		<h3>${gc_name} 검색결과 ${cnt}건</h3>
		<br>
		<div class="row">
			<c:forEach var="club" items="${categoryClubList}">
				<c:choose>
				<c:when test="${club ne null}">
				<div class="col-sm-6 mb-3 card" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${club.c_id}'"
					style="max-width: 540px; margin-left: 25px;padding:0">
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
								<div class="str d-inline-block overflow-hidden" style="max-height:100px;max-width:250px;margin-top:5px;">
								<p class="card-text" style="height: 40%">${club.c_content}</p>
								</div>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">${gc_name}</small>
								</p>
								<p class="card-text">
									<small class="text-muted" style="height: 14px">함께하는 사람 ${club.c_membercnt}</small>
								</p>
							</div>
						</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>
					검색결과가 없습니다. 다른 카테고리로 찾아보세요(ノω<。)ノ))☆.。
				</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<!-- 페이징  -->		
<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center">
        <c:if test="${pagination.curRange ne 1 }">
            <li class="page-item">
            <a class="page-link" href="?curPage=1&c_category=${c_category}">처음</a> 
            </li>
        </c:if>
        <c:if test="${pagination.curPage ne 1}">
            <li class="page-item">
                <a class="page-link" href="?curPage=${pagination.prevPage}&c_category=${c_category}">이전</a> 
                </li>
        </c:if>
        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
            <c:choose>
                <c:when test="${pageNum eq pagination.curPage}">
                    <li class="page-item active">
                        <a class="page-link" href="?curPage=${pageNum}&c_category=${c_category}">${pageNum }</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="?curPage=${pageNum}&c_category=${c_category}">${pageNum }</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
            <li class="page-item">
                <a class="page-link" href="?curPage=${pagination.nextPage}&c_category=${c_category}">다음</a> 
                </li>	                        
        </c:if>
        <c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
            <li class="page-item">
                <a class="page-link" href="#"  onClick="fn_paging('${pagination.pageCnt }')">끝</a> 
                </li>	                    
    </c:if>
    </ul>
</nav>
<!-- 페이징 END -->
	<div class="container my-5 center">
		<div class="search">
			<a href="#">#운동</a> <a href="#">#산책</a> <a href="#">#볼링</a> <a href="#">#독서</a> <br>
			<div class="form-group mx-auto searchInput center" style="width:700px;margin-top:5px;">
			<form class="searchClub container center p-1 rounded rounded-pill border border-primary" style="border-width:2px !important" name="searchFrm" method="post" action="${contextPath}/club/searchClub.do">
				<div class="input-group">
		           	<input type="text" placeholder="카테고리/소모임명" aria-describedby="button-addon1" name="searchWord" class="form-control border-0 m-1">
		        <div class="input-group-append">
		            <button id="button-addon1" type="submit" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
		        </div>
			    </div>
		    </form>
			</div>
			
			<br>
			<p style="font-size: 18px;">원하시는 소모임이 없나요? 한번 만들어보세요!</p>
			<button type="button"
				class="btn btn-outline-info btn-block search create"
				style="font-size: 18px;"
				onclick="location.href='${contextPath}/club/createClubForm.do'">소모임 만들기</button>
		</div>
		<br>
	</div>
	
</body>
</html>