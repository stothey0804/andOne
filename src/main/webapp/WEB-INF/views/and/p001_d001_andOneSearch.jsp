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
      		console.log(times);
      
      		for(let i=0; i<times.length; i++){
      			var result = times[i].textContent;
      			timeResults[i].innerHTML = timeForToday(result);
      		}
		}
		
        function timeForToday(value) {
        const today = new Date();
        console.log(today);
        const timeValue = new Date(value);
        console.log(timeValue);

        const betweenTime = Math.floor((today.getTime() - timeValue.getTime())/1000/60);
        console.log(betweenTime);
            if (betweenTime < 1) return '방금전';
            if (betweenTime < 60) {
                return betweenTime+'분전';
            }

        const betweenTimeHour = Math.floor(betweenTime / 60);
        console.log(betweenTimeHour);
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
	
	
	<!--진행상태 one_state, 카테고리번호one_category,제목one_title,모집인원 one_memberMax,총금액one_totalPrice,실행날짜one_date-->
	<!-- 같이먹기 검색결과 list -->
	 <div class="container">
		<c:if test="${size eq 0}">
				<div class="col-12 m-3 bg-light card">
					<div class="cord-body p-5 text-center">
					등록된 &amp;분의 일이 없습니다 ㅠㅠ
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
								<p class="card-text float-left"> #${andone.one_hashTag}  </p>
								<p class="card-text float-right h6"> 예상 <b>${andone.one_price}</b> <span class="text-secondary"> <i class="fas fa-user-friends"></i> n/${andone.one_memberMax} </span></p>
							</div>
							<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone.one_time} </span></p>
							<c:if test="${g_id eq '010'}">
							<p class="card-text"><span class="addrResult"></span><span class="addr">${andone.one_locate_Lat},${andone.one_locate_Lng} </span></p>
							</c:if>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<br><br><br>
				<div class="resisterBtn" style="width:500px; margin: 0 auto">
					<button onclick="location.href='${contextPath}/andeat/insertAndOnePage.do?g_id=${g_id}'" class="btn btn-primary rounded btn-block"> 새로운 활동 등록하기 </button>
			</div>
	
</body>
</html>