<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>	
	<script>
		$(document).ready(function(){
			$("#login").click(function(){
				var _id = $("#inputId").val();
				var _pwd = $("#inputPwd").val();
				var _saveId = $("#_saveId").is(":checked");//체크여부 확인
				$.ajax({
					type:"post",
                    dataType:"text",
                    async:"true",
                    url:"${contextPath}/biz/login.do",
                    data: {
                        "bm_id" : _id,
                        "bm_pwd" : _pwd,
                        "saveId" : _saveId
                    },
                    success : function(data, textStatus){ 
                        if(data == 0){ //로그인 실패
                            console.log("로그인체크: " +data);
                            $("#sploginCheck").text("아이디와 비밀번호를 다시 확인하세요.");
                        }else{ //로그인 성공 -> 업체관리자페이지
                            console.log("로그인체크: " +data);
                            location.href = "${contextPath}/biz/loginOk.do"
                        }
                    }
				})
			})
		})
		
	</script>
<meta charset="UTF-8">
<title>업체회원 로그인</title>
<style type="text/css">
	.login-form{
		width: 300px;
    	position: absolute;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%, -50%);
	}
	h1.logotype{
		font-size: 4em;
	}
	.login-form input[type="text"]{
		margin-bottom: -1px;
		border-bottom-right-radius: 0;
		border-bottom-left-radius: 0;
	}
	.login-form input[type="password"]{
		border-top-right-radius: 0;
		border-top-left-radius: 0;
	}
</style>
</head>
<body class="text-center bg-light">
<!--쿠키가 있을 경우 ${checked}에 checked 속성 부여  -->
	<c:if test="${not empty cookie.id_check}">
		<c:set value="checked" var="checked" />
	</c:if>
		<div class="login-form m-auto">
			<h1 class="logotype text-dark">&분의일</h1>
			<p class="h5 mb-4 font-weight-normal">지역업체회원 관리자페이지</p>
			<label for="inputId" class="sr-only">아이디</label>
    		<input type="text" class="form-control" placeholder="아이디" id="inputId" value="${cookie.id_check.value}" name="bm_id">
    		<!-- 쿠키에 저장되어 있는 value(아이디값)가져오기 -->
    		<label for="inputPwd" class="sr-only">비밀번호</label>
    		<input type="password" class="form-control" placeholder="비밀번호" id="inputPwd" name="bm_pwd">
    		<div class="form-group col-md-6">
    			<span class="font-weight-bold text-black" id="sploginCheck"></span>
	        </div>
	  		<div class="form-group form-check">
	    		<input type="checkbox" class="form-check-input" id="_saveId" name="saveId" ${checked}>
	    		<label class="form-check-label" for="_saveId">아이디 저장하기</label>
	        </div>
	        <button class="btn btn-lg btn-dark btn-block mt-2" id="login">로그인</button>
		    <p class="m-3"><a class="text-muted" href="${contextPath}/biz/findInfo.do">아이디 /비밀번호 찾기</a></p>
		    <button class="btn btn-lg btn-outline-dark btn-block" onclick="location.href='${contextPath}/biz/join.do'">회원가입</button>
		    <p class="mt-5 mb-3 text-muted">© 2020 능력있는사람들</p>
	</div>
	
</body>
</html>