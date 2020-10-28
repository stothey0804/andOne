<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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

.left {
	float: left;
	cursor: pointer;
}

.info {
	margin-right: 15px;
}

input[type="submit"] {
	margin: 0 auto;
}

.c_img {
	height: 100%;
	width: 100%;
	object-fit: cover;
}

.btn-success:hover {
	background-color: #00033D !important;
}

.btn-success {
	background-color: #002A87 !important;
	border-color: #002A87;
	color: white;
}

.fileDelete {
	margin-top: -8px;
}

.zz>img {
	object-fit: contain;
	width: 100%;
}

.zz {
	width: 270px;
}

.none {
	display: none;
}
</style>
<script>
//삭제할 사진 index 배열
var click = new Array();
//저장할 사진 index 배열
var remain = new Array();

function deleteArticlePreImg(index){
	$('.file'+index).remove();
	click.push(index);
}

function fileReset() {
	document.getElementById('ca_img').value = "";
	$('.pre').empty();
	index = 0;
}

$(document).ready(function() {
	$('#ca_img').on("change", preview);
})

function sort(){
	click.sort(function(a, b) {
		return a - b;
	});
	for(let i=0;i<index;i++){
		remain.push(i);
	}
	for(let i=0;i<click.length;i++){
		const idx = click[i];
		for(let j=0;j<remain.length;j++){
			//삭제할 사진 index와 같을 경우 remain 배열에 null값 넣음
			if(idx == remain.indexOf(j)) remain[j] = null;
		}
	}
	console.log(remain);
	const dt = new DataTransfer();
	const input = document.getElementById('ca_img');
	const {files} = input;
	for(let i=0;i<files.length;i++){
		const file = files[i];
		//삭제할 사진 뺀 remain 배열 index만 input.file로 보냄
		if(remain[i] == i) dt.items.add(file);
		input.files = dt.files;
	}
}
	

var sel_files = [];
var index = 0;

function preview(e) {
	click = [];
	remain = [];
	index = 0;
	sel_files = [];
	$('.swiper-wrapper').empty();
	$('.swiper-container').removeClass('none');

	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

filesArr.forEach(function(f) {
	if (!f.type.match("image.*")) {
		alert('잘못된 파일 형식');
		return;
	}

	sel_files.push(f);

	var reader = new FileReader();
	reader.onload = function(e){
		if(index > 50){
			sel_files = [];
			$('.swiper-container').empty();
			$('.swiper-container').html("<h4>사진은 최대 50장까지 첨부 가능합니다</h4>");
			$('#ca_img').val("");
			return;
		}else{
			var output = "<div class='zz file"+index+"'><div style='position:absolute'><button type='button' class='btn btn-outline-danger' style='cursor:hand;float:right' onclick='deleteArticlePreImg("+index+")'>X</button></div><img src='"+e.target.result+"'/></div>";
			$('.swiper-wrapper').append(output);
			index++;
		}
	}
	reader.readAsDataURL(f);
	})
}
</script>
<body>
<div class="container my-5 center">
		<div class="left">
			<div class="card info" style="width: 18rem;" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${clubInfo.c_id}'">
			<c:set var="c_img" value="${clubImg}"/>
			<c:choose>
			<c:when test="${c_img eq ''}">
					<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img-top" alt="...">
				</c:when>
				<c:otherwise>
					<img src="data:image/jpg;base64, ${c_img}" class="c_img">
				</c:otherwise>
			</c:choose>
				<div class="card-body">
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
				</div>
			</div>
		</div>
</div>
<div class="container my-5 center">
<form action="${contextPath}/club/writeArticle.do" method="post" enctype="multipart/form-data">
	<textarea class="form-control col-sm-5" rows="13" name="ca_content">${articleInfo.ca_content }</textarea><br>
	<script>CKEDITOR.replace('ca_content')</script>
	<div class="btn" id="a"style="width:462px;">
	
	<div id="label">이미지 첨부<br>
    <label class="btn btn-outline-primary btn-file" id="label">이미지 선택
    	<input type="file" class="form-control-file" accept="image/*" name="ca_img" id="ca_img" multiple style="display:none;">
    </label>
    	<input type="button" value=삭제 class="btn btn-outline-danger fileDelete" onclick="fileReset()">
    </div>
	<br>
	<br>
<div class="swiper-container none">
	<p>첨부파일 미리보기</p>
    <div class="swiper-wrapper">
    </div>
</div>
	<input type="hidden" name="c_id" value="${clubInfo.c_id}">
	<input type="hidden" name="m_id" value="${member.m_id}">
	<input type="submit" class="btn btn-success btn-block" onclick="sort();" value="글쓰기"></div>
</form>
</div>
</body>
</html>