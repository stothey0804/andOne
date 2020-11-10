<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<script>
		function init(){
			let times = document.querySelectorAll("span.time");
			let timeResults = document.querySelectorAll("span.timeResult");
      
      		for(let i=0; i<times.length; i++){
      			var result = times[i].textContent;
      			timeResults[i].innerHTML = timeForToday(result);
      		}
      		let prices = document.querySelectorAll("span.price");
  			let priceResults = document.querySelectorAll("span.priceResult");
  			
  			for(let i=0; i<prices.length; i++){
  				var pResult = prices[i].textContent;
  				priceResults[i].innerHTML = pointToNumFormat(pResult);
	  		}
		}
		
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
	<style>
	 @font-face {
	        font-family: 'YanoljaYacheR';
	        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff') format('woff');
	        font-weight: normal;
	        font-style: normal;
      }
	.and{
		padding-left : 30px;
		font-family: 'YanoljaYacheR' !important;
		font-size: 32px;
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
	 .and_card{
		cursor: pointer;
	}
	</style>
	
</head>
<body onload="init()" class="bg-light">
	<c:set var="g_id" value="${g_id}" />
	<c:set var="size" value="${size}" />
	<p class="and text-dark text-center mt-5">
	<c:choose>
		<c:when test="${g_id == '010'}">
			같이먹기 검색결과  ${size}건
		</c:when>
		<c:when test="${g_id == '011'}">
			같이사기 검색결과 ${size}건
		</c:when>
		<c:when test="${g_id == '012'}">
			같이하기 검색결과 ${size}건
		</c:when>
	</c:choose>
	</p>
	
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
	<div class="container clearfix mb-5">
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
					<button type="button" class="btn btn-outline-primary mb-3" onclick="location.href='${contextPath}/andbuy/searchAndOne.do?one_category=${ctg.gc_id}&g_id=011'">${ctg.gc_name}</button>
					</c:forEach>
				</c:when>
				<c:when test="${g_id == '012'}">
					<c:forEach var ="ctg" items="${ctg}" > 
					<button type="button" class="btn btn-outline-primary mb-3" onclick="location.href='${contextPath}/anddo/searchAndOne.do?one_category=${ctg.gc_id}&g_id=012'">${ctg.gc_name}</button>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</div>
	</div>
	
	<div class="container clearfix mt-5">
		<p class="float-right">
		<a href="${contextPath}/and/searchAndOne.do?g_id=${g_id}&flag=distance&one_category=${one_category}&totalSearch=${totalSearch}">거리순</a>/
		<a href="${contextPath}/and/searchAndOne.do?g_id=${g_id}&flag=date&one_category=${one_category}&totalSearch=${totalSearch}">마감순</a></p>
	</div>
	<!--진행상태 one_state, 카테고리번호one_category,제목one_title,모집인원 one_memberMax,총금액one_totalPrice,실행날짜one_date-->
	<!-- 같이먹기 검색결과 list -->
	 <div class="container">
		<c:if test="${size eq 0}">
				<div class="col-12 m-3 bg-light card">
					<div class="cord-body p-5 text-center">
					등록된 &amp;분의 일이 없습니다 .
					</div>
				</div>
		</c:if>
		<div class="row">
			<c:forEach var ="andone" items="${SearchAndOneList}" > 
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
								${andone.one_state}</span>
								</p>
								<p class="card-subtitle mb-3 text-muted float-right"><span class="date">${andone.one_date} 수령예정</span></p>
							</div>
							<div class="clearfix">
								<p class="card-text float-left mb-0 text-truncate" style="max-width:260px"> #${andone.one_hashTag}  </p>
								<p class="card-text float-right h6"><span class="price invisible"><b>${andone.one_price}</b></span> 예상 <span class="priceResult"></span> <span class="text-secondary"> <i class="fas fa-user-friends"></i>${andone.one_member}/${andone.one_memberMax} </span></p>
							</div>
							<p class="card-text float-left"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
							<p class="card-text float-right h6"> ${andone.addrDetail} / ${andone.distance}km  </p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
		<!-- 페이징  -->
	<nav aria-label="Page navigation example">
	    <ul class="pagination justify-content-center">
	        <c:if test="${pagination.curRange ne 1 }">
	            <li class="page-item">
	            <a class="page-link" href="?curPage=1">처음</a> 
	            </li>
	        </c:if>
	        <c:if test="${pagination.curPage ne 1}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.prevPage}&one_category=${one_category}&g_id=${g_id}&totalSearch=${totalSearch}">이전</a> 
	                </li>
	        </c:if>
	        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
	            <c:choose>
	                <c:when test="${pageNum eq  pagination.curPage}">
	                    <li class="page-item active">
	                        <a class="page-link" href="?curPage=${pageNum}&one_category=${one_category}&g_id=${g_id}&totalSearch=${totalSearch}">${pageNum}</a>
	                    </li>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" href="?curPage=${pageNum}&one_category=${one_category}&g_id=${g_id}&totalSearch=${totalSearch}">${pageNum}</a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
	            <li class="page-item">
	                <a class="page-link" href="?curPage=${pagination.nextPage}&one_category=${one_category}&g_id=${g_id}&totalSearch=${totalSearch}">다음</a> 
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
	<br><br><br>
				<div class="resisterBtn" style="width:500px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-primary rounded btn-block"> 새로운 활동 등록하기 </button>
			</div>
	
</body>
</html>