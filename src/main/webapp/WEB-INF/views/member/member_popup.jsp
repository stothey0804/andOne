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
	var warning = '${warning}';
	if(warning!=null && warning!=''){
		alert(warning);
	}
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
	.text-over-cut {
	  display: block;
	  width: 150px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  margin: 0;
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
			<a class="btn btn-block btn-outline-danger" href="${contextPath}/member/reportInit.do?target=${info.M_ID}&flag=member">신고하기</a>	
			<a class="btn btn-outline-primary mt-2" href="${contextPath}/member/writeReview.do?target=${info.M_ID}">평가남기기</a>	
		</div>
	</div>
		
	<!-- 작성/참여조회 -->
	<div>
		<table class="table my-4">
			<thead>
				<tr>
					<th>작성한 &분의일</th>
					<th id="writedAndOne">${info.ANDONELEADER}건</th>
					<th class="border-left">참여한 &분의일</th>
					<th id="attendedAndOne">${info.ANDONEPART}건</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- 받은 평가 -->
	<div>
		<p class="h5 my-3">받은 평가(<span id="mReviewCnt">${info.MEMBERREVIEWCNT}</span>)</p>
		<table class="table table-borderless border-top border-bottom">
		<tbody>
			<c:forEach var="receivedList" items="${receivedList}">
				<tr>
					<td >${receivedList.m_nickname}</td>
					<td width="50%">
						<div class="text-over-cut">${receivedList.mr_content}</div>
					</td>
					<td class="text-center">${receivedList.mr_score}점</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		<div class="clearfix">
		<a href="${contextPath}/member/receivedReview.do?target=${info.M_ID}" target="_top" class="btn btn-sm btn-secondary float-right">더 보기 </a>
		</div>
	</div>
</div>
</body>
</html>
