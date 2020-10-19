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
</head>
<body>
<!--쿠키가 있을 경우 ${checked}에 checked 속성 부여  -->
	<c:if test="${not empty cookie.id_check}">
		<c:set value="checked" var="checked" />
	</c:if>
	 <div class="col-lg-6 col-sm-10 mx-auto mt-5 ">
  		<div class="form-group col-md-6">
    		<label for="inputId">아이디</label>
    		<input type="text" class="form-control" id="inputId" value="${cookie.id_check.value}" name="bm_id">
    		<!-- 쿠키에 저장되어 있는 value(아이디값)가져오기 -->
		</div>
  		<div class="form-group col-md-6">
    		<label for="inputPwd">비밀번호</label>
    		<input type="password" class="form-control" id="inputPwd" name="bm_pwd">
          </div>
        <div class="form-group col-md-6">
    		<span class="font-weight-bold text-black" id="sploginCheck"></span>
        </div>
  		<div class="form-group form-check">
    		<input type="checkbox" class="form-check-input" id="_saveId" name="saveId" ${checked}>
    		<label class="form-check-label" for="_saveId">아이디 저장하기</label>
    		<a href="${contextPath}/biz/findInfo.do">아이디 /비밀번호 찾기</a>
        </div>
        <div class="form-group form-check">
            <button type="button" id ="login" class="btn btn-primary col-md-6">로그인</button>
        </div>
        <div class="form-group form-check">
            <button onclick="location.href='${contextPath}/biz/join.do'" class="btn btn-primary col-md-6">회원가입</button>
        </div>
	</div>
</body>
</html>