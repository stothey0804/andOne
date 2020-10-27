<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	div.form-group{
		width: 650px;
	}
	@media screen and (max-width: 750px){
		div.form-group{
			width: 90%;
		}
	}
	.container{
		margin: 0 auto;
	}
	.input-box {
	    width: 150px;
	    height: 150px; 
	    border-radius: 70%;
	    overflow: hidden;
	}
	.input-profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	
	img.preview{
		max-height: 100px;
		max-width: 100px;
	}
	
	#image_container img{
		max-width: 200px;
		margin-top: 10px;
		margin-bottom: 20px;
	}
	
	div#loadingImg{
		position:absolute;
		left:45%;
		top:50%;
		z-index:120;
	}
	
	#mask {  
		position:absolute;  
		left:0;
		top:0;
		z-index:100;  
		background-color:#000;  
		display:none;  
	}

</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		$('#loadingImg').hide();
		$('#inputShopImage').on("change",preview);
		getShop();
	})
	
	var sel_files = [];
	var hashtag = '';
	var hashtagArr = new Array();
	
	function getShop(){
		$.ajax({
			type: "post",
			async: true,
			url: 'http://localhost:8090/andOne/biz/getShopByAjax.do',
			dataType: "text",
			beforeSend:function(data, textStatus){
				$('#loadingImg').show();
				wrapWindowByMask();
			},
			data:"s_id=${s_id }",
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				$('#inputShopId').val(jsonInfo.s_id);
				$('#bm_id').val(jsonInfo.bm_id);
				$('#s_locate').val(jsonInfo.s_locate);
				$('#s_score').val(jsonInfo.s_score);
				$('#inputCategory').val(jsonInfo.s_category);
				$('#inputShopName').val(jsonInfo.s_name);
				$('#inputShopContent').val(jsonInfo.s_content);
				$('#inputPhoneNumber').val(jsonInfo.s_phoneNumber);
				hashtag = jsonInfo.s_hashtag;
				hashtagArr = hashtag.split(',');
				for(let i=0; i<hashtagArr.length; i++){
					console.log(hashtagArr[i]);
					$('.displayArea').append('<div class="btn-group mr-1 btn-group-sm" role="group">'
							+'<button class="btn btn-sm btn-light">#'+hashtagArr[i]+'</button>'
							+'<button id="'+hashtagArr[i]+'" class="btn btn-sm btn-light" onclick="deleteValue(this.id)">&times;</button>'+'</div>')
				}
				var imageCount = Object.keys(jsonInfo.shopImage).length;
				if(imageCount==0){
					$('#regImageContainer').html("<p>등록된 이미지가 없습니다</p>");
				}else{
					for(let i=0; i<imageCount; i++){
						$('#regImageContainer').append("<img class='preview' id="+i+" src='data:image/jpg;base64,"+jsonInfo.shopImage[i].si_encodedImg+"'>");
					}
					$('#regImageContainer').append('&nbsp;&nbsp;<button id="all" type="button" class="btn btn-outline-info" onclick="deleteButton()">첨부파일 삭제</button>');
				}
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				$('#loadingImg').hide();
				$('#mask').hide();
			}
		});
	}
	
	function characterCheck() {
		var RegExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+┼<>@\#$%&\'\"\\\(\=]/gi;
		var space = / /gi;
		var obj = document.getElementsByName("inputHashtag")[0]
		if (RegExp.test(obj.value)) {
			alert("특수문자는 언더바(_)만 사용 가능합니다.");
			obj.value = obj.value.substring(0, obj.value.length - 1);
		}else if(space.test(obj.value)){
			add();
		}
	}
	
	function deleteValue(param){
		hashtagArr.splice(hashtagArr.indexOf(param),1);
		// $('.displayArea #'+param).remove();
		$('.btn-group').has('#'+param).remove();
	}
	
	function add(){
		let inputValue = $('#inputHashtag').val();
		if(isEmpty(inputValue)){
			alert('키워드를 입력해주세요.');
			$('#inputHashtag').val('');
		}else{
			inputValue = inputValue.slice(0,-1);
			hashtagArr.push(inputValue);
			$('.displayArea').append('<div class="btn-group mr-1 btn-group-sm" role="group">'
					+'<button class="btn btn-sm btn-light">#'+inputValue+'</button>'
					+'<button id="'+inputValue+'" class="btn btn-sm btn-light" onclick="deleteValue(this.id)">&times;</button>'+'</div>');
			$('#inputHashtag').val('');
		}
	}
	
	function isEmpty(str){
		if(typeof str == "undefined" || str == null || str == "" || str == " "){
			return true;
		}else{
			return false;
		}
	}
	
	function deleteButton(){
		alert('이미지 삭제할거임');
		$.ajax({
			type: "post",
			async: true,
			url: 'http://localhost:8090/andOne/biz/deleteShopImage.do',
			dataType: "text",
			beforeSend:function(data, textStatus){
				
			},
			data:"s_id=${s_id}",
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
	
	function wrapWindowByMask(){
		var maskHeight = $(document).height();  
		var maskWidth = $(window).width();  
		$('#mask').css({'width':maskWidth,'height':maskHeight});  
		$('#mask').fadeTo("slow",0.6);    
	}
	
	function uploadCancle(){
		sel_files = [];
		$('#image_container').empty();
		$('#image_container').html("<h5>첨부된 파일이 없습니다.</h5>");
		$('#inputShopImage').val("");
	}
	
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
					$('#inputShopImage').val("");
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
</head>
<body>
<div class="container">
	<form name="frmShopInfo" enctype="multipart/form-data" method="post">
			<h2 class="m-5">지역업체 수정</h2>
			<hr class="m-5">
			<div class="form-group col-sm-10 mx-auto mt-5 p-0">
			<p class="h4 mb-3">필수정보</p>
			<input type="hidden" name="bm_id" id="bm_id">
			<input type="hidden" name="s_locate" id="s_locate">
			<input type="hidden" name="s_score" id="s_score">
			<input type="hidden" name="s_hashtag" id="s_hashtag">
				<!-- 사업자번호 -->
				<div class="mb-2 row">
				    <label for="inputShopId" class="col-lg-3 col-sm-12 col-form-label">사업자번호</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="text" class="form-control" id="inputShopId" name="s_id" readonly>
		    		</div>
		    	</div>
		    	<!-- 카테고리 -->
		    	<div class="mb-2 row">
				    <label for="inputCategory" class="col-lg-3 col-sm-12 col-form-label">카테고리</label>
				    <div class="col-lg-7 col-sm-12">
				     	<select name="s_category" id="inputCategory">
							<option value="10">카페</option>
							<option value="20">음식점</option>
							<option value="30">병원</option>
							<option value="40">학원</option>
							<option value="50">미용</option>
							<option value="60">마트/유통</option>
							<option value="70">공방/클래스</option>
							<option value="80">인테리어</option>
							<option value="90">부동산</option>
						</select>
		    		</div>
		    	</div>
		    	<!-- 가게이름 -->
				<div class="mb-2 row">
				    <label for="inputShopName" class="col-lg-3 col-sm-12 col-form-label">가게이름</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="text" class="form-control" id="inputShopName" name="s_name">
		    		</div>
		    	</div>
		    	<!-- 가게소개 -->
				<div class="mb-2 row">
				    <label for="inputShopContent" class="col-lg-3 col-sm-12 col-form-label">가게소개</label>
				    <div class="col-lg-7 col-sm-12">
				      <textarea style="resize:none;" id="inputShopContent" name="s_content" rows="7" cols="43"></textarea>
		    		</div>
		    	</div>
		    	<!-- 대표번호 -->
				<div class="mb-2 row">
				    <label for="inputPhoneNumber" class="col-lg-3 col-12 col-form-label">대표번호</label>
				    <div class="col-lg-7 col-7 col-sm-9">
				      <input type="tel" class="form-control" id="inputPhoneNumber" name="s_phoneNumber"
				      placeholder="010-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" >
				      <div class='invalid-feedback phone-feedback'>유효하지 않은 번호 입니다.</div>
	    			</div>
	    		</div>
	    		<br><hr><br>
	    		<p class="h4 mb-3">선택정보</p>
	    		<!-- 해시태그 -->
	    		<div class="displayArea">

				</div><br>
	    		<div class="mb-2 row">
				    <label for="inputHashtag" class="col-lg-3 col-sm-12 col-form-label">해시태그</label>
				    <div class="col-lg-7 col-sm-12">
				      <input type="text" class="form-control" id="inputHashtag" name="inputHashtag" 
				      placeholder="키워드 입력 후 스페이스바로 등록" onkeyup="characterCheck()" onkeydown="characterCheck()" />
		    		</div>
		    	</div>
		    	<!-- 가게 이미지 -->
		    	<div class="mb-2 row">
				    <label for="inputShopImage" class="col-lg-3 col-sm-12 col-form-label">가게사진</label>
				    <div class="col-lg-7 col-sm-12">
				    	<input type="file" id="inputShopImage" name="image" accept="image/*" multiple />
				    	<button type="button" class="btn btn-danger btn-sm" onclick="uploadCancle()">삭제</button>
		    		</div>
		    	</div>
		    	<p>파일 미리보기</p>
		    	<div id="image_container">
					<p>첨부된 파일이 없습니다.</p>
				</div>
				<p>등록된 이미지</p>
				<div id="regImageContainer">
					<img class="preview" id="1st"/>
					<img class="preview" id="2nd"/>
					<img class="preview" id="3rd"/>
				</div>
			<input type="button" class="btn btn-primary btn-lg btn-block mt-4" value="수정" id="sendForm"></input>
			</div>
		</form>
		<div id="loadingImg">
		<img src="${contextPath }/resources/image/loading.gif" width="100" height="100">
		</div>
		<div id="mask">
		</div>
		<!-- 	// 자바스크립트 폼 양식 체크 영역 (중복 등 처리) -->
	<script>
		// 휴대폰번호 체크
		$("#inputPhoneNumber").keyup(function(){
			// 패턴체크
			var pattern = /^\(?([0-9]{3})\)?-?([0-9]{4})-([0-9]{4})$/;
			if($("#inputPhoneNumber").val().match(pattern)){	// 패턴이 맞을 경우
				$("#inputPhoneNumber").removeClass("is-invalid");
				$("#inputPhoneNumber").addClass("is-valid");
			}else{	
				$(".phone-feedback").text("유효하지 않은 번호입니다.");
				$("#inputPhoneNumber").removeClass("is-valid");
				$("#inputPhoneNumber").addClass("is-invalid");
			}
			// 중복 번호 확인
			if($("#inputPhoneNumber").hasClass("is-valid")){
				var _phone = $("#inputPhoneNumber").val();
				$.ajax({
	                type: "post",
	                async: "true",
	                dataType: "text",
	                data: {
	                    phone: _phone //data로 넘겨주기
	                },
	                url: "${contextPath}/biz/searchOverlapShopPhone.do",
	                success: function (data, textStatus) {
	                	if(data=="true"){	// 중복일경우
							$("#inputPhoneNumber").removeClass("is-valid");
							$("#inputPhoneNumber").addClass("is-invalid");
							$(".phone-feedback").text("중복되는 번호입니다.");
	                	}
	                }
				});
			}
		});
		
		// 수정 클릭 시 *
		$("#sendForm").click(function(){
			var shopId = $("#inputShopId").val();
			var phoneNum = $("#inputPhoneNumber").val();
			var shopName = $("#inputShopName").val();
			var shopContent = $("#inputShopContent").val();
			
			// 필수입력조건 체크(pwd제외)
			if(shopId=='' || shopId==null
					|| phoneNum=='' || phoneNum==null
					|| shopName=='' || shopName==null
					|| shopContent=='' || shopContent==null){
				alert("필수정보를 입력해주세요.");
			}
			// input에 invalid 클래스가 존재할 때
			else if($(".is-invalid").length!=0){
				alert("입력정보를 확인해주세요.");
			}else{
				alert('보낼거얌');
				//모든 조건 통과시 saveMember로 보내기
				hashtag = '';
				for(let i=0; i<hashtagArr.length; i++){
					hashtag += hashtagArr[i] + ','
				}
				hashtag = hashtag.slice(0,-1);
				$('#s_hashtag').val(hashtag);
				$('#inputHashtag').remove();
				alert(hashtag);
				var frmShopInfo = document.frmShopInfo;
				frmShopInfo.action = "${contextPath}/biz/modifyShop.do";
				frmShopInfo.submit();
			}
		});
		
	</script>
</div>
</body>
</html>