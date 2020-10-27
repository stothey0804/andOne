<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<style>
		.m_img {
				position: relative;
				border-radius: 70px;
				-moz-border-radius: 70px;
				-khtml-border-radius: 70px;
				-webkit-border-radius: 70px;
				width: 60px;
				height: 60px;
				}
	</style>
	<script>
		function okAndOne(){
			$.ajax({
				type : "post",
    			dataType: "text",
    			async: "true",
    			url:"${contextPath}/and/okOneMember.do",
    			data:{
    				//글번호랑  m_id보내야함
    			},
			})
		}
		function denyAndOne(){
			$.ajax({
				type : "post",
    			dataType: "text",
    			async: "true",
    			url:"${contextPath}/and/denyOneMember.do",
    			data:{
    				"one_price" : price,
    			},
			})
		}
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
			<h2 class="m-5">&분의일 참가요청</h2>
			<div class="form-group col-sm-15 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th>닉네임</th><th>신청날짜</th><th>수락/거절</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${AndOnewaitMemList}" varStatus="status">
						<c:set var="mem_img" value="${list.resultUserImg}"/>
					<tbody>
						<tr class="arcticleSubject text-center">
						<td scope="row">${status.count}</td>
						<td>
						<c:choose>
							<c:when test="${mem_img eq null}">
								<img src="${contextPath}/resources/image/user.png" class="m_img">
							</c:when>
							<c:otherwise>
								<img src="data:image/jpg;base64, ${list.resultUserImg}" class="m_img">
							</c:otherwise>
						</c:choose>
						${list.m_nickname} 
						</td>
						<td>${list.om_date}</td>
						<td onclick="event.cancelBubble=true">
							<button type="button" class="btn btn-outline-danger" onclick="okAndOne">수락</button>
							<button type="button" class="btn btn-outline-dark" onclick="denyAndOne">거절</button>
						</td>
					</tbody>
					<span class="m_id invisible">${list.m_id}</span>
					<span class="one_id invisible">${list.one_id}</span>
					</c:forEach>
				</table>
			</div>
</div>
</body>
</html>