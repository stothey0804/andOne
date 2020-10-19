<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.text-over-cut {
	  display: block;
	  width: 150px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  margin: 0;
	}
	.more svg{
		margin-top: -3px;
	}
</style>
</head>
<body>
<div class="container mx-auto p-5">
	<h3>내 매너점수</h3>
	<hr>
	<!-- 회원정보 요약  -->
	<div class="card mx-5 mt-5">
		<div class="card-body">
			<h5 class="card-title">내가 받은 평점 <span class="h3">${m_score}</span>점</h5>
			<p class="card-text">무슨 텍스트를 넣어야할까...</p>
		</div>
	</div>
	<!-- 작성평가/받은평가 최근리스트 조회 -->
	<div class="row mx-5">
		<div class="col-6 mt-3 border-left">
			<h5 class="my-3">최근 쓴 평가</h5>
			<table class="table">
			<thead>
				<tr>
					<th class="text-center">닉네임</th>
					<th class="text-center" width="50%">내용</th>
					<th class="text-center" >점수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="wroteList" items="${wroteList}">
				<tr>
					<td >${wroteList.target_nickname}</td>
					<td width="50%">
						<div class="text-over-cut">${wroteList.mr_content}</div>
					</td>
					<td class="text-center">${wroteList.mr_score}점</td>
				</tr>
			</c:forEach>
			</tbody>
			</table>
			<div class="clearfix">
			<a class="more float-right">더 보기 <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/></svg>
			</a>
			</div>
		</div>
		<div class="col-6 mt-3">
			<h5 class="my-3">최근 받은 평가</h5>
			<table class="table">
			<thead>
				<tr>
					<th class="text-center">닉네임</th>
					<th class="text-center" width="50%">내용</th>
					<th class="text-center">점수</th>
				</tr>
			</thead>
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
			<a class="more float-right">더 보기 <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/></svg>
			</a>
			</div>
		</div>
	
	</div>

</div>
</body>
</html>