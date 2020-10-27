<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가작성 완료</title>
<style type="text/css">
	div{
		text-align: center;
	    padding: 65px;
	}
	svg{
		color: #28a745;
	}
	#chargeAmount{
		color: #28a745;
	}
	#nowPoint{
		color: #007bff;
	}
</style>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 소켓연결
		sock = new SockJS("<c:url value="/echo-ws"/>");
		socket = sock;
		
		let mr_target = '${mr_target}';
		let mr_score = '${mr_score}';
		if(mr_target!=null && mr_target!=''){
			let type = '60';	// 유저평가
			let target = mr_target;
			let content = '유저평가를 받았습니다. - ' + mr_score + '점';
			let url = '${contextPath}/member/receivedReview.do';
			// db저장	
			$.ajax({
				type: 'post',
				url: '${contextPath}/member/saveNotify.do',
				dataType: 'text',
				data: {
					target: target,
					content: content,
					type: type,
					url: url
				},
				success: function(){
					socket.send("유저평가,"+target+","+content+","+url);	// 소켓에 전달
				}
			});
		}
		
	});
</script>	
</head>
<body>
<div>
	<svg width="5em" height="5em" viewBox="0 0 16 16" class="bi bi-check-circle-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
	</svg>
	<br>
	<h2>평가작성을<br>완료하였습니다.</h2><br>
	<a class="btn btn-large btn-primary text-center" onClick='window.close()'>닫기</a>
</div>
</body>
</html>
