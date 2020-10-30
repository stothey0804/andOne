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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
상세조회!<br>

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
                        <h6>신청하신 &의일 취소가 완료되었습니다</h6> 
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
<div>
	<c:forEach var ="andoneDetail" items="${andOneDetailList}" > 	
		제목  ${andoneDetail.one_title} <br>
		 카테고리 ${andoneDetail.one_category}<br>
		 해쉬태그 ${andoneDetail.one_hashTag}<br>
		 수령시간 ${andoneDetail.one_date}<br>
		 상태 ${andoneDetail.one_state}<br>
		<c:forEach var ="oneMemList" items="${oneMemList}" > 
			<c:set var="mem_img" value="${oneMemList.resultUserImg}"/>
				<c:if test="${oneMemList.om_leader eq '10'}"> <!-- 작성자 구분 -->
		 			작성자 닉네임${oneMemList.m_nickname} <img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img"><br>
				</c:if>
		</c:forEach>
		 좌표  ${andoneDetail.one_locate_Lat} <br>
		 좌표  ${andoneDetail.one_locate_Lng} <br>
		 주소  <div class="addr">${andoneDetail.one_addr}</div> <br>
		 <div id="map" style="width:500px; height:400px"></div> 
		 <c:forEach var ="oneMemList" items="${oneMemList}" > 
			<c:set var="mem_img" value="${oneMemList.resultUserImg}"/>
				<c:if test="${oneMemList.om_leader eq '20' and oneMemList.om_state eq '30'}"> <!-- 결제완료한 참가자 -->
		 			 참가자 닉네임 
		 			 <c:choose>
		 			 	<c:when test="${mem_img eq null}">
		 			 		<img src="${contextPath}/resources/image/user.png" class="m_img">
		 			 	</c:when>
			 			 <c:otherwise>
			 			 	<img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img"> 
			 			 </c:otherwise>
		 			 </c:choose> 
	 			 	${oneMemList.m_nickname}
				</c:if>
		</c:forEach><br>
		 금액<span class="price">${andoneDetail.one_price}</span>원<br>
		 	test!!!!!! ${omLeaderCheck}
		 	<c:choose>
		 		<c:when test="${omLeaderCheck eq '10'}"> <!-- 작성자 -->
				 	<br><button id="edit">수정하기</button>	 	 
				 	<br><button onclick="deleteAndOne('${andoneDetail.one_id}')">삭제하기</button>
				 	<br><button onclick="location.href='${contextPath}/and/waitonemem.do?one_id=${andoneDetail.one_id}'">참가신청확인하기</button>				 	
	 			</c:when>
	 			<c:when test="${omLeaderCheck eq '20'}"> <!-- 참가자 -->
				 	<button onclick="CancelAndOne('${andoneDetail.one_id}')">취소하기</button>
				</c:when>
				<c:otherwise>
			 		<button onclick="submitAndOne('${andoneDetail.one_price}','${andoneDetail.one_id}','${andoneDetail.one_type}')">신청하기</button><br>
			 		<button type="button" onClick='openReportPopup()'>신고하기</button>
				</c:otherwise>
			</c:choose>
	</c:forEach>
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
        				"one_price" : price
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
        				}else{
        					console.log("포인트부족" +data);
        					var finalPrice = Math.ceil((price-data)/1000)*1000;
        					console.log("됨?"+finalPrice);
        					$('#pointModal').modal("show");
        					$('#point_value3').text("결제요청금액"+price+"원");
        					$('#point_value').text(data+"p");
        					$('#point_value2').text("충전할 포인트"+finalPrice+"P");
        					document.getElementById('amountResult').value = finalPrice;
        				}
        			}
        		})
       		}
       //취소하기
       function CancelAndOne(one_id){
	        console.log(one_id);
   			$.ajax({
	   			type : "post",
	   			dataType: "text",
	   			async: "true",
	   			url:"${contextPath}/and/cancelOneMember.do",
	   			data:{
	   				"one_id" : one_id
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
   		 
   	   //결제하기 클릭
	    function openPayPopup(){
	    	let popTitle = "payPopupOpener";
	    	window.open("", popTitle, "resizable=yes,top=0,left=0,width=450,height=500");
	    	let payData = document.payData;
	    	payData.target = popTitle;
	    	payData.action = "${contextPath}/point/pay.do";
	    	payData.submit();
     		}  
   		 
		// 신고하기 연결
		function openReportPopup(){
			var popupOpener;
			popupOpener = window.open("${contextPath}/member/reportInit.do?target=${andoneDetail.one_id}&flag=one", "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
		}
		
		function deleteAndOne(one_id){
			if(window.confirm("&분의일을 삭제하겠습니까?")){
				$.ajax({
		   			type : "post",
		   			dataType: "text",
		   			async: "true",
		   			url:"${contextPath}/and/deleteAndOne.do",
		   			data:{
		   				"one_id" : one_id
	   			}
			})
		}
	}
		
	</script>
</body>
</html>