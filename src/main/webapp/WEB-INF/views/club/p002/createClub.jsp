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
<script src="https://cdn.ckeditor.com/ckeditor5/22.0.0/classic/ckeditor.js"></script>
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
		<option value="10">아웃도어/여행</option>
		<option value="20">운동/스포츠</option>
		<option value="30">인문학/책/글</option>
		<option value="40">외국/언어</option>
		<option value="50">문화/공연</option>
		<option value="60">음악/악기</option>
		<option value="70">공예/만들기</option>
		<option value="80">사교/인맥</option>
		<option value="90">댄스/무용</option>
		<option value="100">봉사활동</option>
		<option value="110">기타</option>
	</select>
</div>
<div class="form-group">
    <label>해쉬태그</label>
    <input type="text" class="form-control" name="c_hashtag" placeholder="소모임과 관련된 해쉬태그를 사용해보세요!">
</div>

<div class="col form-group">
	소모임 인원 <input type="text" class="form-control memberMax" name="c_membermax" style="width:60px;">명
</div>
<?php
	$data = str_replace('&','&amp;',$data);
?>
<textarea name="c_content" id="c_content">
zz
</textarea>
<script>
ClassicEditor
	.create(document.querySelector('#c_content'))
	.catch(error=>{
		console.log(error);
	});
</script>
  <div class="form-group">
    <label>대표 이미지 첨부</label>
    <input type="file" class="form-control-file" accept="image/*" name="c_img">
  </div>
<input class="btn btn-primary btn-block" type="submit" value="소모임 만들기">
</form>
</body>
</html>