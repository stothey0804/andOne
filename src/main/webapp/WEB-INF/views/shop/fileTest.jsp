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

<script src="http://code.jquery.com/jquery-2.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		
	})
	
	function show(){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/shop/viewTest.do",
			dataType: "text",
			data:"s_id=20200917-1",
			success: function (data, textStatus) {
				console.log('---------->'+data);
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var path = jsonInfo.shopImage[0].si_encodedImg;
				$('body').html('<img width="auto" height="400" src="data:image/jpg;base64,'+path+'" />');
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		});
	}

</script>
</head>
<body>
	<form action="/andOne/shop/getFile.do" method="post" enctype="multipart/form-data">
		<input type="file" name="si_img" />
		<input type="submit" value="전송" />
	</form>
	<button onclick="show()">아이유</button>
	<hr>
	<form action="/andOne/shop/updateShopReviewImage.do" method="post" enctype="multipart/form-data">
		<input type="file" name="ri_img" />
		<input type="submit" value="전송" />
	</form>
</body>
</html>