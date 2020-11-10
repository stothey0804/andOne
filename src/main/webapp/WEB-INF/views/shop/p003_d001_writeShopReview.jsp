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

#image_container img{
	max-width: 200px;
	margin-top: 50px;
}

</style>

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		$('#image').on("change",preview);
		$('#sr_score').change(function(){
			var star = printStar(this.value);
			$('#printStar').html(star);
		})
	})
	
	function printStar(score) {
		var calScore = score;
		var resultStar = '';
		while (true) {
			if (calScore >= 2) {
				resultStar += '<i class="fas fa-star text-warning"></i>';
				calScore -= 2;
				continue;
			} else if (calScore > 0) {
				resultStar += '<i class="fas fa-star-half-alt text-warning"></i>';
				break;
			} else {
				break;
			}
		}
		return resultStar;
	}
	
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

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container my-5 center">
		<h3>지역업체 리뷰 작성</h3><hr>
		<div class="form">
			<form action="/andOne/shop/insertShopReview.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="m_id" value="${vo.m_id }" />
				<input type="hidden" name="s_id" value="${vo.s_id }" />
				<div class="form-group">
					<label for="sr_content">리뷰내용</label>
					<textarea style="resize:none;" class="form-control" id="sr_content" rows="5" cols="50" name="sr_content"></textarea>
				</div>
				<div class="form-group">
					<label for="sr_score">가게점수</label>
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
					<span id="printStar"></span>
				</div>
				<div class="form-group">
					<label for="image">이미지 첨부</label><br>
					<input type="file" id="image" name="image" accept="image/*" multiple />
				</div>
				<div>
					<button type="submit" class="btn btn-primary">전송</button>
				</div>
			</form>
		</div>
		<hr>
		<h3>첨부파일 미리보기</h3>
		<div id="image_container">
		<h5>첨부된 파일이 없습니다.</h5>
		</div>
		</div>
</body>
</html>