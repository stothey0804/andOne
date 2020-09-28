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
</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		var gender = ${member.m_gender};
		var age = ${member.m_age};
		// gender 정보 존재시 체크
		if(gender!=null || gender!=''){
			if(gender==10){
				$("#male").attr('checked',true);
			}else if(gender==20){
				$("#female").attr('checked',true);
			}
		}
		// age 정보 존재시 체크
		if(age!=null || age!=''){
			$("#age"+age).attr('selected',true);
		}
		
		loadProfileImage();
		
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
			<input type="hidden" name="m_id" value="${member.m_id}">
				<!-- 이메일 -->
				<div class="mb-2 row">
				    <label for="inputEmail" class="col-lg-3 col-sm-12 col-form-label">이메일</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="email" class="form-control" id="inputEmail" name="m_email" value="${member.m_email}">
		    		</div>
		    	</div>
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
		    		    	<!-- 휴대폰번호 -->
			<div class="mb-2 row">
			    <label for="inputPhoneNumber" class="col-lg-3 col-12 col-form-label">휴대폰번호</label>
			    <div class="col-lg-7 col-7 col-sm-9">
				      <input type="tel" class="form-control" id="inputPhoneNumber" name="m_phonenumber"
				      value="${member.m_phonenumber}" placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" >
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
			<hr>
			<p class="h4 mb-3">선택정보</p>
			<!-- 성별 -->
				<div class="mb-2 row">
				    <label for="selectGender" class="col-lg-3 col-sm-12 col-form-label">성별</label>
				    <div class="col-lg-7 col-sm-12">
					    <div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="m_gender" id="male" value="10">
						  <label class="form-check-label" for="male">남자</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="radio" name="m_gender" id="female" value="20">
						  <label class="form-check-label" for="female">여자</label>
						</div>
		    		</div>
		    	</div>
		    	<!-- 나이대 -->
				<div class="mb-2 row">
				    <label for="selectAge" class="col-lg-3 col-sm-12 col-form-label">나이대</label>
			    	  <div class="form-group col-lg-7 col-sm-12">
					    <select class="form-control " id="selectAge" name="m_age">
					      <option value="">선택</option>
					      <option id="age10" value="10">10대</option>
					      <option id="age20" value="20">20대</option>
					      <option id="age30" value="30">30대</option>
					      <option id="age40" value="40">40대</option>
					      <option id="age50" value="50">50대이상</option>
					    </select>
					  </div>
		    	</div>
				<!-- 닉네임 -->
				<div class="mb-2 row">
				    <label for="inputEmail" class="col-lg-3 col-sm-12 col-form-label">닉네임</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="text" class="form-control" id="inputEmail" name="m_nickname" value="${member.m_nickname}">
		    		</div>
		    	</div>
		    	<div class="mb-2 row">
		    		<label for="profileImage" class="col-lg-3 col-sm-12 col-form-label">프로필이미지</label>
		    		<div class="form-group col-lg-7 col-sm-12">
   		          		<div class="input-box" style="background: #BDBDBD;">
<%--    		          		  <img alt="" src="data:image/jpg;base64, ${data}" /> --%>
<%--     						<img class="profile" src="${contextPath}/member/getByteImage"> --%>
    						<img class="input-profile">
						</div>
		    			<input class="form-control" id="inputFile" type="file" name="m_img" value="${member.m_img}">
		    			<input class="btn btn-secondary mt-2" type="button" value="삭제">
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
		
		function loadProfileImage(){
			// 프로필이미지
			$.ajax({
	            type: "post",
	            async: "true",
	            dataType: "text",
	            data: {
	                id: '${member.m_id}' //data로 넘겨주기
	            },
	            url: "${contextPath}/member/getByteImage",
	            success: function (data, textStatus) {
	            	if(data==null || data==""){	
	            		$(".input-profile").attr("src","${contextPath}/resources/image/user.png")
	            	}else{	// null이 아닐경우
	            		$(".input-profile").attr("src","data:image/png;base64, "+data);
	            	}
	            }
			});
		}
		
		// 수정 클릭 시 *
		$("#sendForm").click(function(){
			var email = $("#inputEmail").val();
			var pwd = $("#inputPassword").val();
			var phoneNum = $("#inputPhoneNumber").val();
			
			// 전화번호가 member객체가 가지고 있는 값과 일치하지 않을경우
			if(phoneNum != '${member.m_phonenumber}'){
				var isConfirmSmS = $("#inputConfirmSMS").attr("readonly");
				if(!isConfirmSmS){
					alert("휴대폰인증을 완료해주세요.");
					return;
				}
			}

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
				frmMemberInfo.action = "${contextPath}/member/saveMember.do";
				frmMemberInfo.submit();
			}
		});
		
	</script>
</div>
</body>
</html>