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
	#cke_n_content{
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
		// 에디터 set
		let n_contentVal = '${article.n_content}';
		CKEDITOR.replace('n_content',{filebrowserUploadUrl:'${contextPath}/editorFileUpload.do'});
		CKEDITOR.instances["n_content"].setData(n_contentVal);
		
		// 수정
		$("#updateNotice").click(function(){
			let frmQnA = document.frmQnA;
			frmQnA.action = "${contextPath}/admin/updateNotice.do";
			frmQnA.submit();
		});
		
		// 작성
		$("#insertNotice").click(function(){
			let frmQnA = document.frmQnA;
			frmQnA.action = "${contextPath}/admin/insertNotice.do";
			frmQnA.submit();
		});
		
	});
</script>
</head>
<body>
<div class="container">
	<form enctype="multipart/form-data" method="post" name="frmQnA">
			<h2 class="m-5">
				<c:if test="${flag eq 1}">공지사항 수정</c:if>
				<c:if test="${flag eq 0}">공지사항 작성</c:if>
			</h2>
			<hr class="m-5">
			<div class="form-group col-sm-10 mx-auto mt-5 p-0">
				<!-- 제목 -->
				<div class="mb-2 row">
				    <label for="inputSubject" class="col-lg-2 col-sm-12 col-form-label">제목</label>
				    <div class="col-lg-10 col-sm-12">
				      <input type="text" class="form-control" id="inputSubject" name="n_title" value="${article.n_title}" required>
		    		</div>
		    	</div>
		    	<!-- 에디터 -->
				<div class="mb-2 row">
					<textarea class="form-control" id="n_content" name="n_content" rows="30" required>
					</textarea>
				</div>
				<c:if test="${flag eq 1}">
					<input type="hidden" name="n_id" value="${article.n_id}" />
					<input type="button" class="btn btn-primary btn-lg btn-block mt-4" value="수정" id="updateNotice"></input>
				</c:if>
				<c:if test="${flag eq 0}">
					<input type="button" class="btn btn-primary btn-lg btn-block mt-4" value="작성" id="insertNotice"></input>
				</c:if>
			</div>
		</form>
	</div>
</body>