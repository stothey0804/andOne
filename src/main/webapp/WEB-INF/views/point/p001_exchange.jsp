<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style type="text/css">
	.p_content{
		width: 500px;
	}
	i {
		cursor: pointer;
	}
</style>
<script>
	var totalAmount = 0;	// 충전금액
	var nowPoint = 0;
	// comma 
	function pointToNumFormat(num) {
    	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	$(document).ready(function(){
       	// 포인트 읽기
   		$.ajax({
               type: "post",
               async: "true",
               dataType: "text",
               data: {
                   m_id: '${m_id}' //data로 넘겨주기
               },
               url: "${contextPath}/point/selectNowPoint.do",
               success: function (data, textStatus) {
            	   if(data!=''){
            		    nowPoint = data;
		       			$("#availiablePoint").text(pointToNumFormat(data));
            	   }else{
            		   $("#availiablePoint").text(0);
            	   }
               }
		});
		
   		// 환전금액 체크
   		$("#exchangeAmount").keyup(function(){
   				var reg = /[^0-9]/g;
   				var value = $("#exchangeAmount").val();
   				if(reg.test(value)){	// 숫자가 아닐경우
   					$("#exchangeAmount").val(value.replace(reg,'')); 	// 수정
   				}else{
	   				// 금액 넘을경우
	   				if(value*1 > nowPoint){
	   					alert("보유포인트를 초과합니다.	");
	   					$("#exchangeAmount").val('');
	   				}
   				}
   			
   		});
		
	});
		
	// 약관동의시
	function agreeTermClick(){
		let btnSubmit = document.getElementById('btnCharge');
		if(document.getElementById('agreeTerm').checked){
			btnSubmit.disabled = false;
		}else{
			btnSubmit.disabled = true;
		}
	}

	
</script>
</head>
<body>

<form name="frmData" method="post" action="${contextPath}/point/exchangeSend.do">
<div class="container mx-auto p-5">
	<h3>포인트환전</h3>
	<hr>
	<!-- 충전금액  -->
	<div class="p_content mt-5 mx-auto">
		<div class="row border-bottom mb-3">
			<h5>보유포인트</h5>
			<p class="ml-auto">
			<span id="availiablePoint"></span>원(P)
			</p>
		</div>
		<div class="row border-bottom mb-3 pb-2">
			<h5>환전금액</h5>
			<div class="ml-auto form-inline">
			<input type="text" class="form-control mr-1 text-right" id="exchangeAmount" name="amount" required>
			P
			</div>
		</div>

	</div>
	<div class="p_content mt-5 mx-auto">
		<div class="row border-bottom mb-3">
			<h5>환전정보</h5>
		</div>
		  <fieldset class="form-group">
		    <div class="row">
		      <label for="selectBank" class="col-form-label col-sm-4 pt-0">계좌선택<span class="text-danger">*</span></label>
		      <div class="col-sm-8">
				    <select class="form-control" id="selectBank" name="bank" required>
				      <option value="01">KB국민은행</option>
				      <option value="02">NH농협은행</option>
				      <option value="03">신한은행</option>
				      <option value="04">우리은행</option>
				      <option value="05">KEB하나은행</option>
				      <option value="06">SC제일은행</option>
				      <option value="07">한국시티은행</option>
				      <option value="08">IBK기업은행</option>
				      <option value="09">수협중앙회</option>
				      <option value="10">카카오뱅크</option>
				      <option value="11">케이뱅크</option>
				    </select>
		      </div>
		    </div>
		  </fieldset>
		    <div class="form-group row">
			    <label for="inputAccountNum" class="col-sm-4 col-form-label">계좌번호<span class="text-danger">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control " id="inputAccountNum" placeholder="-를 포함해주세요" name="account" required>
			    </div>
			 </div>
			 <div class="form-group text-center">
			 	<p class="text-danger">환전은 최대 5영업일이 소요되며, 10:00에 입금됩니다.</p>
			 </div>
			 <div class="form-group text-center mt-5">
			  <input class="form-check-input" type="checkbox" value="" id="agreeTerm" onclick="agreeTermClick()">
			  <label class="form-check-label" for="agreeTerm">
			    &분의일 약관에 동의합니다.
			  </label>
			  <input type="hidden" name="target" value="${m_id}" />
			  <button type="submit" id="btnCharge" class="btn btn-primary btn-lg btn-block mt-2" disabled>환전 요청하기</button>
			</div>
	
	</div>
</div>
</form>
</body>
</html>