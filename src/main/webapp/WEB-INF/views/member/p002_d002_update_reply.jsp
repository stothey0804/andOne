<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	div.form-group{
		width: 750px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	.container{
		margin: 0 auto;
	}
	#cke_q_reply{
		width: 95%;
		margin: 0 auto;
	}

</style>

<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>

<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		
	});
</script>
</head>
<body>
<div class="container">
	<form action="${contextPath}/admin/sendReplyQnA.do" enctype="multipart/form-data" method="post">
			<h2 class="m-5">답변작성/수정</h2>
			<hr class="m-5">
			<div class="form-group col-sm-10 mx-auto mt-5 p-0">
		    	<!-- 에디터 -->
				<div class="mb-2 row">
					<textarea class="form-control" id="q_reply" name="q_reply" rows="30">
					${q_reply}
					</textarea>
					<script>CKEDITOR.replace('q_reply',{filebrowserUploadUrl:'${contextPath}/editorFileUpload.do'});</script>				
				</div>
		    	
<!-- 		    	<div class="mb-2 row"> -->
<!-- 		    		<div class="form-group col-lg-7 col-sm-12"> -->
<!-- 					</div> -->
<!-- 						<div class="filebox"> -->
<!-- 							<label for="inputFile" class="btn btn-primary my-0">업로드</label> -->
<!-- 		    				<input class="btn btn-danger" id="deleteFile"type="button" value="삭제"> -->
<!-- 		    				<input class="form-control" id="inputFile" type="file" name="m_img"> -->
<!-- 							<input class="upload-name form-control-plaintext" value="" readonly> -->
<!-- 						</div> -->
<!-- 		    		</div> -->
<!-- 		    	</div> -->
			<input type="hidden" name="q_id" value="${q_id}" />
			<input type="submit" class="btn btn-primary btn-lg btn-block mt-4" value="저장" id="sendForm"></input>
			</div>
		</form>
	</div>
</body>