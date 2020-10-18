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

</style>
<script>
	$(document).ready(function(){
		$(".userList").click(function(){
			let id = getUserId(this);
			$("#"+id+" .intro").toggle();
		})
		
		function getUserId(elem){
			let result = $("tbody").has(elem);
			console.log(result);
			return result.attr("id");
		}
	})
</script>
</head>
<body>
<h3>가입 요청 멤버 목록</h3>
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">닉네임</th>
      <th scope="col">가입요청일자</th>
      <th scope="col">수락/거절</th>
    </tr>
  </thead>
		<c:forEach var="waitMember" items="${waitMember}" varStatus="status">
<tbody id="${status.count}">
		<tr class="userList">
		<th scope="row">${status.count}</th>
			<c:set var="memImg" value="${waitMember.resultUserImg}" />
			<td>
			<c:choose>
				<c:when test="${memImg eq null}">
					<img src="${contextPath}/resources/image/user.png" class="userImg">
				</c:when>
				<c:otherwise>
					<img src="data:image/jpg;base64, ${memImg}" class="userImg">
				</c:otherwise>
			</c:choose>
			${waitMember.m_nickname}
			</td>
			<td>${waitMember.cm_joindate}</td>
			<td onclick="event.cancelBubble=true">
				<button type="button" class="btn btn-outline-danger"
				onclick="location.href='${contextPath}/club/permitMember.do?c_id=${c_id}&m_id=${waitMember.m_id}'">수락</button>
				<button type="button" class="btn btn-outline-dark"
				onclick="location.href='${contextPath}/club/denyMember.do?c_id=${c_id}&m_id=${waitMember.m_id}'">거절</button>
			</td>
			</tr>
		<tr style="display:none;" class="intro">
		<td></td>
		<td></td>
		<td><p style="font-weight:bold">가입인사<p><br>${waitMember.cm_intro}</td>
		<td></td>
		</tr>
</tbody>
		</c:forEach>
</table>
</body>
</html>