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
		width: 300px;
		margin: 0 auto;
		margin-top: 100px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	
</style>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	var path = '${contextPath}' + '${path }';
	function init(){
		// 비밀번호 확인 클릭시
		$("#submitPwd").click(function(){
			let _inputPwd = $("#InputPassword").val();
			$.ajax({
		         type: "post",
		         async: "true",
		         dataType: "text",
		         data: "bm_id=${bm_id }&bm_pwd="+_inputPwd,
		         url: "${contextPath}/biz/pwdCheck.do",
		         success: function (data, textStatus) {
		         	if(data=="true"){	// 비번이 옳을 경우 
		         		let frmCheckPwd = document.frmCheckPwd;
		         		frmCheckPwd.action = path;
		         		frmCheckPwd.submit();
		         	}else{
	        			alert("비밀번호를 확인해주세요.");
		         	}
		         }
			});
		});
	}
</script>
</head>
<body onload="init()">
	<div class="container">
		<h2 class="m-5">비밀번호 확인</h2>
		<hr class="m-5">
		<form name="frmCheckPwd" method="post">
			  <div class="form-group">
			    <label for="InputPassword">비밀번호 확인</label>
			    <input type="hidden" name="bm_id" value="${bm_id }">
			    <input type="password" class="form-control" id="InputPassword" name="inputPwd">
				<button id="submitPwd" type="button" class="btn btn-primary mt-2">확인</button>
			  </div>
		</form>
	</div>
</body>
</html>