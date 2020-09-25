<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>

<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#sendBtn").click(function() {
            sendMessage();
        });
    });

    var sock;
    //웸소켓을 지정한 url로 연결한다.
    sock = new SockJS("<c:url value="/echo"/>");

    //자바스크립트 안에 function을 집어넣을 수 있음.
    //데이터가 나한테 전달되읐을 때 자동으로 실행되는 function
    sock.onmessage = onMessage;

    //데이터를 끊고싶을때 실행하는 메소드
    sock.onclose = onClose;
    /* sock.onopen = function(){

        sock.send($("#message").val());

    }; */

    function sendMessage() {
        /*소켓으로 보내겠다.  */
        sock.send($("#message").val());
    }

    //evt 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
    function onMessage(evt) {
        var data = evt.data;

        $("#data").append(data + "<br/>");
        //sock.close();
    }

    function onClose(evt) {
        $("#data").append("연결 끊김");
    }

</script>
</head>

<body>
	<input type="text" id="message" />
	<input type="button" id="sendBtn" value="전송" />
	<div id="data"></div>
</body>
</html>
