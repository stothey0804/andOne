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
	.container div.inner{
		margin:0 auto;
	}
	

</style>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		$('button#reg').click(function(){
			if(s_id == 'isNull'){
				window.location.href="${contextPath}/biz/crudController.do?bm_id=${bm_id }&s_id=${s_id }&path=addShop";
			}else{
				alert('업체가 이미 있다능');
			}
		})
		$('button#mod').click(function(){
			if(s_id == 'isNull'){
				alert('업체가 없다능');
			}else{
				window.location.href="${contextPath}/biz/crudController.do?bm_id=${bm_id }&s_id=${s_id }&path=modifyShop";
			}
		})
		$('button#del').click(function(){
			if(s_id == 'isNull'){
				alert('업체가 없다능');
			}else{
				window.location.href="${contextPath}/biz/crudController.do?bm_id=${bm_id }&s_id=${s_id }&path=deleteShop";
			}
		})
	})
	var bm_id = '${bm_id }';
	var s_id = '${s_id }';
</script>
</head>
<body>
	<div class="container">
		<h2 class="m-5">지역업체 등록</h2>
			<hr class="m-5">
			<br>
			<div class="inner">
				<button id="reg" class="btn btn-info btn-lg mt-2">신규업체 등록</button>
			</div>
			<div class="inner">
				<button id="mod" class="btn btn-primary btn-lg mt-2">업체정보 수정</button>
			</div>
			<div class="inner">
				<button id="del" class="btn btn-danger btn-lg mt-2">등록업체 삭제</button>
			</div>
	</div>
</body>
</html>