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
		margin-left: -75px;
		background-color: rgba(0,0,0,0.5);
		padding: 1.0em;
		position: absolute;
		visibility: hidden;
		z-index:9999;
	}
	div#memberLayer a{
		color: white;
	}
</style>
<script>
	function onProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.add("visible");
	}
	function outProfile(){
		var memberLayer = document.getElementById("memberLayer");
		memberLayer.classList.remove("visible");
	}
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
	         	<a class="dropdown-item" href="#">같이먹기</a>
          		<a class="dropdown-item" href="#">같이사기</a>
         		<a class="dropdown-item" href="#">같이하기</a>
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
          <c:when test="${isLogOn == true && member!= null}">
      		<li class="nav-item h5">
	       		<a class="nav-link" href="#">메시지</a>
	      	</li>
	      	</ul>
          	<!-- 프로필사진 -->
          	<div class="box" style="background: #BDBDBD;" onmouseover="onProfile()" onmouseout="outProfile()">
    			<img class="profile" src="${contextPath}/resources/image/choco.jpg">
			</div>
			<div class="ml-3">
	            <h6 class="mb-0"><b>${member.m_nickname}</b>님</h6>
				<p class="text-primary mb-0">point</p>
				<div id="memberLayer" onmouseover="onProfile()" onmouseout="outProfile()">
					<a href="${contextPath}/member/mypage"><p class="mb-2">마이페이지</p></a>
		  			<a href="${contextPath}/member/logout.do"><p class="mb-0">로그아웃</p></a>
				</div>
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