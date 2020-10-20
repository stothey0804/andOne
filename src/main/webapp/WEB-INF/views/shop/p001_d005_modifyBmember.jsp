<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
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
	.input-box {
	    width: 150px;
	    height: 150px; 
	    border-radius: 70%;
	    overflow: hidden;
	}
	.input-profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}

</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		
	});
</script>
</head>
<body>
<div class="container">
	<form name="frmMemberInfo" enctype="multipart/form-data" method="post">
			<h2 class="m-5">내 정보 변경</h2>
			<hr class="m-5">
			<div class="form-group col-sm-10 mx-auto mt-5 p-0">
			<p class="h4 mb-3">필수정보</p>
			<input type="hidden" name="bm_id" value="${bMember.bm_id}">
				<!-- 이메일 -->
				<div class="mb-2 row">
				    <label for="inputEmail" class="col-lg-3 col-sm-12 col-form-label">이메일</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="email" class="form-control" id="inputEmail" name="bm_email" value="${bMember.bm_email}">
		    		</div>
		    	</div>
		    	<!-- 비밀번호  -->
				<div class="mb-2 row">
				    <label for="inputPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="password" class="form-control" id="inputPassword" name="bm_pwd" >
		    		</div>
		    	</div>
		    	<!-- 비밀번호 확인 -->
				<div class="mb-2 row">
				    <label for="confirmPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호확인</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="password" class="form-control" id="confirmPassword" name="confirm_pwd" >
		    		</div>
		    	</div>
		    		    	<!-- 휴대폰번호 -->
				<div class="mb-2 row">
				    <label for="inputPhoneNumber" class="col-lg-3 col-12 col-form-label">휴대폰번호</label>
				    <div class="col-lg-7 col-7 col-sm-9">
				      <input type="tel" class="form-control" id="inputPhoneNumber" name="bm_phoneNumber"
				      value="${bMember.bm_phoneNumber}" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" >
				      <div class='invalid-feedback phone-feedback'>유효하지 않은 번호 입니다.</div>
	    			</div>
	    		</div>
			<input type="button" class="btn btn-primary btn-lg btn-block mt-4" value="수정" id="sendForm"></input>
			</div>
		</form>
		<!-- 	// 자바스크립트 폼 양식 체크 영역 (중복 등 처리) -->
	<script>
		// 이메일 폼을 벗어났을때 중복체크
		$("#inputEmail").blur(function(){
			var _email = $("#inputEmail").val();
			if(_email==("") || _email==null){
           		$(".email-feedback").text("이메일을 입력하세요.");
				$("#inputEmail").removeClass("is-valid");
				$("#inputEmail").addClass("is-invalid");
			}else{
				$.ajax({
	                type: "post",
	                async: "true",
	                dataType: "text",
	                data: {
	                    email: _email //data로 넘겨주기
	                },
	                url: "${contextPath}/biz/searchOverlapEmail.do",
	                success: function (data, textStatus) {
	                	if(data=="true"){	// 중복일경우
	                		$(".email-feedback").text("중복되는 이메일입니다.");
							$("#inputEmail").removeClass("is-valid");
							$("#inputEmail").addClass("is-invalid");
	                	}else{				// 중복아닐경우
							$("#inputEmail").removeClass("is-invalid");
							$("#inputEmail").addClass("is-valid");
	                	}
	                }
				});
			}
		});
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
		// 휴대폰번호 체크
		$("#inputPhoneNumber").keyup(function(){
			// 패턴체크
			var pattern = /^\(?([0-9]{3})\)?-?([0-9]{4})-([0-9]{4})$/;
			if($("#inputPhoneNumber").val().match(pattern)){	// 패턴이 맞을 경우
				$("#inputPhoneNumber").removeClass("is-invalid");
				$("#inputPhoneNumber").addClass("is-valid");
			}else{	
				$(".phone-feedback").text("유효하지 않은 번호입니다.");
				$("#inputPhoneNumber").removeClass("is-valid");
				$("#inputPhoneNumber").addClass("is-invalid");
			}
			// 중복 번호 확인
			if($("#inputPhoneNumber").hasClass("is-valid")){
				var _phone = $("#inputPhoneNumber").val();
				$.ajax({
	                type: "post",
	                async: "true",
	                dataType: "text",
	                data: {
	                    phone: _phone //data로 넘겨주기
	                },
	                url: "${contextPath}/biz/searchOverlapPhone.do",
	                success: function (data, textStatus) {
	                	if(data=="true"){	// 중복일경우
							$("#inputPhoneNumber").removeClass("is-valid");
							$("#inputPhoneNumber").addClass("is-invalid");
							$(".phone-feedback").text("중복되는 번호입니다.");
	                	}
	                }
				});
			}
		});
		
		// 수정 클릭 시 *
		$("#sendForm").click(function(){
			var email = $("#inputEmail").val();
			var pwd = $("#inputPassword").val();
			var phoneNum = $("#inputPhoneNumber").val();
			
			// 필수입력조건 체크(pwd제외)
			if(email=='' || email==null
					|| phoneNum=='' || phoneNum==null){
				alert("필수정보를 입력해주세요.");
			}
			// input에 invalid 클래스가 존재할 때
			else if($(".is-invalid").length!=0){
				alert("입력정보를 확인해주세요.");
			}else{
				//모든 조건 통과시 saveMember로 보내기
				var frmMemberInfo = document.frmMemberInfo;
				frmMemberInfo.action = "${contextPath}/biz/saveMember.do";
				frmMemberInfo.submit();
			}
		});
		
	</script>
</div>
</body>
</html>