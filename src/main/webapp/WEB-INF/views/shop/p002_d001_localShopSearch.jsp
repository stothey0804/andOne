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

.headTable{
	width:100%;
}

.toggleBG{
	background: #CCCCCC; 
	width: 70px; 
	height: 30px; 
	border: 1px solid #CCCCCC; 
	border-radius: 15px;
}

.toggleFG{
	background: #FFFFFF;
	width: 30px; 
	height: 30px; 
	border: none; 
	border-radius: 15px; 
	position: relative; 
	left: 0px;
}

.searchInput{
	width: 500px;
}
.thumb{
	height: 250px;
	max-width: 100%;
	object-fit: cover;
}
</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
		var usedFilter = '${filter}';
		var usedKeyword = '${usedKeyword}';
		var lat = '';
		var lng = '';
		var isLimited = false;
		
		$(document).ready(function () {
			console.log(usedKeyword);
			console.log(usedFilter);
			$('#searchWindow').val(usedKeyword);
			getUserLocation();
			$('button#10').click(function () {
				usedFilter = '10';
				search(1);
			})
			$('button#20').click(function () {
				usedFilter = '20';
				search(1);
			})
			$('button#30').click(function () {
				usedFilter = '30';
				search(1);
			})
			$('button#40').click(function () {
				usedFilter = '40';
				search(1);
			})
			$('button#50').click(function () {
				usedFilter = '50';
				search(1);
			})
			$('button#60').click(function () {
				usedFilter = '60';
				search(1);
			})
			$('button#70').click(function () {
				usedFilter = '70';
				search(1);
			})
			$('button#80').click(function () {
				usedFilter = '80';
				search(1);
			})
			$('button#90').click(function () {
				usedFilter = '90';
				search(1);
			})
			$('button#all').click(function () {
				usedFilter = '';
				search(1);
			})
			$('#sel').change(function () {
				search(1);
			})
		})
		
		$(document).on('click', '.toggleBG', function () {
	        var toggleBG = $(this);
	        var toggleFG = $(this).find('.toggleFG');
	        var left = toggleFG.css('left');
	        if(left == '40px') {
	            toggleBG.css('background', '#CCCCCC');
	            toggleActionStart(toggleFG, 'TO_LEFT');
	        }else if(left == '0px') {
	            toggleBG.css('background', '#4cbdff');
	            toggleActionStart(toggleFG, 'TO_RIGHT');
	        }
	        isLimited = !isLimited;
	        search(1);
	    });
	    
		function removeHTML(text){
			text = text.toString().replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
			text = text.toString().replace(/<br\/>/ig, "\n");
			return text;
		}
		
	    // 토글 버튼 이동 모션 함수
	    function toggleActionStart(toggleBtn, LR) {
	        // 0.01초 단위로 실행
	        var intervalID = setInterval(
	            function() {
	                // 버튼 이동
	                var left = parseInt(toggleBtn.css('left'));
	                left += (LR == 'TO_RIGHT') ? 5 : -5;
	                if(left >= 0 && left <= 40) {
	                    left += 'px';
	                    toggleBtn.css('left', left);
	                }
	            }, 10);
	        setTimeout(function(){
	            clearInterval(intervalID);
	        }, 201);
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
		
		function searchButton(){
			usedKeyword = $('#searchWindow').val();
			search(1);
		}
		
		function getUserLocation(){
			$.ajax({
				type: "post",
				async: true,
				url: "/andOne/member/selectLocate.do",
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
					search(1);
				}
			});
		}
		
		function search(param){
			var searchParameter = "curPage=" + param + "&searchKeyword=" + usedKeyword + "&filter=" + usedFilter + "&status=" + $('#sel').val();
			if(isLimited){
				searchParameter += "&limit=30&M_LOCATE_LAT=" + lat + "&M_LOCATE_LNG=" + lng;
			}
			$.ajax({
				type: "post",
				async: true,
				url: "/andOne/shop/searchByAjax.do",
				dataType: "text",
				beforeSend:function(data, textStatus){
					$('.pg').html('');
					$('#result').html("<img src='${contextPath}/resources/image/loading.gif' style='display: block; margin: 0 auto; width:100px; height:100px;'>");
				},
				data: searchParameter,
				success: function (data, textStatus) {
					var jsonStr = data;
					var jsonInfo = JSON.parse(jsonStr);
					//html 태그 들어갈 스트링 변수
					var output = "";
					var paging = "";
					//검색결과 없음
					if(Object.keys(jsonInfo.resultList).length == 0){
						output += '<img class="noResult" src="${contextPath }/resources/image/no_result.png">';
					//검색결과 있음	
					}else{
						for (var i in jsonInfo.resultList) {
							console.log(jsonInfo.resultList[i].s_name);
// 							output += "<div class='col-sm-6 mb-3' style='max-width: 540px;'>";
							output += "<div class='col-md-6'>";
// 							output += "<div class='row no-gutters'>";
							output += "<div class='row bg-white no-gutters border rounded overflow-hidden flex-md-row mb-4 position-relative'>";
// 							output += "<div class='col-sm-6'>";
							output += "<div class='col-5'>";
							output += "<a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo.resultList[i].s_id+"'>";
							//가게 이미지
							if(Object.keys(jsonInfo.resultList[i].shopImage).length != 0){
								output += "<img src='data:image/jpg;base64,"+jsonInfo.resultList[i].shopImage[0].si_encodedImg+"' class='thumb'alt='...'>";
							}else{
								output += "<img src='${contextPath }/resources/image/ina.png' class='thumb' alt='...'>";
							}
							output += "</a>";
							output += "</div>";
// 							output += "<div class='col-sm-6'>";
							output += "<div class='col p-4 d-flex flex-column position-static'>";
// 							output += "<div>";
							//가게 이름
							output += "<div class='card-title clearfix'><h5><a href='${contextPath}/shop/localShopDetail.do?s_id="+jsonInfo.resultList[i].s_id+"'>" + jsonInfo.resultList[i].s_name + "</a></h5>";
							output += "<p class='text-secondary float-left'>"+jsonInfo.resultList[i].gc_name+"</p>";
							output += "<p class='float-right'>"+printStar(jsonInfo.resultList[i].s_score)+"</p></div>";
							//가게 소개
							output += "<p class='card-text' style='height: 78px;overflow:hidden'>" + removeHTML(jsonInfo.resultList[i].s_content) + "</p>";
							output += "<p class='card-text'>";
							//후기 숫자
							output += "<small class='text-muted text-right' style='height: 14px'>리뷰 " + jsonInfo.resultList[i].reviewCount + "건</small>";
// 							output += "</p>";
// 							output += "<p class='card-text'>";
// 							output += "<small class='text-muted' style='height: 14px'>";
							//별점

// 							output += "</p>";
// 							output += "</div>";
							output += "</div>";
							output += "</div>";
							output += "</div>";
						}
						paging += '<nav aria-label="Page navigation example">';
						paging += '<ul class="pagination justify-content-center">';
						if(jsonInfo.pagination.curRange != 1){
							paging += '<li class="page-item">';
							paging += '<a class="page-link" href="javascript:void(0);" id="1">처음</a>';
							paging += '</li>';
						}
						if(jsonInfo.pagination.curPage != 1){
							paging += '<li class="page-item">';
							paging += '<a class="page-link" href="javascript:void(0);" id="'+jsonInfo.pagination.prevPage+'">이전</a>';
							paging += '</li>';
						}
						for(let i=jsonInfo.pagination.startPage; i<=jsonInfo.pagination.endPage; i++){
							if(i==jsonInfo.pagination.curPage){
								paging += '<li class="page-item active">';
								paging += '<a class="page-link" id="'+i+'" href="javascript:void(0);">'+i+'</a>';
								paging += '</li>';
							}else{
								paging += '<li class="page-item">';
								paging += '<a class="page-link" id="'+i+'" href="javascript:void(0);">'+i+'</a>';
								paging += '</li>';
							}
						}
						if(jsonInfo.pagination.curPage != jsonInfo.pagination.pageCnt && jsonInfo.pagination.pageCnt > 0){
							paging += '<li class="page-item">';
							paging += '<a class="page-link" href="javascript:void(0);" id="'+jsonInfo.pagination.nextPage+'">다음</a>';
							paging += '</li>';
						}
						paging += '</ul>';
						paging += '</nav>';
					}
					$('div.row#result').html(output);
					$('div.pg').html(paging);
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) {
					$('.page-link').click(function(){
						search(this.id);
					})
				}
			});
		}
	</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body class="bg-light">
	<div class="container my-5 center">
		<div class="search" align="center">
			<p class="text-dark text-center mt-5 logotype" style="font-size:32px;">지역업체 검색결과</p>
			<div class="form-group mx-auto searchInput">
				  <div class="p-1 rounded rounded-pill border border-primary" style="border-width:2px !important">
		            <div class="input-group">
		              <input id="searchWindow" type="search" placeholder="검색" aria-describedby="button-addon1" name="searchWindow" class="form-control border-0 m-1 bg-light">
		              <div class="input-group-append">
		                <button id="button-addon1" onClick="searchButton();" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
		              </div>
		            </div>
		          </div>
<!-- 					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목"> -->
					<input type ="hidden" name="g_id" value="${g_id}">
<!-- 					<input type="submit" class="btn btn-outline-dark" value="검색"><br><br> -->
				</div>
			<div class="container clearfix mb-4">
				<p class="h5 float-left mt-1">카테고리
				<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			 			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
				</svg>
				<div class="mx-auto">
					<button id="all" type="button" class="btn btn-outline-primary"
						onclick="">전체</button>
					<button id="10" type="button" class="btn btn-outline-primary" onclick="">카페</button>
					<button id="20" type="button" class="btn btn-outline-primary" onclick="">음식점</button>
					<button id="30" type="button" class="btn btn-outline-primary" onclick="">병원</button>
					<button id="40" type="button" class="btn btn-outline-primary" onclick="">학원</button>
					<button id="50" type="button" class="btn btn-outline-primary" onclick="">미용</button>
					<button id="60" type="button" class="btn btn-outline-primary" onclick="">마트/유통</button>
					<button id="70" type="button" class="btn btn-outline-primary" onclick="">공방/클래스</button>
					<button id="80" type="button" class="btn btn-outline-primary" onclick="">인테리어</button>
					<button id="90" type="button" class="btn btn-outline-primary" onclick="">부동산</button>
				</div>
			</div>
		</div>
		<hr>
		<table class="headTable">
		<tr>
		<td width="90%" align="left"><h3>업체 리스트</h3>
		</td>
		</tr>	
		<tr>
		<td>
		<div class='toggleBG'>
        <button class='toggleFG'></button>
   		</div>
   		</td>
   		<td>
   		<select id="sel">
			<option value="SCORE" selected>평점순</option>
			<option value="REVIEW">후기많은순</option>
		</select>
   		</td>
   		</tr>
		</table>
		 <br><br>
		<div class="row" id="result"></div>
		<br><br><br>
		<div class="pg"></div>
	</div>
	<br>

</body>

</html>