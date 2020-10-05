<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 변경</title>
<style type="text/css">
	div.form-group{
		width: 650px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	.container{
		margin: 0 auto;
	}
	h1.logotype{
		font-size: 5rem;
	}

</style>
<!-- Custom Source CSS -->
 <link rel="stylesheet" href="${contextPath}/resources/css/font.css">
 <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
 <!-- bootstrap -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
<div class="container m-5">
	<form name="frmUpdatePwd" method="post">
			<h1 class="logotype">&분의일</h1>
			<h2>비밀번호 변경</h2>
			<div class="form-group col-sm-10 mt-5 p-0">
			<input type="hidden" name="m_id" value="${m_id}">
		    	<!-- 비밀번호  -->
				<div class="mb-2 row">
				    <label for="inputPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="password" class="form-control" id="inputPassword" name="m_pwd" >
		    		</div>
		    	</div>
		    	<!-- 비밀번호 확인 -->
				<div class="mb-2 row">
				    <label for="confirmPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호확인</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="password" class="form-control" id="confirmPassword" name="confirm_pwd" >
		    		</div>
		    	</div>
			<input type="button" class="btn btn-primary btn-lg mt-3" value="수정" id="sendForm"></input>
			</div>
		</form>
		<!-- 	// 자바스크립트 폼 양식 체크 영역 (중복 등 처리) -->
	<script>
		// 패스워드 확인 입력시
		$("#confirmPassword").keyup(function(){
			checkPwd();
		});
		// 패스워드 입력시
		$("#inputPassword").keyup(function(){
			checkPwd();
		});
		function checkPwd(){
			if($("#inputPassword").val()==$("#confirmPassword").val()){
				$("#confirmPassword").removeClass("is-invalid");
				$("#confirmPassword").addClass("is-valid");
			}else{
				$("#confirmPassword").removeClass("is-valid");
				$("#confirmPassword").addClass("is-invalid");
			}
		}
		// 수정 클릭 시 *
		$("#sendForm").click(function(){
			var pwd = $("#inputPassword").val();
			// input에 invalid 클래스가 존재할 때
			if(pwd==null || pwd==''){
				alert("비밀번호를 입력해주세요.");
			}else if($(".is-invalid").length!=0){
				alert("비밀번호가 일치하지 않습니다.");
			}else{
				//모든 조건 통과시 saveMember로 보내기
				var frmUpdatePwd = document.frmUpdatePwd;
				frmUpdatePwd.action = "${contextPath}/member/updatePwd.do";
				frmUpdatePwd.submit();
			}
		});
		
	</script>
</div>
</body>
</html>