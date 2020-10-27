<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제완료</title>
<script>
	function pointToNumFormat(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	var payPoint = '${payPoint}';
	var nowPoint = '${nowPoint}';
</script>
<style type="text/css">
	div{
		text-align: center;
	    padding: 65px;
	}
	svg{
		color: #28a745;
	}
	#chargeAmount{
		color: #28a745;
	}
	#nowPoint{
		color: #007bff;
	}
</style>
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
</head>
<body>
<div>
	<svg width="5em" height="5em" viewBox="0 0 16 16" class="bi bi-check-circle-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
	</svg>
	<h2>${m_nickname}님의 &분의일 결제가 완료되었습니다.</h2><br>
	<h4>결제포인트  <span id="payPoint"></span>P</h4>
	<h4>보유포인트  <span id="nowPoint"></span>P</h4>
	<button onClick="checkAndOnePage()">확인</button>
	
</div>
	<script type="text/javascript">
		document.getElementById('payPoint').innerHTML = pointToNumFormat(payPoint);
		document.getElementById('nowPoint').innerHTML = pointToNumFormat(nowPoint);
		
		function checkAndOnePage(){
			opener.location.href="${contextPath}/and/participateAndOne.do";
			window.close();
		}
		
	</script>
</body>
</html>
