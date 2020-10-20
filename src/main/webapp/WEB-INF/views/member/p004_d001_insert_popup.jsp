<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 평가 쓰기</title>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<!-- font Awesome -->
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<style>
	datalist {
	    display: -webkit-box;
	    display: -webkit-flex;
	    display: -ms-flexbox;
	    display: flex;
	}
	
	datalist option {
	    -webkit-box-flex: 1;
	    -webkit-flex-grow: 1;
	        -ms-flex-positive: 1;
	            flex-grow: 1;
	    -webkit-flex-basis: 0;
	        -ms-flex-preferred-size: 0;
	            flex-basis: 0;
        margin-right: 1.86em;
	}
</style>
</head>
<body class="bg-light">
	<div class="container p-4">
		<p class="h3">회원 평가 남기기</p>
		<hr class="my-3">
		<form action="${contextPath}/member/insertMemberReview.do" method="post">
		  <div class="form-group">
		    <label for="formControlRange">점수를 선택해주세요.</label>
		    <input type="range" class="form-control-range" name="mr_score" min="1" max="10" step="1" list="score" />
             <datalist id="score">
                <option value="1" label="1">
                <option value="2" label="2">
                <option value="3" label="3">
                <option value="4" label="4">
                <option value="5" label="5">
                <option value="6" label="6">
                <option value="7" label="7">
                <option value="8" label="8">
                <option value="9" label="9">
                <option value="10" label="10">
            </datalist>        
          </div>
          <div class="form-group mt-4">
		   <label for="exampleFormControlTextarea1">평가내용</label>
		   <textarea class="form-control" name="mr_content" rows="7"></textarea>
		 </div>  
		 <input type="hidden" name="mr_target" value="${mr_target}">
		 <input type="hidden" name="m_id" value="${sessionScope.m_id}">
         <button type="submit" class="btn btn-primary btn-block">평가남기기</button>   
		</form>
  	</div>
</body>
</html>