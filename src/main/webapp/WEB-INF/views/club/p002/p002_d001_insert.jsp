<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
h2{
	font-family: 'YanoljaYacheR' !important;
	font-size: 300%;
	text-align:center;
}
.btn-success:hover {
    background-color: #00033D !important;
}
.btn-success{
	background-color:#002A87 !important;
	border-color:#002A87;
	color:white;
}
</style>
<script>
	
</script>
</head>
<body>
<form action="${contextPath}/createClub.do" enctype="multipart/form-data" class="container my-5 center" method="post" style="width:600px">
<h2>소모임 만들기</h2><br>
 <div class="form-group">
    <label>소모임 이름</label>
    <input type="text" class="form-control" name="c_name" placeholder="소모임을 대표하는 이름을 입력해주세요!">
 </div>
 <div class="form-group">
	<label>카테고리</label>
	<select class="form-control" name="c_category">
		<option value="">카테고리 선택</option>
		<c:forEach var="c" items="${category}">
			<option value="${c.gc_id}">${c.gc_name}</option>
		</c:forEach>
	</select>
</div>
<div class="form-group">
    <label>해쉬태그</label>
    <input type="text" class="form-control" name="c_hashtag" placeholder="소모임과 관련된 해쉬태그를 사용해보세요!">
</div>

<div class="col form-group">
	소모임 인원 <input type="text" class="form-control memberMax" name="c_membermax" style="width:60px;">명
</div>
<textarea name="c_content" id="c_content"></textarea>
<script>CKEDITOR.replace('c_content')</script>
  <div class="form-group">
    <label>대표 이미지 첨부</label>
    <input type="file" class="form-control-file" accept="image/*" name="c_img">
  </div>
<input class="btn btn-primary btn-block" type="submit" value="소모임 만들기">
</form>
</body>
</html>