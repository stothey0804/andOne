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
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// 웹소켓 연결
	var socket  = null;
	$(document).ready(function(){
		 sock = new SockJS("<c:url value="/echo-ws"/>");
		 socket = sock;
		 
		 // send 클릭시
// 		 $("#sendBtn").click(function(){
// 			 sendMessage();
// 		 })
	});
	
// 	function sendMessage(){
// 		sock.send($("#inputMsg").val());	// 소켓으로 전송
// 	}
	
</script>
<style type="text/css">
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand logotype" href="${contextPath}/admin/">&분의일 </a>
	  <span class="navbar-brand mb-0">관리자페이지</span>
<!-- 	  	<form class="form-inline msg"> -->
<!-- 		  	<input type="text" class="form-control mb-2 mr-sm-2" id="inputMsg" placeholder="메시지 입력"> -->
<!-- 		  	<button type="button" class="btn btn-primary mb-2" id="sendBtn">Send</button> -->
<!-- 	  	</form> -->
 		<a class="btn btn-dark ml-auto" href="${contextPath}/member/logout.do">로그아웃</a>
	</nav>

</body>
</html>