<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 체크</title>
<style>
	div.form-group{
		width: 450px;
		margin: 0 auto;
		margin-top: 100px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 버튼 클릭시 이메일 존재여부 체크
		$("button").click(function(){
			let _email = $("#InputEmail").val();
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
                		let sendEmail = document.sendEmail;
                		sendEmail.action = "${contextPath}/member/searchMemberPwdComplete.do";
                		sendEmail.submit();
                	}else{				// 중복아닐경우
                		alert("존재하지 않는 이메일입니다.");
                	}
                }
			});
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h2 class="m-5">비밀번호 찾기</h2>
		<hr class="m-5">
		<form name="sendEmail" method="post">
			  <div class="form-group">
			    <p class="text-center mb-1">가입시 등록하신 이메일 주소를 입력해주세요.</p>
			    <p class="text-center mb-5">입력한 이메일로 비밀번호 변경가능한 링크를 보내드립니다.</p>
			    <input type="email" class="form-control mb-2" id="InputEmail" name="m_email">
				<button type="button" class="btn btn-primary btn-lg btn-block mb-5">확인</button>
			  </div>
		</form>
	</div>
</body>
</html>