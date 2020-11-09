<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	div.form-group{
		width: 100%;
	}
 	.container{ 
		margin: 0 auto;
	}
</style>
<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javascript">

//성별별 이용서비스
var barChartData = {
		
		labels: ['같이먹기', '같이사기', '같이하기'],
		datasets: [{
			label: '여성',
			backgroundColor: '#dd4814',
			data: [ '${andgf.one010}','${andgf.one011}','${andgf.one012}' ]
		}, {
			label: '남성',
			backgroundColor: '#428bca',
			data: [ '${andgm.one010}','${andgm.one011}','${andgm.one012}' ]
		}]

	};
// 나이대별 이용서비스
var barChartData2 = {
		labels: ['같이먹기', '같이사기', '같이하기'],
		datasets: [{
			label: '10대',
			backgroundColor: 'orange',
			data: [ '${anda10.one010}','${anda10.one011}','${anda10.one012}' ]
		}, {
			label: '20대',
			backgroundColor: '#00bc8c',
			data: [ '${anda20.one010}','${anda20.one011}','${anda20.one012}' ]
		}, {
			label: '30대',
			backgroundColor: '#428bca',
			data: [ '${anda30.one010}','${anda30.one011}','${anda30.one012}' ]
		}, {
			label: '40대',
			backgroundColor: '#6d5177',
			data: [ '${anda40.one010}','${anda40.one011}','${anda40.one012}' ]
		}, {
			label: '50대',
			backgroundColor: '#dd4814',
			data: [ '${anda50.one010}','${anda50.one011}','${anda50.one012}' ]
		}]

	};	
// 데이터 - 성별
var genderMemberdata = {
		labels: ['여성', '남성'],
		datasets: [{
			data: ['${gender.female}','${gender.male}'],
			backgroundColor: ['#dd4814','#428bca']
		}]
	};
// 데이터 - 연령
var ageMemberdata = {
		labels: ['10대', '20대', '30대', '40대', '50대이상'],
		datasets: [{
			data: ['${ages.age10}','${ages.age20}','${ages.age30}','${ages.age40}','${ages.age50}'],
			backgroundColor: ['orange','#00bc8c','#428bca','#6d5177','#dd4814']
		}]
	};

// 데이터 - &분의일 전체
var andOneTypeData = {
		labels: ${totalAndSet.labels},
		datasets: [{
			data: ${totalAndSet.data},
			backgroundColor: ['#00bc8c','#428bca','#6d5177']
		}]	
}

// 데이터 - 같이먹기 카테고리
var eatCategory = {
		labels: ${eatCategory.labels},
		datasets: [{
			data: ${eatCategory.data},
			backgroundColor: ['#1abc9c','#2ecc71','#3498db','#9b59b6','#8e44ad','#2980b9','#27ae60','#16a085',
				'#f1c40f','#e67e22','#e74c3c','#c0392b','#d35400','#f39c12']
		}]	
}
var buyCategory = {
		labels: ${buyCategory.labels},
		datasets: [{
			data: ${buyCategory.data},
			backgroundColor: ['#1abc9c','#2ecc71','#3498db','#9b59b6','#8e44ad','#2980b9','#27ae60','#16a085',
				'#f1c40f','#e67e22','#e74c3c','#c0392b','#d35400','#f39c12']
		}]	
}
var actCategory = {
		labels: ${actCategory.labels},
		datasets: [{
			data: ${actCategory.data},
			backgroundColor: ['#1abc9c','#2ecc71','#3498db','#9b59b6','#8e44ad','#2980b9','#27ae60','#16a085',
				'#f1c40f','#e67e22','#e74c3c','#c0392b','#d35400','#f39c12']
		}]	
}

$(document).ready(function(){
	// 성별별 n분의일 사용
	var ctx = document.getElementById('genderAndOneChart').getContext('2d');
	window.myBar = new Chart(ctx, {
	    type: 'horizontalBar',
	    data:  barChartData,
	    options: {
	        scales: {
	            xAxes: [{
	                stacked: true
	            }],
	            yAxes: [{
	                stacked: true
	            }]
	        },
			legend: {	position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}
			}
	    }
	});
	// 연령대별 n분의일 사용
	var ctx2 = document.getElementById('ageAndOneChart').getContext('2d');
	window.myBar = new Chart(ctx2, {
	    type: 'horizontalBar',
	    data:  barChartData2,
	    options: {
	        scales: {
	            xAxes: [{
	                stacked: true
	            }],
	            yAxes: [{
	                stacked: true
	            }]
	        },
			legend: {	position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}
			}
	    }
	});

	
	// 성별 비율
	var gChartDiv = document.getElementById("genderChart");
	window.myBar = new Chart( gChartDiv, {
		type: 'doughnut',
		data: genderMemberdata,
		options: {
			legend: {	position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}
			}
		}
	});
	
	// 연령 비율
	var gChartDiv2 = document.getElementById("ageChart");
	window.myBar = new Chart( gChartDiv2, {
		type: 'doughnut',
		data: ageMemberdata,
		options: {
			legend: {
				position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}}
			}
	});
	
	// &분의일 전체 점유율
	var oneTypeChart = document.getElementById("oneTypeChart");
	window.myBar = new Chart( oneTypeChart, {
		type: 'doughnut',
		data: andOneTypeData,
		options: {
			legend: {
				position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}}
			}
	});
	
	// 같이먹기 점유율
	var buyCategoryChart = document.getElementById("buyCategoryChart");
	window.myBar = new Chart( buyCategoryChart, {
		type: 'pie',
		data: buyCategory,
		options: {
			legend: {
				position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}}
			}
	});
	var eatCategoryChart = document.getElementById("eatCategoryChart");
	window.myBar = new Chart( eatCategoryChart, {
		type: 'pie',
		data: eatCategory,
		options: {
			legend: {
				position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}}
			}
	});
	var actCategoryChart = document.getElementById("actCategoryChart");
	window.myBar = new Chart( actCategoryChart, {
		type: 'pie',
		data: actCategory,
		options: {
			legend: {
				position: 'bottom',
				labels: {pointStyle:'circle', usePointStyle:true}}
			}
	});
		
});

</script>
</head>
<body>
<div class="container">
	<!-- 회원 통계 -->
	<h2 class="mx-5 mt-5 mb-3">회원 통계</h2>
	<div class="row mx-5">
		<div class="col-6 card p-3" style="margin-left:-3px">
			<h5>성별 비율 현황</h5>
			<canvas id="genderChart"></canvas>
		</div>
		<div class="col-6 card p-3" style="margin-left:3px">
			<h5>나이대 비율 현황</h5>
			<canvas id="ageChart"></canvas>
		</div>
	</div>
	<div class="row mx-5" style="margin-top: 3px">
		<div class="col-6 card p-3" style="margin-left:-3px">
			<h5>성별별 이용서비스</h5>
			<canvas id="genderAndOneChart"></canvas>
		</div>
		<div class="col-6 card p-3" style="margin-left:3px">
			<h5>나이대별 이용 서비스</h5>
			<canvas id="ageAndOneChart"></canvas>
		</div>
	</div>
	
	<!-- 엔분의일 통계 -->
	<h2 class="mx-5 mt-5 mb-3">&amp;분의일 통계</h2>
	<div class="row mx-5">
		<div class="col-6 card p-3" style="margin-left:-3px">
			<h5>서비스별 점유율</h5>
			<canvas id="oneTypeChart"></canvas>
		</div>
		<div class="col-6 card p-3" style="margin-left:3px">
			<h5>같이먹기 카테고리 점유율</h5>
			<canvas id="eatCategoryChart"></canvas>
		</div>
	</div>
	<div class="row mx-5" style="margin-top: 3px">
		<div class="col-6 card p-3" style="margin-left:-3px">
			<h5>같이사기 카테고리 점유율</h5>
			<canvas id="buyCategoryChart"></canvas>
		</div>
		<div class="col-6 card p-3" style="margin-left:3px">
			<h5>같이하기 카테고리 점유율</h5>
			<canvas id="actCategoryChart"></canvas>
		</div>
	</div>
	
	<div class="mb-5"></div>
	
</div>
</body>
</html>