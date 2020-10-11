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
 <style>
 </style>
  <meta charset="UTF-8">
  <title>사이드 메뉴</title>
</head>
<body>

<!-- 메뉴그룹 시작 -->
<p class="mb-0 bg-secondary">
  <a class="btn btn-link text-white" data-toggle="collapse" href="#menu1" role="button" aria-expanded="false" aria-controls="collapseExample">
   	조회/관리
  </a>
</p>
<div class="collapse show" id="menu1">
	  			<ul class="nav flex-column">
			<!-- 메뉴목록시작 -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	지역가입신청 내역 조회 / 승인
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	지역업체 회원 조회
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="${contextPath}/admin/searchMemberList.do">
	              	일반회원 조회
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	&분의일 게시글 조회
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	소모임 조회
	            </a>
	          </li>
	    </ul>
</div>
<!-- 메뉴그룹 끝 -->
<!-- 메뉴그룹 시작 -->
<p class="mb-0 bg-secondary">
  <a class="btn btn-link text-white" data-toggle="collapse" href="#menu2" role="button" aria-expanded="false" aria-controls="collapseExample">
   	공지사항
  </a>
</p>
<div class="collapse show" id="menu2">
	  			<ul class="nav flex-column">
			<!-- 메뉴목록시작 -->
	          <li class="nav-item">
	            <a class="nav-link" href="${contextPath}/admin/initNotice.do">
	              	공지사항 작성
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="${contextPath}/admin/searchNotice.do">
	              	공지사항 조회
	            </a>
	          </li>
	    </ul>
</div>
<!-- 메뉴그룹 끝 -->
<!-- 메뉴그룹 시작 -->
<p class="mb-0 bg-secondary">
  <a class="btn btn-link text-white" data-toggle="collapse" href="#menu3" role="button" aria-expanded="false" aria-controls="collapseExample">
   	문의/신고사항
  </a>
</p>
<div class="collapse show" id="menu3">
	  			<ul class="nav flex-column">
			<!-- 메뉴목록시작 -->
	          <li class="nav-item">
	            <a class="nav-link" href="${contextPath}/admin/searchNewQnA.do">
	              	새로 접수된 문의
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	새로 접수된 신고
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="${contextPath}/admin/searchAllQnA.do">
	              	문의 리스트
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	신고 리스트
	            </a>
	          </li>
	    </ul>
</div>
<!-- 메뉴그룹 끝 -->
<!-- 메뉴그룹 시작 -->
<p class="mb-0 bg-secondary">
  <a class="btn btn-link text-white" data-toggle="collapse" href="#menu4" role="button" aria-expanded="false" aria-controls="collapseExample">
   	통계
  </a>
</p>
<div class="collapse show" id="menu4">
	  			<ul class="nav flex-column">
			<!-- 메뉴목록시작 -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	회원 통계
	            </a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="#">
	              	&분의일 작성글 통계
	            </a>
	          </li>
	    </ul>
</div>
<!-- 메뉴그룹 끝 -->

<!-- / 메뉴 끝 / -->
 
<!-- 	<h4> -->
<%-- 		<a href="${contextPath}/member/listMembers.do" >회원관리</a><br> --%>
<%-- 		<a href="${contextPath}/board/listArticles.do" >게시판관리</a><br> --%>
<!-- 		<a href="#"  class="no-underline">상품관리</a><br> -->
<!-- 	</h4> -->
</body>
</html>