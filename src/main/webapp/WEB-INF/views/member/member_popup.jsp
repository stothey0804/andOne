<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보조회</title>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

<script>

$(document).ready(function(){
	var profileImg = '${info.m_img}';
		if(profileImg==null || profileImg==""){	
			$(".profile").attr("src","${contextPath}/resources/image/user.png")
		}else{	// null이 아닐경우
			$(".profile").attr("src","data:image/png;base64, "+profileImg);
		}
});

</script>
<style type="text/css">
	div.memberInfo{
	    padding: 2em;
	    width: 450px;
	    height: 500px;
	}
/* 	i.report{ */
/* 		font-size: 30px; */
/* 		display: block; */
/* 		text-align: right; */
/* 	} */
	.box {
	    width: 75px;
	    height: 75px; 
	    border-radius: 70%;
	    overflow: hidden;
	    cursor: pointer;
	}
	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
</style>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<!-- font Awesome -->
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
<div class="m-0 memberInfo">
	<div class="row">
		<!-- 프로필 -->
		<div class="box ml-3" style="background: #BDBDBD;">
			<img class="profile">
		</div>
		<!-- 닉네임 -->
		<div>
			<h2 class="ml-2">${info.M_NICKNAME}</h2>
			<div class="row ml-2">
				<h5>매너점수 ${info.M_SCORE}</h5>
			</div>
		</div>
		<!-- 신고아이콘 -->
		<div class="ml-auto mr-3">
<!-- 			<i class="fas fa-bullhorn report text-danger"></i> -->
			<button class="btn btn-block btn-outline-danger">신고하기</button>	
			<button class="btn btn-outline-primary mt-2">평가남기기</button>	
		</div>
	</div>
		
	<!-- 작성/참여조회 -->
	<div>
		<table class="table my-4">
			<thead>
				<tr>
					<th>작성한 &분의일</th>
					<th id="writedAndOne">${info.ANDONEPART}건</th>
					<th class="border-left">참여한 &분의일</th>
					<th id="attendedAndOne">${info.ANDONELEADER}건</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- 받은 평가 -->
	<div>
		<p class="h5 my-3">받은 평가(<span id="mReviewCnt">${info.MEMBERREVIEWCNT}</span>)</p>
		<table class="table table-borderless border-top border-bottom">
		<tbody>
			<tr>
				<td width="30%">닉네임</td>
				<td width="50%">평가상세~</td>
				<td width="20%">10점</td>
			</tr>
		</tbody>
		</table>
		<p class="text-right">더보기</p>
	</div>
</div>
</body>
</html>
