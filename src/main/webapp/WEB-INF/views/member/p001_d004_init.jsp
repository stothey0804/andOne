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
		width: 600px;
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
function init(){
	// 비밀번호 확인 클릭시
	$("#submitPwd").click(function(){
		let _inputPwd = $("#InputPassword").val();
		$.ajax({
	         type: "post",
	         async: "true",
	         dataType: "text",
	         data: { //data로 넘겨주기
	             m_id: '${member.m_id}',
	             inputPwd: _inputPwd
	         },
	         url: "${contextPath}/member/checkUserPwd.do",
	         success: function (data, textStatus) {
	         	if(data=="true"){	// 비번이 옳을 경우 
	         		let frmCheckPwd = document.frmCheckPwd;
	         		frmCheckPwd.action = "${contextPath}/member/deleteMemberComplete.do";
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
		<h2 class="m-5">회원탈퇴</h2>
		<hr class="m-5">
			  <div class="form-group">
			    <p class="mb-3">정말 탈퇴하시겠습니까?
			    <br>혹시 불편한 점이 있으시면 1:1 문의를 통해 건의해주시면 빠르게 도와드리겠습니다.
			    </p>
			    <p class="mb-1 h5">
			    탈퇴시 개인정보 파기 기간에 대한 안내
			    </p>
			    <p class="mb-3">
			    약관정보
			    </p>
			    <p class="mb-1 h5">
			    포인트 관련 안내
			    </p>
			    <p class="mb-3">
			    약관정보
			    </p>
			    <p class="mb-5">
			    그래도 탈퇴하시겠습니까?
			    </p>
			    <!-- modal trigger -->
				<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirmPwd">
				회원탈퇴
				</button>
			  </div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="confirmPwd" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
        <form name="frmCheckPwd" method="post">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">비밀번호 확인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        탈퇴를 진행하려면 비밀번호를 입력해주세요.
			    <input type="password" class="form-control my-3" id="InputPassword" placeholder="비밀번호">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <input type="hidden" name="m_id" value='${member.m_id}' />
	        <button id="submitPwd" type="button" class="btn btn-primary">확인</button>
	      </div>
        </form>
	    </div>
	  </div>
	</div>
</body>
</html>