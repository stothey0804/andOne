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
	#cke_q_content{
		width: 95%;
		margin: 0 auto;
	}

</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>

<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		
	});
</script>
</head>
<body>
<div class="container">
	<form action="${contextPath}/member/sendReport.do" enctype="multipart/form-data" method="post">
			<h2 class="m-5">신고하기</h2>
			<hr class="m-5">
			<div class="form-group col-sm-10 mx-auto mt-5 p-0">
			<p class="h4 mb-3">처리기간에 대한 안내</p>
			<p>접수완료된 문의는 평일 09:00 ~ 18:00 사이에 처리가 진행되며, 문의건에 따라 처리기간이 상이할 수 있습니다.</p>
				<!-- 제목 -->
				<div class="mb-2 row">
				    <label for="inputSubject" class="col-lg-2 col-sm-12 col-form-label">제목</label>
				    <div class="col-lg-10 col-sm-12">
				      <input type="text" class="form-control" id="inputSubject" name="q_subject" required>
		    		</div>
		    	</div>
		    	<input type="hidden" name="m_id" value="${m_id}">
		    	<!-- 문의유형 -->
				<div class="mb-2 row">
				    <label for="selectType" class="col-lg-2 col-sm-12 col-form-label">문의유형</label>
			    	  <div class="form-group col-lg-10 col-sm-12">
					    <select class="form-control " id="selectType" name="q_type" required>
					      <option value="">선택</option>
					      <c:forEach var="list" items="${qTypeList}">
						      <option value="${list.gc_id}">${list.gc_name}</option>
					      </c:forEach>
					    </select>
					  </div>
		    	</div>
		    	<!-- 에디터 -->
				<div class="mb-2 row">
					<textarea class="form-control" id="q_content" name="q_content" rows="30">
					문의내용:
					발생일시:
					</textarea>
					<script>CKEDITOR.replace('q_content',{filebrowserUploadUrl:'${contextPath}/editorFileUpload.do'});</script>				
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
			<input type="submit" class="btn btn-primary btn-lg btn-block mt-4" value="작성" id="sendForm"></input>
			</div>
		</form>
	</div>
</body>