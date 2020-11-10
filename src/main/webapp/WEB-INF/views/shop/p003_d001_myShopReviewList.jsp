<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

h1 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 400%;
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

div.topTitle{
	margin-top: 60px;
}

</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
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
	
	function openMemberPopup2(param){
		let m_id = param+'';
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
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
	
	function modifyButton(param){
		window.location.href='${contextPath }/shop/modifyShopReview.do?m_id=${m_id }&s_id='+param;
	}
	
	function deleteButton(param){
		var checkPop = confirm('정말로 소중한 리뷰를 삭제하시겠어요?');
		if(checkPop){
			$.ajax({
				type: "post",
				async: true,
				url: "${contextPath }/shop/deleteShopReview.do",
				dataType: "text",
				data: 'm_id=${m_id }&s_id='+param,
				success: function (data, textStatus) {
					alert('리뷰 삭제가 완료되었습니다.')
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) {
					window.location.href='${contextPath }/shop/getShopReviewList.do';
				}
			})
		}
	}
</script>
<meta charset="UTF-8">
<title>내 지역업체 리뷰(${reviewCount })</title>
</head>
<body>
	<div class="topTitle">
		<h2>내 지역업체 리뷰</h2>
	</div>
	<hr>
	<div class="container my-5 center">
		<div id="container">
		<c:forEach var="list" items="${reviewList }">
			<table id="${list.m_id }">
			<tr>
				<td align="right" colspan="5"><a href="${contextPath }/shop/localShopDetail.do?s_id=${list.s_id }">업체정보로 이동 >></a></td>
				<td></td>
				<tr class="tr1">
					<td rowspan="3" width="80">
						<div style="margin: 10px">
							<div class="card" style="width: 5rem;">
								<a href="javascript:void(0);" onclick="openMemberPopup2('${list.m_id }')">
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
					<td align="center"><button class="btn btn-sm btn-primary" onclick="modifyButton('${list.s_id}')">수정</button></td>
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
					<td align="center"><button class="btn btn-sm btn-danger" onclick="deleteButton('${list.s_id }')">삭제</button></td>
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
	</div>
	<!-- 페이징  -->
	<nav aria-label="Page navigation example">
	    <ul class="pagination justify-content-center">
	        <c:if test="${pagination.curRange ne 1 }">
	            <li class="page-item">
	            <a class="page-link" href="?curPage=1&s_id=${s_id}">처음</a> 
	            </li>
	        </c:if>
	        <c:if test="${pagination.curPage ne 1}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.prevPage}&s_id=${s_id}">이전</a> 
	                </li>
	        </c:if>
	        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
	            <c:choose>
	                <c:when test="${pageNum eq  pagination.curPage}">
	                    <li class="page-item active">
	                        <a class="page-link" href="?curPage=${pageNum}&s_id=${s_id}">${pageNum }</a>
	                    </li>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" href="?curPage=${pageNum}&s_id=${s_id}">${pageNum }</a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.nextPage}&s_id=${s_id}">다음</a> 
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