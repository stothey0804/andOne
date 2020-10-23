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
	
	#msgStack{
		width: 280px;
		right: 10px;
		bottom: 10px;
		position: fixed;
		z-index: 9999;
	}
</style>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	// 웹소켓 연결
	var socket  = null;

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
	
   	// 테스트 ------------------------------ 추후삭제!
	// 프로필 클릭 
	function openMemberPopup(){
			var popupOpener;
			let m_id = '${m_id}';
			popupOpener = window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
	}
   	// 테스트 ------------------------------ 추후삭제!
	
	$(document).ready(function(){
		 sock = new SockJS("<c:url value="/echo-ws"/>");
		 socket = sock;
// 		wsocket = new WebSocket("ws://localhost:8090/andOne/echo-ws");

		// 데이터를 전달 받았을때 
		sock.onmessage = onMessage;
		
		// 데이터를 보냈을 때
		
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
       	
       	
	});
   	
   	// 알림창
	function onMessage(evt){
		var data = evt.data;
		// 데이터 보여줄 방법...
		let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
		toast += "<div class='toast-header'><strong class='mr-auto'>알림</strong>";
		toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
		toast += "<span aria-hidden='true'>&times;</span></button>";
		toast += "</div> <div class='toast-body'>" + data + "</div></div>";
		$("#msgStack").append(toast);
		$(".toast").toast({"animation": true, "autohide": true, "delay": 5000});
		$('.toast').toast('show');
	};	
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand logotype ml-3 text-primary" href="${contextPath}/">&분의일 </a>
	  슬로건 넣으면 좋을거같아요
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
          	<div class="box" style="background: #BDBDBD;" onmouseover="onProfile()" onmouseout="outProfile()" onClick="openMemberPopup()">
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
							<p class="point mb-0"><span id="point" class="font-weight-bold"></span>point</p>
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
		  	<a class="btn btn-outline-secondary btn-sm" style="margin-top:-6px" href="${contextPath}/member/login.do">회원가입/로그인</a>
	      </c:otherwise>
	   </c:choose>     
	   
	  </div>
	</nav>
    <div id="msgStack">
	</div>

</body>
</html>