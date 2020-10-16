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
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

i.fa-chevron-left{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-chevron-right{
	color:rgb(237, 237, 237);
	font-size:500%;
}

i.fa-star-half-alt{
	color:rgb(255,234,0);
}

i.fa-star{
	color:rgb(255,234,0);
}

h3 {
	font-family: 'YanoljaYacheR' !important;
	font-size: 200%;
}

input[type="submit"] {
	font-family: FontAwesome;
}

button#search {
	font-family: FontAwesome;
}

div.search {
	text-align: center;
}

.card {
	
}

img.noResult{
	display:block; margin:0px auto;
}

a {
	text-decoration: none;
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:active {
	color: black;
}

a:hover {
	color: black;
}

#pop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 20%;
	left: 25%;
	width: 480px;
	height: auto;
	z-index: 10;
}

#imgPop {
	background:#e6e6e6;
	border:1px solid #000;
	position: fixed;
	top: 15%;
	left: 25%;
	width: auto;
	height: auto;
	z-index: 10;
}

#imgPop #close{
	top:10px;
	right: 10px;
	position: absolute;
	z-index:9999;
}

#imgPop #prev{
  	top: 50%;
	left: 10px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

#imgPop #next{
	top: 50%;
	right: -40px;
	position: absolute;
	z-index:9999;
	margin: 0;
  	transform: translate(-50%, -50%)
}

img.preview{
	max-height: 50px;
	max-width: 50px;
}

#image_container img{
	max-width: 200px;
	margin-top: 50px;
}

</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		getShopReview();
		$('#image').on("change",preview);
	})
	
	var sel_files = [];
	
	function preview(e){
		sel_files = [];
		$('#image_container').empty();
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		filesArr.forEach(function(f){
			
			if(!f.type.match("image.*")){
				alert('잘못된 파일 형식');
				return;
			}
			
			sel_files.push(f);
			
			var reader = new FileReader();
			reader.onload = function(e){
				if(index > 2){
					sel_files = [];
					$('#image_container').empty();
					$('#image_container').html("<h4>사진은 최대 3장까지 첨부 가능합니다</h4>");
					$('#image').val("");
					return;
				}else{
					var output = "<img src='"+e.target.result+"' />";
					$('#image_container').append(output);
					index++;
				}
			}
			reader.readAsDataURL(f);
		})
	}
	function deleteButton(){
		alert('이미지 삭제할거임');
		$.ajax({
			type: "post",
			async: true,
			url: 'http://localhost:8090/andOne/shop/deleteShopReviewImage.do',
			dataType: "text",
			beforeSend:function(data, textStatus){
				
			},
			data:"s_id=${vo.s_id}&m_id=${vo.m_id}",
			success: function (data, textStatus) {
				$('#regImageContainer').html("<h3>첨부된 이미지가 없습니다</h3>");
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		});
	}
	
	function getShopReview(){
		$.ajax({
			type: "post",
			async: true,
			url: 'http://localhost:8090/andOne/shop/shopReviewPopup.do',
			dataType: "text",
			beforeSend:function(data, textStatus){
				
			},
			data:"s_id=${vo.s_id}&m_id=${vo.m_id}",
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				$('#s_id').val(jsonInfo.s_id);
				$('#m_id').val(jsonInfo.m_id);
				$('#sr_content').val(jsonInfo.sr_content);
				$('#sr_score').val(jsonInfo.sr_score);
				var imageCount = Object.keys(jsonInfo.shopReviewImage).length;
				if(imageCount==0){
					$('#regImageContainer').html("<h5>등록된 이미지가 없습니다</h5>");
				}else{
					for(let i=0; i<imageCount; i++){
						$('#regImageContainer').append("<img class='preview' id="+i+" src='data:image/jpg;base64,"+jsonInfo.shopReviewImage[i].ri_encodedImg+"'>");
					}
					$('#regImageContainer').append('<button id="all" type="button" class="btn btn-outline-info" onclick="deleteButton()">첨부파일 삭제</button>');
				}
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
			}
		});
	}
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	리뷰 수정 페이지
	<div class="container">
		<form action="/andOne/shop/updateShopReview.do" method="post" enctype="multipart/form-data">
			<div>
				<input type="text" id="s_id" name="s_id" readonly="readonly"/>
			</div>
			<div>
				<input type="text" id="m_id" name="m_id" readonly="readonly"/>
			</div>
			<div>
				<textarea style="resize:none;" id="sr_content" name="sr_content" rows="5" cols="50">
				
				</textarea>
			</div>
			<div>
				<select name="sr_score" id="sr_score">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</div>
			<div>
				<input type="file" id="image" name="image" accept="image/*" multiple />
			</div>
			<div>
				<input type="submit" value="전송" />
			</div>
		</form>
		<hr>
		<h3>등록된 이미지</h3>
		<div id="regImageContainer">
			<img class="preview" id="1st"/>
			<img class="preview" id="2nd"/>
			<img class="preview" id="3rd"/>
		</div>
		<hr>
		<h3>첨부파일 미리보기</h3>
		<div id="image_container">
		<h5>첨부된 파일이 없습니다.</h5>
		</div>
	</div>
</body>
</html>