<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<title>헤더</title>
<style>
	.box {
	    width: 50px;
	    height: 50px; 
	    border-radius: 70%;
	    overflow: hidden;
	    cursor: pointer;
	}
	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	div#memberLayer{
		width: 250px;
		margin-left: -250px;
		margin-top: 20px;
		position: absolute;
 		visibility: hidden; 
		z-index:9999;
	}
	div#memberLayer a{
		text-decoration: none;
	}
	#memberLayer p.point::before{
		font-family: "Font Awesome 5 Free"; font-weight: 900; content: "\f51e";
		margin-right: 0.5em;
		color: #ffc107;
	}
	#memberLayer h5.card-title::before{
		font-family: "Font Awesome 5 Free"; font-weight: 900; content: "\f007";
		margin-right: 0.5em;
		color:gray;
	}
</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// comma 
	function pointToNumFormat(num) {
    	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function onProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.add("visible");
	}
	function outProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.remove("visible");
	}
	$(document).ready(function(){
    	// 세션에서 이미지 읽기
		var profileImg = '${profileImg}';
       	if(profileImg==null || profileImg==""){	
       		$(".profile").attr("src","${contextPath}/resources/image/user.png")
       	}else{	// null이 아닐경우
       		$(".profile").attr("src","data:image/png;base64, "+profileImg);
       	}
       	// 포인트 읽기
       	var point = '${point}';
       	point = pointToNumFormat(point);
       	$("#point").text(point);
       	
// 		// 프로필이미지 ->세션에서 읽기
// 		$.ajax({
//             type: "post",
//             async: "true",
//             dataType: "text",
//             data: {
//                 id: '${member.m_id}' //data로 넘겨주기
//             },
//             url: "${contextPath}/member/getByteImage",
//             success: function (data, textStatus){
//             	// 세션에서 이미지 읽기
// 				var profile_img = '${profile_img}';
// 		       	if(profile_img==null || profile_img==""){	
// 		       		$(".profile").attr("src","${contextPath}/resources/image/user.png")
// 		       	}else{	// null이 아닐경우
// 		       		$(".profile").attr("src","data:image/png;base64, "+profile_img);
// 		       	}
//              }
// 		});
	});
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand logotype" href="${contextPath}/">&분의일 </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNavDropdown">
	    <ul class="navbar-nav ml-auto mr-2">
   	      <li class="nav-item dropdown h5">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          &분의일
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
	         	<a class="dropdown-item" href="${contextPath}/andeat?g_id=010">같이먹기</a>
          		<a class="dropdown-item" href="${contextPath}/andeat?g_id=011">같이사기</a>
         		<a class="dropdown-item" href="${contextPath}/andeat?g_id=012">같이하기</a>
	        </div>
	      </li>
	      <li class="nav-item h5">
	        <a class="nav-link" href="#">찾기</a>
	      </li>
	      <li class="nav-item h5">
	        <a class="nav-link" href="${contextPath}/club/clubMain.do">소모임</a>
	      </li>
	      <li class="nav-item h5">
	        <a class="nav-link" href="${contextPath}/shop/localShopMain.do">지역업체</a>
	      </li>
       <c:choose>
          <c:when test="${isLogOn == true && m_id!= null}">
      		<li class="nav-item h5">
	       		<a class="nav-link" href="#">메시지</a>
	      	</li>
	      	</ul>
          	<!-- 프로필사진 -->
          	<div class="box" style="background: #BDBDBD;" onmouseover="onProfile()" onmouseout="outProfile()">
    			<img class="profile">
			</div>
			<div class="ml-3">
				<div id="memberLayer" class="card" onmouseover="onProfile()" onmouseout="outProfile()">
					<div class="card-body">
			            <h5 class="card-title"><b>${m_nickname}</b>님 
			            	<a href="${contextPath}/member/updateMember.do"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
							  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
							</svg></a>
			            </h5>
						<div class="row mx-1">
							<p class="point mb-0"><span id="point"></span>point</p>
							<a href="${contextPath}/point/charge.do" class="btn btn-outline-primary btn-sm ml-auto">충전</a>
						</div>
					</div>
					<ul class="list-group list-group-horizontal">
						<li class="list-group-item col-6 text-center"><a href="${contextPath}/member/mypage.do">마이페이지</a></li>
			  			<li class="list-group-item col-6 text-center"><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					</ul>
			</div>
			
          </c:when>
          <c:otherwise>
          </ul>
		  	<a class="btn btn-light" href="${contextPath}/member/login.do">회원가입/로그인</a>
	      </c:otherwise>
	   </c:choose>     
	   
	  </div>
	</nav>

<!-- <table border=0  width="100%"> -->
<!--   <tr> -->
<!--      <td> -->
<%-- 		<a href="${contextPath}/main.do"> --%>
<%-- 			<img src="${contextPath}/resources/image/duke_swing.gif"  /> --%>
<!-- 		</a> -->
<!--      </td> -->
<!--      <td> -->
<!--        <h1><font size=30>스프링실습 홈페이지!!</font></h1> -->
<!--      </td> -->
     
<!--      <td> -->

<!--      </td> -->
<!--   </tr> -->
<!-- </table> -->


</body>
</html>