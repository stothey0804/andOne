<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
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
	</style>
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
</head>
<body onload="init()">
	<c:set var="g_id" value="${g_id}" />
	<div style="width:350px; margin: 0 auto">
	<c:choose>
		<c:when test="${g_id == '010'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/andeat/searchAndOne.do?g_id=${g_id}">
				<div class="form-group mx-sm-3 mb-2">
					<input class="form-control" type ="text" name="totalSearch" placeholder="카테고리/지역/제목">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<c:url var="url"  value="add.do"  >
					<a href='${url}' class="btn btn-outline-dark "> 새로운 같이먹기 등록하기 </a>
				</c:url> 
		</c:when>
		<c:when test="${g_id == '011'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/andbuy/searchAndOne.do?g_id=${g_id}">
				<div class="form-group mx-sm-3 mb-2">
					<input class="form-control" type ="text" placeholder="카테고리/지역/제목">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<c:url var="url"  value="add.do"  >
					<a href='${url}' class="btn btn-outline-dark "> 새로운 같이사기 등록하기 </a>
				</c:url> 
		</c:when>
		<c:when test="${g_id == '012'}">
			<form name="eat" class="form-inline" method="get" action="${contextPath}/anddo/searchAndOne.do?g_id=${g_id}">
				<div class="form-group mx-sm-3 mb-2">
					<input class="form-control" type ="text" placeholder="카테고리/지역/제목">
				</div>
					<input type="submit" class="btn btn-outline-dark mb-2" value="검색"><br><br>
			</form>
				<c:url var="url"  value="add.do"  >
					<a href='${url}' class="btn btn-outline-dark "> 새로운 같이하기 등록하기 </a>
				</c:url> 
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
				<div style="width:570px; margin: 0 auto">
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
		<div class="row">
			<c:forEach var ="andone" items="${recentAndOneList}" > 
				<div class="col-sm-6 mb-3">
					<div class="card">
						<a href="#"><div class="card-body">
				<c:choose>
					<c:when test="${g_id == '010'}"> 
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}주문  </h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
						<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone.one_time}</span></p>
					</c:when>
					<c:when test="${g_id == '011'}">
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}수령예정  </h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
						<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone.one_time}</span></p>
					</c:when>
					<c:when test="${g_id == '012'}">
						<h4 class="card-title">[${andone.one_category}] ${andone.one_title}</h4>
						<h5 class="card-subtitle mb-3 text-muted">  ${andone.one_state} ${andone.one_date}  </h5>
						<p class="card-text"> 예상 ${andone.one_price}  n/${andone.one_memberMax}명   </p>
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