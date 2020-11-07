<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<style>
		.m_img {
				position: relative;
				border-radius: 70px;
				-moz-border-radius: 70px;
				-khtml-border-radius: 70px;
				-webkit-border-radius: 70px;
				width: 60px;
				height: 60px;
				}
	</style>
	<script>
	function init(){
		let prices = document.querySelectorAll("span.price");
			let priceResults = document.querySelectorAll("span.priceResult");
			
			for(let i=0; i<prices.length; i++){
				var pResult = prices[i].textContent;
				priceResults[i].innerHTML = pointToNumFormat(pResult);
  			}
		 	function pointToNumFormat(num) {
		       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    }
	}
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="bg-light" onload="init()">

	 <!-- 포인트 충전 Modal영역 -->
	 <div class="modal fade" id="pointModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>보유하신 포인트가 부족합니다.<br> 부족한 포인트를 충전하신 후에 신청하실 수 있습니다.</h6> 
                        <h5 id="point_value3"></h5>
                        <h5>${m_nickname}님의 현재 보유 포인트:</h5>
                        <h5 id="point_value"></h5>
                        <h5 id="point_value2"></h5>
                    </div>
                    <div class="modal-footer">
	                    <form name="frmData" method="post">
	                    	<input type="hidden" id="amountResult" name="amount" /> <!-- 충전할금액 전달 -->
	                    	<button type="button" class="btn btn-primary" onClick="openPopup()">충전하기</button>
	                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	                    </form>
                    </div>
                </div>
                </div>
	 </div>
	 
	  <!-- 결제 진행 Modal영역 -->
	 <div class="modal fade" id="chargeModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>결제 후 신청이 완료됩니다</h6> 
                        <h5 id="charge_value"></h5>
                    </div>
                    <div class="modal-footer">
	                    <form name="payData" method="post">
	                    	<input type="hidden" id="payResult" name="payPoint" /> <!-- 결제할금액 전달 -->
	                    	<input type="hidden" id="pay_One_id" name="one_id" /> <!-- 글번호-->
	                    	<input type="hidden" id="pay_one_type" name="one_type" /> <!-- 엔분의일타입 -->
	                    	<button type="submit" class="btn btn-primary" onClick="openPayPopup()">결제하기</button>
	                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	                    </form>
                    </div>
                </div>
                </div>
	 </div>
	 
	 <!-- 취소성공 Modal영역 -->
	 <div class="modal fade" id="cancleOkModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>신청하신 &amp;분의일 취소와 사용하신 포인트(<span class="price invisible">${andoneDetail.one_price}</span><span class="priceResult"></span>P) 환불이 완료되었습니다</h6> 
                    </div>
                    <div class="modal-footer">
                    	<button type="submit" class="btn btn-primary" 
                    	onclick="location.href='${contextPath}/and?g_id=${g_id}'">확인 ${g_id}</button>
                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div>
        </div>
	 </div>
	 
	 <!-- 취소불가 Modal영역 -->
	 <div class="modal fade" id="cancleFailModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>수령시간 30분전까지만 취소가 가능합니다</h6> 
                    </div>
                    <div class="modal-footer">
	                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
                    </div>
                </div>
                </div>
	 </div>
<div class="container my-5">
	<div class="row">
		<!-- 좌측 -->
		<div class="col-7 mr-3 border-bottom">
			<p class="h2"><span class="h4">[${andoneDetail.one_category}]</span> ${andoneDetail.one_title}
			</p> 
			<div class="clearfix">
				<p class="float-left h5">
				<c:if test="${andoneDetail.one_state eq '모집중'}">
					<span class="text-primary">
				</c:if>
				<c:if test="${andoneDetail.one_state eq '결제완료'}">
					<span class="text-success">
				</c:if>
				<c:if test="${andoneDetail.one_state eq '진행완료'}">
					<span class="text-secondary">
				</c:if>
				<c:if test="${andoneDetail.one_state eq '취소'}">
					<span class="text-danger">
				</c:if>
				${andoneDetail.one_state}
				</span></p>
				<p class="float-right h6 text-secondary"><i class="fas fa-user-friends"></i>  ${andoneDetail.one_member}/${andoneDetail.one_memberMax}명</p>			
			</div>
			
		</div>
		<!-- 우측 -->
		<div class="col-4 border-bottom">
			<p class="h6 text-muted text-right">${andoneDetail.one_date} 예정</p>
			<p class="h2 font-weight-bold text-right">
			<span class="h6">결제금액 </span>
			<span class="price invisible">${andoneDetail.one_price}</span><span class="priceResult"></span>P</p>
		</div>
	</div>
	<div class="row my-3">
		<!-- 내용 -->
		<div class="col-7 mr-3">
			 <!-- 해시태그 -->
			 #${andoneDetail.one_hashTag}<br>
			 <!-- 글내용 -->
			 <div class="mt-3">${andoneDetail.one_content}</div>
			 <!-- 참여자 -->
			 <div class="card mt-5 clearfix">
			 		<ul class="list-group list-group-horizontal">
			 		<c:forEach var ="oneMemList" items="${oneMemList}" > 
			 		<li class="list-group-item border-0 text-center">
						<c:set var="mem_img" value="${oneMemList.resultUserImg}"/>
					 		<c:if test="${oneMemList.om_leader eq '10'}"> <!-- 작성자 구분 -->
					 		<c:set var="leaderId" value="${oneMemList.m_id}" /><!-- target저장 -->
					 			<c:choose>
					 			 	<c:when test="${mem_img eq null}">
					 			 		<img src="${contextPath}/resources/image/user.png" class="m_img" onclick="openMemPopup('${oneMemList.m_id}')">
					 			 	</c:when>
					 			 	 <c:otherwise>
					 			 	 	<img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img" onclick="openMemPopup('${oneMemList.m_id}')"> 
						 			 </c:otherwise>
					 			 </c:choose><br> 
					 			<i class="fas fa-crown text-warning"></i>
					 			${oneMemList.m_nickname} 
							</c:if>
							<c:set var="mem_img" value="${oneMemList.resultUserImg}"/>
					 		<c:if test="${oneMemList.om_leader eq '20' and (oneMemList.om_state eq '20' or oneMemList.om_state eq '30') }"> <!-- 결제완료한 참가자 -->
					 			<c:choose>
					 			 	<c:when test="${mem_img eq null}">
					 			 		<img src="${contextPath}/resources/image/user.png" class="m_img" onclick="openMemPopup('${oneMemList.m_id}')">
					 			 	</c:when>
					 			 	 <c:otherwise>
					 			 	 	<img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img" onclick="openMemPopup('${oneMemList.m_id}')"> 
						 			 </c:otherwise>
					 			 </c:choose><br>
					 			${oneMemList.m_nickname} 
							</c:if>
					</li>
					</c:forEach>
					</ul>
<%-- 			 	<c:forEach var ="oneMemList" items="${oneMemList}" >  --%>
<%-- 					<c:set var="mem_img" value="${oneMemList.resultUserImg}"/> --%>
<!-- 				 			 참가자 닉네임  -->
<%-- 				 			 <c:choose> --%>
<%-- 				 			 	<c:when test="${mem_img eq null}"> --%>
<%-- 				 			 		<img src="${contextPath}/resources/image/user.png" class="m_img"> --%>
<%-- 				 			 	</c:when> --%>
<%-- 					 			 <c:otherwise> --%>
<%-- 					 			 	<img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img">  --%>
<%-- 					 			 </c:otherwise> --%>
<%-- 				 			 </c:choose>  --%>
<%-- 			 			 	${oneMemList.m_nickname} --%>
<%-- 						</c:if> --%>
<%-- 				</c:forEach><br> --%>
			 </div>
		</div>
		<!-- 지도 -->
		<div class="col-4">
			<div id="map" class="border mb-2" style="height:350px">
			</div>
			<!-- 버튼들 -->
			<div>
				<c:choose>
		 		<c:when test="${andoneDetail.one_state eq '취소'}">
		 			<p class="text-muted text-center my-3">취소되어 신청이 불가능한 &amp;분의일 입니다 :)</p>
		 		</c:when>
		 		<c:when test="${andoneDetail.one_state eq '진행완료'}">
		 			<p class="text-muted text-center my-3">같이 &amp;분의일을 한 사람에게 후기를 남겨주세요:)</p>
		 		</c:when>
		 		<c:when test="${omLeaderCheck.om_leader eq '10'}">
		 		<div class="row mb-2">
		 		<div class="col-6 pr-1"><button class="btn btn-block btn-info" onclick="modifyAndOne('${andoneDetail.one_id}')">수정하기</button></div>
		 		<div class="col-6 pl-1"><button class="btn btn-block btn-danger" onclick="deleteAndOne('${andoneDetail.one_id}')">삭제하기</button></div>
		 		</div>
				 <button class="btn btn-secondary col-12" onclick="location.href='${contextPath}/and/waitonemem.do?one_id=${andoneDetail.one_id}'">참가신청확인하기</button><br>			 	
	 			</c:when>
	 			<c:when test="${omLeaderCheck.om_leader eq '20' and omLeaderCheck.om_state ne '40'}"> 
				 	<button class="btn btn btn-danger col-12" onclick="cancelAndOne('${andoneDetail.one_id}','${andoneDetail.one_price}')">취소하기</button>
				</c:when>
				<c:otherwise>
			 		<button class="btn btn-primary col-12" onclick="submitAndOne('${andoneDetail.one_price}','${andoneDetail.one_id}','${andoneDetail.one_type}')">신청하기</button><br>
				</c:otherwise>
				</c:choose>
				<c:if test="${omLeaderCheck.om_leader ne '10'}">
				 	<button class="btn btn-light col-12 mt-1" type="button" onClick='openReportPopup()'>부적절한 &amp;분의일 신고하기</button>
				</c:if>		
				<c:if test="${omLeaderCheck.om_state eq '20' and andoneDetail.one_state eq '결제완료' }"> 
				 	<button class="btn btn-outline-primary col-12" onclick="completeAndOne('${andoneDetail.one_id}')">엔분의일 완료</button> 
				</c:if>
			</div>
		</div>
	</div>
		
		 주소  <div class="addr">${andoneDetail.one_addr}</div> <br>

</div>
  	<!--kakao map-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
	<script>
        //주소
        var inputAddr = document.querySelector("div.addr");
        var addr = inputAddr.innerHTML
        console.log(addr);
		//주소-> 지도표시
		 var container = document.getElementById("map"),
        	option = {
            center: new daum.maps.LatLng(37.570371, 126.985308), // 지도의 중심좌표 (위도,경도)
            level: 3
        };
		//지도 생성
       	var map = new daum.maps.Map(container, option); 
		//주소-좌표 변환객체 
		var geocoder = new daum.maps.services.Geocoder();
		//주소로 좌표 검색
		geocoder.addressSearch(addr, function(result, status){
			 // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		    	 var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    	 // 결과값으로 받은 위치를 마커로 표시합니다
		    	 var marker = new kakao.maps.Marker({
		    		 map: map,
		    		 position: coords
		    		 });
		    	 map.setCenter(coords);
		    	 }
			 }); 

       //신청하기 클릭시 진행
		function submitAndOne(price,one_id,one_type){
		        console.log(price);
		        console.log(one_id);
		        console.log(one_type);
        		$.ajax({
        			type : "post",
        			dataType: "text",
        			async: "true",
        			url:"${contextPath}/and/addOneMember.do",
        			data:{
        				"one_price" : price,
        				"one_id" : one_id
        			},
        			success:function(data,textSataus){
        				console.log("결과 :"+data);
        				if(data == "true"){
        					console.log("결제가능");
        					$('#chargeModal').modal("show");
        					$('#charge_value').text("결제금액:"+price+"원");
        					document.getElementById('payResult').value = price;//결제금액전달
        					document.getElementById('pay_One_id').value = one_id;//글번호 전달
        					document.getElementById('pay_one_type').value = one_type;//엔분의일 타입전달
        				}else if(data == "false"){
        					console.log("인원초과");
        					alert("신청인원이 초과되어 신청이 불가능합니다");
        				}else{
        					console.log("포인트부족" +data);
        					var finalPrice = Math.ceil((price-data)/1000)*1000;
        					console.log("됨?"+finalPrice);
        					$('#pointModal').modal("show");
        					$('#point_value3').text("결제요청금액"+price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원");
        					$('#point_value').text(data+"p");
        					$('#point_value2').text("충전할 포인트"+finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"P");
        					document.getElementById('amountResult').value = finalPrice;
        				}
        			}
        		})
       		}
       //취소하기
       function cancelAndOne(one_id,one_price){
	        console.log(one_id);
   			$.ajax({
	   			type : "post",
	   			dataType: "text",
	   			async: "true",
	   			url:"${contextPath}/and/cancelOneMember.do",
	   			data:{
	   				"one_id" : one_id,
	   				"one_price" : one_price
   			},
   			success:function(data,textSataus){
   				console.log("확인: "+data);
   				if(data == 'true'){
   					console.log("취소성공");
   					$('#cancleOkModal').modal("show");
   					}else{
   						console.log("취소불가");
   						$('#cancleFailModal').modal("show");
   					}
				}
			})
		}
       
	   // 포인트충전하기 클릭
		function openPopup(){
			let popTitle = "popupOpener";
			window.open("", popTitle, "resizable=yes,top=0,left=0,width=450,height=500");
			let frmData = document.frmData;
			frmData.target = popTitle;
			frmData.action = "${contextPath}/point/kakaoPay.do";
			frmData.submit();
	       }
   		 
   	   //결제하기 클릭 - 신청
	    function openPayPopup(){
   		    // 결제알림 
   		    // db저장	
   		    let g_id = '${g_id}';
   		    let type = '';	// 분류코드
   		    if(g_id=='010'){	// 같이먹기
   		    	type = '10';
   		    }else if(g_id=='011'){	//같이사기
   		    	type = '20';
   		    }else if(g_id=='012'){	//같이하기
   		    	type = '30';
   		    }
   		 	let content = '['+ '${andoneDetail.one_id}' +'] 참가신청이 도착했습니다.';		// 알림메시지
   		 	let target = '${leaderId}';
   		 	let url = '${contextPath}/and/waitonemem.do?one_id='+'${andoneDetail.one_id}';
			$.ajax({
				type: 'post',
				url: '${contextPath}/member/saveNotify.do',
				dataType: 'text',
				data: {
					target: target,
					content: content,
					type: type,
					url: url
				},
				success: function(){
					socket.send("&분의일,"+target+","+content+","+url);	// 소켓에 전달
				}
			});
	    	let popTitle = "payPopupOpener";
	    	window.open("", popTitle, "resizable=yes,top=0,left=0,width=450,height=500");
	    	let payData = document.payData;
	    	payData.target = popTitle;
	    	payData.action = "${contextPath}/point/pay.do";
	    	payData.submit();
     		}  
   		 
		
		//삭제하기
		function deleteAndOne(one_id){
			if(window.confirm("정말로 &분의일을 삭제하겠습니까?")){
				$.ajax({
		   			type : "post",
		   			dataType: "text",
		   			async: "true",
		   			url:"${contextPath}/and/deleteAndOne.do",
		   			data:{
		   				"one_id" : one_id
	   				},
	   	   			success:function(data,textSataus){
	   	   				if(data == "ok"){
	   	   					alert("참가자가 존재해 삭제가 불가능합니다");
	   	   				}else{
		   	   				window.location.href = '${contextPath}/and?g_id=${g_id}';	   	   					
	   	   				}
	   	   			}
				})
			}
		}
		//수정하기
		function modifyAndOne(one_id){
			$.ajax({
				type : "post",
	   			dataType: "text",
	   			async: "true",
	   			url:"${contextPath}/and/modifyAndOneCheck.do",
	   			data:{
	   				"one_id" : one_id
   				},
   	   			success:function(data,textSataus){ 
   	   				console.log("참가자유무:"+data);
   	   				if(data == "ok"){
   	   					alert("참가자가 존재해 수정이 불가능합니다");
   	   				}else{
   	   					window.location.href = "${contextPath}/and/modifyAndOnePage.do?one_id=${andoneDetail.one_id}&g_id=${g_id}";
   	   				}
   	   			}
			})
		}
		//완료하기
		function completeAndOne(one_id){
			if(window.confirm("&분의일을 완료하셨나요? 완료하셨다면 같이 &분의일을 진행한 분께 후기를 남겨주세요:)")){
				$.ajax({
					type : "post",
		   			dataType: "text",
		   			async: "true",
		   			url:"${contextPath}/and/completeAndOne.do",
		   			data:{
		   				"one_id" : one_id
	   				},
	   	   			success:function(data,textSataus){ 
	   	   				alert("완료되었습니다")
	   	   				// 완료 알림 전송
	   	   				
	   	   				location.reload();
	   	   			}
				})
			}
		}
		// 신고하기 연결
		function openReportPopup(){
			var popupOpener;
			popupOpener = window.open("${contextPath}/member/reportInit.do?target=${andoneDetail.one_id}&flag=one", "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
		}
		// 프로필 클릭 
		function openMemPopup(memID){
				var popupOpener;
				let m_id = memID;
				popupOpener = window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
		}
	</script>
</body>
</html>