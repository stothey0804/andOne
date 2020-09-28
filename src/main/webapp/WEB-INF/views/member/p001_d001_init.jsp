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
	div.terms{
		height: 300px;
		overflow-y: auto;
	}
</style>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	function init(){
		// 전체체크박스
		var allCheck = document.getElementById("termOfAllCheck");
		// 전체체크박스 클릭시
		allCheck.addEventListener("click",function(){
			document.getElementById("termOfServiceCheck").checked = allCheck.checked;
			document.getElementById("termOfGeolocationCheck").checked = allCheck.checked;
		});
		
		// 회원가입 클릭시 약관동의 체크
		document.getElementById("joinCountinue").addEventListener("click",function(){
			let agreeOfService = document.getElementById("termOfServiceCheck").checked;
			let agreeOfGeolocation = document.getElementById("termOfGeolocationCheck").checked;
			if(!(agreeOfService&&agreeOfGeolocation)){
				alert("약관에 동의해주시기 바랍니다.");
			}else{
				// join.do로 보내기
				let frmTerm = document.frmTerm;
				frmTerm.action = "${contextPath}/member/join.do";
				frmTerm.method = "post";
				frmTerm.submit();
			}
		});
	}
	

</script>
</head>
<body onload="init()">
	<form name="frmTerm">
		<div class="form-group col-lg-8 col-sm-10 mx-auto mt-5">
		<!-- 서비스 이용약관 -->
			<p class="h4 mb-3">&분의일 서비스 이용약관
			</p>
			<div class="card">
			  <div class="card-body terms">
				<p>이용약관
				</p>
			  </div>
			</div>
    		<div class="form-check my-2">
			  <input class="form-check-input" type="checkbox" value="" name="termOfServiceCheck" id="termOfServiceCheck">
			  <label class="form-check-label" for="termOfServiceCheck">
			    이용약관에 동의합니다. (필수)
			  </label>
			</div>
		<!-- 위치기반서비스 이용약관 -->
			<p class="h4 mt-5 mb-3">위치기반서비스 이용약관</p>
			<div class="card">
			  <div class="card-body terms">
				위치기반서비스 이용약관
			  </div>
			</div>
    		<div class="form-check my-2">
			  <input class="form-check-input" type="checkbox" value="" name="termOfGeolocationCheck" id="termOfGeolocationCheck">
			  <label class="form-check-label" for="termOfGeolocationCheck">
			    이용약관에 동의합니다. (필수)
			  </label>
			</div>
			<div class="form-check my-2">
			  <input class="form-check-input" type="checkbox" value="" id="termOfAllCheck">
			  <label class="form-check-label" for="termOfAllCheck">
			   <strong>전체약관에 동의합니다.</strong>
			  </label>
			</div>
			<input type="hidden" name="agree" value="true">
			<input class="btn btn-primary btn-lg btn-block mt-4" type="button" id="joinCountinue" value="회원가입"></input>
		</div>
	</form>
</body>
</html>