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

<body>
	<div class="container text-center">
		<!-- 닉네임,로그아웃 -->
		<div class="my-5">
			<p>${bm_name }님, 안녕하세요</p>
			<button class="btn btn-sm btn-dark" onclick="window.location.href='${contextPath}/biz/logout.do'">로그아웃</button>
		</div>
		<!--  메뉴그룹  -->
		<ul class="nav flex-column nav-pills nav-fill">
		  <li class="nav-item">
		    <a class="nav-link" href="#">메인</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">가게 추가하기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">리뷰 관리</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">업주 정보 수정</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">업주 탈퇴</a>
		  </li>
		</ul>
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script>
    	// 메뉴 클릭시 active 클래스 적용.
        $(document).ready(function(){
            $(".nav-link").click(function(){
            	$(".nav-link").removeClass('active');
                $(this).addClass('active');
            });
        });
    </script>
	</div>
</body>
