<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	div.form-group{
		width: 650px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
</style>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
	<form name="frmJoin" method="post">
		<div class="form-group mx-auto mt-5 p-0">
		<p class="h4 mb-3">필수정보</p>
			<!-- 이메일 -->
			<div class="mb-2 row">
			    <label for="inputEmail" class="col-lg-3 col-sm-12 col-form-label">이메일</label>
			    <div class="col-lg-7 col-sm-12">
			      <input type="email" class="form-control" id="inputEmail" placeholder="ex)id@gmail.com" name="email" value="${member.email}" required />
	    			<div class='invalid-feedback email-feedback'>중복되는 이메일입니다.</div>
	    		</div>
	    	</div>
	    	<!-- 비밀번호  -->
			<div class="mb-2 row">
			    <label for="inputPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호</label>
			    <div class="col-lg-7 col-12">
			      <input type="password" class="form-control" id="inputPassword" name="pwd" value="${member.pwd}" required />
	    		</div>
	    	</div>
	    	<!-- 비밀번호 확인 -->
			<div class="mb-2 row">
			    <label for="confirmPassword" class="col-lg-3 col-sm-12 col-form-label">비밀번호확인</label>
			    <div class="col-lg-7 col-12">
			      <input type="password" class="form-control" id="confirmPassword" name="confirm_pwd" value="${member.confirm_pwd}" required />
	    			<div class='invalid-feedback'>비밀번호가 일치하지 않습니다.</div>
	    		</div>
	    	</div>
	    	<!-- 휴대폰번호 -->
			<div class="mb-2 row">
			    <label for="inputPhoneNumber" class="col-lg-3 col-12 col-form-label">휴대폰번호</label>
			    <div class="col-lg-7 col-7 col-sm-9">
				      <input type="tel" class="form-control" id="inputPhoneNumber" name="phonenumber"
				      value="${member.phonenumber}" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required />
				      <div class='invalid-feedback phone-feedback'>유효하지 않은 번호 입니다.</div>
	    		</div>
		    	<input type="button" class="btn btn-primary col-lg-2 col-5 col-sm-3" id="sendSMS" value="인증번호발송"></input>
	    	</div>
			<div class="mb-2 row">
				<div class="col-lg-7 col-7 col-sm-9 ml-auto">
			      <input type="text" class="form-control" name="confirmSMS" placeholder="인증번호입력" id="inputConfirmSMS">
			      <div class='invalid-feedback'>인증번호가 일치하지 않습니다.</div>
			      <div class="valid-feedback">인증번호 확인완료</div>
	    		</div>
		    	<input type="button" class="btn btn-secondary col-lg-2 col-5 col-sm-3" id="confirmSMS" style="height:38px" value="인증번호확인"></input>
	    	</div>
		<!-- 필수정보 끝 -->
		<p class="h4 mb-3">선택정보</p>
		<!-- 성별 -->
			<div class="mb-2 row">
			    <label for="selectGender" class="col-lg-3 col-sm-12 col-form-label">성별</label>
			    <div class="col-lg-7 col-sm-12">
				    <div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="male" value="10">
					  <label class="form-check-label" for="male">남자</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="radio" name="gender" id="female" value="20">
					  <label class="form-check-label" for="female">여자</label>
					</div>
	    		</div>
	    	</div>
	    	<!-- 나이대 -->
			<div class="mb-2 row">
			    <label for="selectAge" class="col-lg-3 col-sm-12 col-form-label">나이대</label>
		    	  <div class="form-group col-lg-7 col-sm-12">
				    <select class="form-control " id="selectAge" name="age">
				      <option value="" selected>선택</option>
				      <option value="10">10대</option>
				      <option value="20">20대</option>
				      <option value="30">30대</option>
				      <option value="40">40대</option>
				      <option value="50">50대이상</option>
				    </select>
				  </div>
	    	</div>
<!-- 		<input type="submit" class="btn btn-primary btn-lg btn-block mt-4" value="가입완료" id="sendForm"></input> -->
		<input type="button" class="btn btn-primary btn-lg btn-block mt-4" value="가입완료" id="sendForm"></input>
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
	                url: "${contextPath}/member/searchOverlapEmail.do",
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
	                url: "${contextPath}/member/searchOverlapPhone.do",
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
		
		// 인증번호 저장 변수
		var authNum = 0;
		
		// SMS 전송 클릭시
		$("#sendSMS").click(function(){
			alert("인증번호가 발송되었습니다.");
			var _phone = $("#inputPhoneNumber").val();
			// ajax로 인증번호 받기
			$.ajax({
                type: "post",
                async: "true",
                dataType: "text",
                data: {
                    phone: _phone //data로 넘겨주기
                },
                url: "${contextPath}/member/confirmSMSCode.do",
                success: function (data, textStatus) {
                	authNum = data;	
                }
			});
			
		});
		
		// SMS 확인 클릭시, 인증번호 검증
		$("#confirmSMS").click(function(){
			let inputAuthNum = $("#inputConfirmSMS").val();
			if(authNum==0 || authNum==null){
				alert("인증번호발송을 누르세요.");
			}else if(authNum==inputAuthNum){
				$("#inputConfirmSMS").removeClass("is-invalid");
				$("#inputConfirmSMS").addClass("is-valid");
				$("#inputConfirmSMS").attr("readonly",true);
			}else{
				$("#inputConfirmSMS").removeClass("is-valid");
				$("#inputConfirmSMS").addClass("is-invalid");
			}
		});
		
		// 가입완료 클릭 시
		$("#sendForm").click(function(){
			var email = $("#inputEmail").val();
			var pwd = $("#inputPassword").val();
			var phoneNum = $("#inputPhoneNumber").val();
			var isConfirmSmS = $("#inputConfirmSMS").attr("readonly");
			// 필수입력조건 체크
			if(email=='' || email==null
					|| pwd=='' || pwd==null
					|| phoneNum=='' || phoneNum==null){
				alert("필수정보를 입력해주세요.");
			}
			// input에 invalid 클래스가 존재할 때
			else if($(".is-invalid").length!=0){
				alert("입력정보를 확인해주세요.");
			}else{
				//모든 조건 통과시 addMember로 보내기
				var frmJoin = document.frmJoin;
				frmJoin.action = "${contextPath}/member/addMember.do";
				frmJoin.submit();
			}
		});
		
	</script>
</body>
</html>