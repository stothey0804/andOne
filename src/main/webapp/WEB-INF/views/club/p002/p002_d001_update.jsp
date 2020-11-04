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
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

h2 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 300%;
	text-align: center;
}

.btn-success:hover {
	background-color: #00033D !important;
}

.btn-success {
	background-color: #002A87 !important;
	border-color: #002A87;
	color: white;
}

#preview>img {
	margin-top: 8px;
	width: 300px;
	height: 300px;
	object-fit: cover;
}

#preTXT {
	margin-bottom: 0px;
	margin-top: 5px;
}

.btn-file {
	position: relative;
/*  	overflow: hidden;  */
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	min-height: 100%;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}
.fileDelete{
	margin-top:-8px;
}

</style>
<script>
function fileReset(){
	document.getElementById("c_img").value = "";
	var el = document.getElementById('preImg');
	if(el != null){
		el.remove();
	}
	var txt = document.getElementById('preTXT');
	txt.innerText = "선택된 이미지가 없습니다.";
}


var hashtag = "${clubInfo.c_hashtag}";
var hashtagArr = hashtag.split(',');
$(document).ready(function(){
	console.log(hashtag);
	$(function(){
		$('#c_hashtag').val(hashtag);
		for(let i=0; i<hashtagArr.length; i++){
		console.log("========"+hashtagArr[i]);
		$('.hashtagArea').append('<div class="btn-group mr-1 btn-group-sm" role="group">'
				+'<button class="btn btn-sm btn-light">#'+hashtagArr[i]+'</button>'
				+'<button id="'+hashtagArr[i]+'" class="btn btn-sm btn-light" onclick="deleteValue(this.id)">&times;</button>'+'</div>');
		}
		
	});
	
	$('#submitForm').click(function(){
		let c_name = document.getElementsByName('c_name')[0].value;
		let c_category = document.getElementsByName('c_category')[0].value;
		let c_membermax = document.getElementsByName('c_membermax')[0].value;
		if(c_name == "" || c_name == null ||
				c_category == "" || c_category == null ||
				c_membermax == "" || c_membermax == null){
			alert("필수 정보를 입력해주세요.");
			return;	
		} else {
			var clubInsert = document.clubInsert;
			clubInsert.action = "${contextPath}/club/updateClub.do?c_id=${clubInfo.c_id}";
			clubInsert.method = "post";
			clubInsert.submit();
		}
	});
	
	$("#onlyNumber").keyup(function(event){
		var inputVal = $(this).val();
		$(this).val(inputVal.replace(/[^0-9]/gi,''));
		if(inputVal > 50){
			alert('최대 50명까지 가능합니다.');
			$(this).val('');
		}
	});
})

// 해쉬태그
function characterCheck() {
	var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+┼<>@\#$%&\'\"\\\(\=]/gi;
	var space = / /gi;
	var obj = document.getElementsByName("c_hashtagInput")[0];
	if (RegExp.test(obj.value)) {
		alert("특수문자는 언더바(_)만 사용 가능합니다.");
		obj.value = obj.value.substring(0, obj.value.length - 1);
	} else if (space.test(obj.value)){
		add();
	}
	
}
	function add(){
		let inputValue = $('#c_hashtagInput').val();
		console.log(inputValue);
		console.log("lllllllll"+hashtagArr)
		if(isEmpty(inputValue)){
			alert('키워드를 입력해주세요.');
			$('#c_hashtagInput').val('');
		}else{
			inputValue = inputValue.slice(0,-1);
			console.log(inputValue);
			hashtagArr.push(inputValue);
			$('.hashtagArea').append('<div class="btn-group mr-1 btn-group-sm" role="group">'
					+'<button class="btn btn-light">#'+inputValue+'</button>'
					+'<button id="'+inputValue+'" class="btn btn-sm btn-light" onclick="deleteValue(this.id)">&times;</button>'+'</div>');
			$('#c_hashtagInput').val('');
			$('#c_hashtag').val(hashtagArr);
		}
	}
	
	function lookUp(){
		hashtagArr = '';
		for(let i=0; i<hashtagArr.length; i++){
			hashtagArr += hashtagArr[i] + ','
		}
		hashtagArr = hashtagArr.slice(0,-1);
		alert(hashtagArr);
	}

	function deleteValue(param){
		hashtagArr.splice(hashtagArr.indexOf(param),1);
		$('.btn-group').has('#'+param).remove();
		$('#c_hashtag').val(hashtagArr);
	}
	
	function isEmpty(str){
		if(typeof str == "undefined" || str == null || str == "" || str == " "){
			return true;
		}else{
			return false;
		}
	}
</script>
</head>
<body>
<form name="clubInsert" enctype="multipart/form-data" class="container my-5 center" style="width:600px">
<h2>소모임 수정하기</h2><br>
 <div class="form-group">
    <label>소모임 이름</label>&nbsp;<span class="text-muted m-0 text-muted"><small>(필수)</small></span>
    <input type="text" class="form-control" name="c_name" placeholder="소모임을 대표하는 이름을 입력해주세요!" value="${clubInfo.c_name}">
 </div>
 <div class="form-group">
	<label>카테고리</label>&nbsp;<span class="text-muted m-0 text-muted"><small>(필수)</small></span>
	<select class="form-control" name="c_category">
		<option value="">카테고리 선택</option>
		<c:forEach var="c" items="${category}">
			<c:if test="${c.gc_name eq clubInfo.c_category}">
				<option value="${c.gc_id}" selected>${c.gc_name}</option>
			</c:if>
			<c:if test="${c.gc_name ne clubInfo.c_category}">
				<option value="${c.gc_id}">${c.gc_name}</option>
			</c:if>
		</c:forEach>
	</select>
</div>

<div class="form-group">
    <label>해쉬태그</label>
    <div class="hashtagArea" style="margin-bottom:10px;"></div>
	<!-- 해쉬태그 입력폼 -->
    <input type="text" class="form-control" name="c_hashtagInput" id="c_hashtagInput" placeholder="소모임과 관련된 해쉬태그를 사용해보세요! 스페이스바로 등록됩니다."
    		onkeyup="characterCheck()" onkeydown="characterCheck()">
	<!--해쉬태그 보내는 input -->
    <input type="text" class="form-control" name="c_hashtag" id="c_hashtag">
</div>

<textarea name="c_content" id="c_content">${clubInfo.c_content}</textarea>
<script>CKEDITOR.replace('c_content')</script>
<label>가입인사시 짧은 소개글이나 가입 질문을 써주세요!</label>
<textarea class="form-control" name="c_ask" id="exampleFormControlTextarea1" rows="3">${clubInfo.c_ask}</textarea>

<div class="form-group mt-3">
	소모임 인원&nbsp;<span class="text-muted m-0 text-muted"><small>(필수)</small></span> 
	<input type="text" class="form-control memberMax" name="c_membermax" id="onlyNumber" style="width:60px;display:inline-block;" style="width:60px;" value="${clubInfo.c_membermax}">
	&nbsp;명
</div>

<label>대표 이미지 수정</label><br>
<label class="btn btn-outline-primary btn-file">이미지 선택
	<input type="file" class="form-control-file" accept="image/*" name="c_img" id="c_img">
</label>
	<input type="button" value=삭제 class="btn btn-outline-danger fileDelete" onclick="fileReset()">
<div id="preview" style="margin-bottom:10px;">
<c:set var="c_img" value="${clubImg}"/>
<c:if test="${c_img ne ''}">
 <p id="preTXT">대표 이미지 미리보기</p>
	<img id="preImg" src="data:image/jpg;base64, ${c_img}" class="c_img">
</c:if>
<c:if test="${c_img eq ''}">
 <p id="preTXT">대표 이미지가 없습니다.</p>
</c:if>
</div>
<input class="btn btn-primary btn-block" type="submit" value="소모임 수정하기" id="submitForm">
</form>
</body>
<script>
// 대표이미지 preview
var upload = document.querySelector('#c_img');
var preview = document.querySelector('#preview');

upload.addEventListener('change',function(e){
	var el = document.getElementById('preImg');
	var txt = document.getElementById('preTXT');
	txt.innerText = "대표 이미지 미리보기";
	if(el != null){
		el.remove();
	} 
	var get_file = e.target.files;
	var image = document.createElement('img');
	image.id='preImg';
// 	FileReader 객체 생성
	var reader = new FileReader();
// 	reader 시작시 함수 구현
	reader.onload = (function(aImg){
		return function(e){
			aImg.src = e.target.result
		}
	})(image)
	
	if(get_file){
		reader.readAsDataURL(get_file[0]);
	}
	preview.appendChild(image);
})
</script>
</html>