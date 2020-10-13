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
	
	function init(){
		// 충전금액 초기값 출력
		document.getElementById('totalAmount').innerHTML = totalAmount;
		// 약관동의시
		document.getElementById("agreeTerm").addEventListener("click",function(){
			let btnSubmit = document.getElementById('btnCharge');
			if(document.getElementById('agreeTerm').checked){
				btnSubmit.disabled = false;
			}else{
				btnSubmit.disabled = true;
			}
		});
	}
	
	function add1000won(){
		totalAmount += 1000;
		document.getElementById('totalAmount').innerHTML = totalAmount;
	}
	function add5000won(){
		totalAmount += 5000;
		document.getElementById('totalAmount').innerHTML = totalAmount;
	}
	function add10000won(){
		totalAmount += 10000;
		document.getElementById('totalAmount').innerHTML = totalAmount;
	}

	function amountClear(){
		totalAmount = 0;
		document.getElementById('totalAmount').innerHTML = totalAmount;
	}
	
	// 결제하기 클릭
	function openPopup(){
		let authName = document.getElementById('inputName').value;
		if(totalAmount==0){
			alert("결제금액을 설정해주세요.");
		}else if(authName=='' || authName==null){
			
		}else{
			document.getElementById('amountResult').value = totalAmount;
			let popTitle = "popupOpener";
			window.open("", popTitle, "resizable=yes,top=0,left=0,width=450,height=500");
			let frmData = document.frmData;
			frmData.target = popTitle;
			frmData.action = "${contextPath}/point/kakaoPay.do";
			frmData.submit();
		}
	}
	
</script>
</head>
<body onload='init()'>
<div class="container mx-auto p-5">
	<h3>포인트충전</h3>
	<hr>
	<!-- 충전금액  -->
	<div class="p_content mt-5 mx-auto">
		<div class="row border-bottom mb-3">
			<h5>충전금액</h5>
			<p class="ml-auto"><span id="totalAmount"></span>원(P)
			<i class="far fa-times-circle" onClick='amountClear()'></i>
			</p>
		</div>
		<div class="row">
			<div class="btn-group col-12" role="group">
			  <button type="button" class="btn btn-outline-primary" onClick='add1000won()'>+1,000원</button>
			  <button type="button" class="btn btn-outline-primary" onClick='add5000won()'>+5,000원</button>
			  <button type="button" class="btn btn-outline-primary" onClick='add10000won()'>+10,000원</button>
			</div>
		</div>
	</div>
	<div class="p_content mt-5 mx-auto">
	<form name="frmData" method="post">
		<div class="row border-bottom mb-3">
			<h5>결제정보</h5>
		</div>
		  <fieldset class="form-group">
		    <div class="row">
		      <legend class="col-form-label col-sm-4 pt-0">결제수단</legend>
		      <div class="col-sm-8">
		        <div class="form-check">
		          <input class="form-check-input" type="radio" name="chargeType" id="kakaoPay" value="kakaoPay" checked>
		          <label class="form-check-label" for="kakaopay">
		            카카오페이 <img src="https://d33pksfia2a94m.cloudfront.net/assets/img/social/kakaopay_yellow_small.png">
		          </label>
		        </div>
		      </div>
		    </div>
		  </fieldset>
		    <div class="form-group row">
			    <label for="inputName" class="col-sm-4 col-form-label">이름<span class="text-danger">*</span></label>
			    <div class="col-sm-8">
			      <input type="text" class="form-control" id="inputName" name="authName" required>
			    </div>
			 </div>
			 <div class="form-group text-center mt-5">
			  <input class="form-check-input" type="checkbox" value="" id="agreeTerm">
			  <label class="form-check-label" for="agreeTerm">
			    &분의일 약관에 동의합니다.
			  </label>
			  <input type="hidden" id="amountResult" name="amount" />
			  <button type="submit" id="btnCharge" class="btn btn-primary btn-lg btn-block mt-2" onClick="openPopup()" disabled>결제하기</button>
			</div>
	</form>
	</div>
</div>
</body>
</html>