<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
.userImg {
	position: relative;
	border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	width: 60px;
	height: 60px;
}
.fa-crown{
	color:#ffcc00;
}
.second{
	color:#C6C4C4;
}

.font { 
	font-family: 'YanoljaYacheR' !important; 
	font-size: 250%; 
} 
</style>
<script>
	
</script>
</head>
<body>
<h3 style="margin:20px auto;width:200px;" class="font">전체 회원</h3>
	<table class="table table-hover" style="width:1000px;margin:0 auto;">
		<thead>
			<tr>
				<th scope="col">순번</th>
				<th scope="col">닉네임</th>
				<th scope="col">가입날짜</th>
				<c:set var="rank" value="${rank}" />
				<c:choose>
					<c:when test="${rank eq 10 or rank eq 20}">
						<th scope="col">회원관리</th>
					</c:when>
				</c:choose>
			</tr>
		</thead>
		<c:forEach var="members" items="${members}" varStatus="status">
			<tbody>
				<tr class="userList">
					<th scope="row">${status.count}</th>
					<c:set var="memImg" value="${members.resultUserImg}" />
					<td><c:choose>
							<c:when test="${memImg eq null}">
								<img src="${contextPath}/resources/image/user.png"
									class="userImg">
							</c:when>
							<c:otherwise>
								<img src="data:image/jpg;base64, ${memImg}" class="userImg">
							</c:otherwise>
						</c:choose> ${members.m_nickname} 
						<c:set var="cm_rank" value="${members.cm_rank}" /> 
						<c:choose>
							<c:when test="${cm_rank eq '20'}">
								<i class="fas fa-crown second"></i>
							</c:when>
							<c:when test="${cm_rank eq '10'}">
								<i class="fas fa-crown"></i>
							</c:when>
						</c:choose></td>
					<td>${members.cm_joindate}</td>
					<c:set var="rank" value="${rank}"/>
					<td>
					<c:choose>
						<c:when test="${rank eq '10'}">
							<c:choose>
								<c:when test="${cm_rank eq '20'}">
									<button type="button" class="btn btn-outline-success"
									onclick="location.href='${contextPath}/club/usurpMember.do?c_id=${c_id}&m_id=${members.m_id}'">
									관리자권한 회수</button>
								<button type="button" class="btn btn-outline-danger"
									onclick="location.href='${contextPath}/club/kickMember.do?c_id=${c_id}&m_id=${members.m_id}'">
									강퇴</button>
								</c:when>
								<c:when test="${cm_rank eq '30'}">
								<button type="button" class="btn btn-outline-success"
									onclick="location.href='${contextPath}/club/qualifyMember.do?c_id=${c_id}&m_id=${members.m_id}'">
									관리자임명</button>
								<button type="button" class="btn btn-outline-danger"
									onclick="location.href='${contextPath}/club/kickMember.do?c_id=${c_id}&m_id=${members.m_id}'">
									강퇴</button>
								</c:when>
							</c:choose>
								</c:when>
						<c:when test="${rank eq '20'}">
								<c:if test="${cm_rank eq '30'}">
								<button type="button" class="btn btn-outline-danger"
									onclick="location.href='${contextPath}/club/kickMember.do?c_id=${c_id}&m_id=${members.m_id}'">
									강퇴</button>
								</c:if>
						</c:when>
					</c:choose>
					</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
	<div class="container center">
		<button type="button" style="margin:0 auto;float:none;"class="btn btn-info" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${c_id}'">
		소모임으로 돌아가기</button></div>
</body>
</html>