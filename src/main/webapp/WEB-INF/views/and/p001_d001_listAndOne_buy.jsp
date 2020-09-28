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
	h1{
		padding-left : 20px;
		font-family: 'YanoljaYacheR' !important;
	}
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
	
</head>
<body onload="init()">

	<h1>같이사기 검색결과</h1>
	<!-- 카테고리 검색 -->
	<div class="aa">
		<button type="button" class="btn btn-outline-dark btn-lg">과일</button>
		<button type="button" class="btn btn-outline-dark btn-lg">채소</button>
		<button type="button" class="btn btn-outline-dark btn-lg">정육</button>
		<button type="button" class="btn btn-outline-dark btn-lg">수산물</button>
		<button type="button" class="btn btn-outline-dark btn-lg">식품기타</button>
		<button type="button" class="btn btn-outline-dark btn-lg">패션의류</button>
	</div>
	<div class="bb">
		<button type="button" class="btn btn-outline-dark btn-lg">뷰티</button>
		<button type="button" class="btn btn-outline-dark btn-lg">완구/취미</button>
		<button type="button" class="btn btn-outline-dark btn-lg">헬스/건강식품</button>
		<button type="button" class="btn btn-outline-dark btn-lg">반려동물</button>
		<button type="button" class="btn btn-outline-dark btn-lg">주방용품</button>
		<button type="button" class="btn btn-outline-dark btn-lg">생활용품</button>
		<button type="button" class="btn btn-outline-dark btn-lg">기타</button>
	</div>
	<br><br>
	<!--진행상태 one_state, 카테고리번호one_category,제목one_title,모집인원 one_memberMax,총금액one_totalPrice,실행날짜one_date-->
	<!-- 같이먹기 검색결과 list -->
	 <div class="container">
		<div class="row">
			<c:forEach var ="andone_buy" items="${searchList_buy}" > 
			<c:url var="url"  value="add.do"  >
			 </c:url> 
				<div class="col-sm-6 mb-3">
					<div class="card">
						<a href="#"><div class="card-body">
							<h4 class="card-title">[${andone_buy.one_category}] ${andone_buy.one_title}</h4>
							<h5 class="card-subtitle mb-3 text-muted">  ${andone_buy.one_state} ${andone_buy.one_date}주문  </h5>
							<p class="card-text"> 예상 ${andone_buy.one_Price}원  n/${andone_buy.one_memberMax}명   </p>
							<p class="card-text"><span class="timeResult"></span><span class="time invisible">${andone_buy.one_time}</span></p>
						</div></a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<br><br><br>
	<div class="cc">
		<a href='${url}' button class="btn btn-outline-dark btn-lg"> 같이먹기 등록하기 </a>
	</div>
	
</body>
</html>