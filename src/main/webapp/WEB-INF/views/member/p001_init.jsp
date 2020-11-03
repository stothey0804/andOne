<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<div class="container mx-auto p-5">
	<h3>마이페이지</h3>
	<hr>
	<!-- 회원정보 요약  -->
	<div class="card mx-5 mt-5">
		<div class="card-body">
			<h5 class="card-title clearfix">환영합니다 <b>${m_nickname}</b>님!
			<span class="float-right card-text h6 text-muted">${info.m_joindate} 가입</span>
			</h5>
			<p class="card-text clearfix"><a href="${contextPath}/member/updateMember.do"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456l-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
							  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
							</svg>&nbsp;회원정보수정</a>
			<span class="float-right h3">
			<c:if test="${empty info.m_score}">
				받은 점수가 없어요 :(
			</c:if>
			<c:if test="${not empty info.m_score}">
				매너점수&nbsp;<span class="font-weight-bold">${info.m_score}</span>점
			</c:if>
			</span>				
			</p>
		</div>
	</div>
	<!-- 최근참여현황 -->
	<h4 class="mx-5 mt-5 mb-3">최근 이용 현황(7일)</h4>
	<div class="row mx-5">
		<div class="col-6 card p-3" style="margin-left:-3px">
		  <ul class="list-group list-group-flush">
		    <li class="list-group-item clearfix">신청대기중 &amp;분의일 <span class="float-right font-weight-bold">${info.om_ready}</span></li>
		    <li class="list-group-item clearfix">진행중 &amp;분의일 <span class="float-right font-weight-bold">${info.om_exe}</span></li>
		    <li class="list-group-item clearfix">진행완료 &amp;분의일 <span class="float-right font-weight-bold">${info.om_complete}</span></li>
		  </ul>
		</div>
		<div class="col-6 card p-3" style="margin-left:3px">
		  <ul class="list-group list-group-flush">
		    <li class="list-group-item clearfix">처리중인 문의내역 <span class="float-right font-weight-bold">${info.q_ready}</span></li>
		    <li class="list-group-item clearfix">처리중인 신고내역 <span class="float-right font-weight-bold">${info.r_ready}</span></li>
		  </ul>
		</div>
	</div>
	
	<!-- 문의 -->
	<div class="card mx-5 mt-3 bg-light">
	  <div class="card-body">
	    <h5 class="card-title">이용 중 어려움이 있으신가요?</h5>
	    <div class="clearfix">
		    <p class="card-text float-left">1:1 문의를 남겨주시면 도와드리겠습니다 :)</p>
	  	 	<a href="${contextPath}/member/qna.do" class="btn btn-primary float-right">문의하기</a>
	    </div>
	  </div>
	</div>
</div>
</body>
</html>