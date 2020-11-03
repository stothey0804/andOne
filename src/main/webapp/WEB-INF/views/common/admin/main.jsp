<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
<style type="text/css">
	.container{ 
		margin: 0 auto;
	}
</style>
<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javascript">

var newMemberData= {
		labels: ${newMemberSet.labels},
		datasets: [{
			data: ${newMemberSet.data},
			backgroundColor: 'transparent',
			borderColor: '#2980b9'
		}]	
}

var newSalesData= {
		labels: ${newSalesSet.labels},
		datasets: [{
			data: ${newSalesSet.data},
			backgroundColor: '#2980b9'
		}]	
}

$(document).ready(function(){
	let today = new Date();
	document.getElementById('today').innerHTML = today.toLocaleDateString();	
	
	// 신규멤버 차트
	var newMemberChart = document.getElementById("newMemberChart").getContext('2d');
	window.myBar = new Chart( newMemberChart, {
		type: 'line',
		data: newMemberData,
		options: {
			legend: {
				display : false
			}
		}
	});
	// 신규매출 차트
	var newSalesChart = document.getElementById("newSalesChart").getContext('2d');
	window.myBar = new Chart( newSalesChart, {
		type: 'bar',
		data: newSalesData,
		options: {
			legend: {
				display : false
			}
		}
	});
});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h4 class="mx-5 mt-5 mb-3" id="today"></h4>
		<div class="row mx-5">
			<div class="col-6 card p-3" style="margin-left:-3px">
			  <ul class="list-group list-group-flush">
			    <li class="list-group-item clearfix">신규 가입자 수 <a href="${contextPath}/admin/searchMemberList.do" class="float-right font-weight-bold">${newDataSet.newMember}</a></li>
			    <li class="list-group-item clearfix">등록된 &amp;분의일 <a href="#" class="float-right font-weight-bold">${newDataSet.newAndone}</a></li>
			    <li class="list-group-item clearfix">소모임 개설 수 <a href="#" class="float-right font-weight-bold">${newDataSet.newClub}</a></li>
			  </ul>
			</div>
			<div class="col-6 card p-3" style="margin-left:3px">
			  <ul class="list-group list-group-flush">
			    <li class="list-group-item clearfix">가입대기 지역업체 회원 수 <a href="#" class="float-right font-weight-bold">${newDataSet.newBmember}</a></li>
			    <li class="list-group-item clearfix">신규 문의건 수 <a href="${contextPath}/admin/searchNewQnA.do" class="float-right font-weight-bold">${newDataSet.newQna}</a></li>
			    <li class="list-group-item clearfix">신규 신고건 수 <a href="${contextPath}/admin/searchAllReport.do?newList=true" class="float-right font-weight-bold">${newDataSet.newReport}</a></li>
			  </ul>
			</div>
		</div>
		
		<div class="row mx-5 mt-5">
			<div class="col-6">
				<h5 class="mb-3">신규 가입자 수 (최근7일)</h5>
				<hr class="my-3">
			</div>
			<div class="col-6">
				<h5 class="mb-3 ">포인트 충전액 (최근7일)</h5>
				<hr class="my-3">
			</div>
		</div>
		<div class="row mx-5">
			<canvas class="col-6" id="newMemberChart">
			</canvas>
			<canvas class="col-6" id="newSalesChart">
			</canvas>
		</div>
		
		
		
	</div>
</body>
</html>