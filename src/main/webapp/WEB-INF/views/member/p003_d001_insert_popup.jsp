<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<!-- font Awesome -->
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>

<style>
	#cke_r_content{
		width: 95%;
		margin: 0 auto;
	}
	
</style>
</head>
<body class="bg-light">
	<div class="container p-4">
		<p class="h3">
		<c:if test="${flag eq '014'}">소모임 </c:if>
		<c:if test="${flag eq '013'}">회원 </c:if>
		<c:if test="${flag eq '015'}">&분의일 </c:if>
			<c:if test="${empty content}">
			신고하기 작성
			</c:if>
			<c:if test="${not empty content}">
			신고내용 수정
			</c:if>
		</p>
		<hr class="my-3">
		<p class="h4 mb-3">처리기간에 대한 안내</p>
			<p>접수완료된 문의는 평일 09:00 ~ 18:00 사이에 처리가 진행되며, 문의건에 따라 처리기간이 상이할 수 있습니다.</p>
			<form action="${contextPath}/member/saveReport.do" method="post">
				<!-- 제목 -->
				<div class="mb-2 row">
				    <label for="inputSubject" class="col-lg-2 col-sm-12 col-form-label">제목</label>
				    <div class="col-lg-10 col-sm-12">
				      <input type="text" class="form-control" id="inputSubject" name="r_subject" required>
		    		</div>
		    	</div>
		    	<!-- 문의유형 -->
				<div class="mb-2 row">
				    <label for="selectType" class="col-lg-2 col-sm-12 col-form-label">문의유형</label>
			    	  <div class="form-group col-lg-10 col-sm-12">
					    <select class="form-control " id="selectType" name="r_type" required>
					      <option value="">선택</option>
					      <c:forEach var="list" items="${rTypeList}">
						      <option value="${list.gc_id}">${list.gc_name}</option>
					      </c:forEach>
					    </select>
					  </div>
		    	</div>
		    	<!-- 에디터 -->
				<div class="mb-2 row">
					<textarea class="form-control" id="r_content" name="r_content" rows="30">
					내용을 입력해주세요.
					</textarea>
					<script>CKEDITOR.replace('r_content',{filebrowserUploadUrl:'${contextPath}/editorFileUpload.do'});</script>				
				</div>
			 <input type="hidden" name="r_category" value="${flag}">
			 <input type="hidden" name="r_target" value="${r_target}">
			 <input type="hidden" name="m_id" value="${sessionScope.m_id}">
	         <button type="submit" class="btn btn-primary btn-block">저장하기</button>   
			</form>
  	</div>
</body>
</html>