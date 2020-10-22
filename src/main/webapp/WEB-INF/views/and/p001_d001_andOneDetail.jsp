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
	 <!-- Modal영역 -->
	 <div class="modal fade" id="pointModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>보유하신 포인트가 부족합니다</h6> 
                        <h5>${m_nickname}님의포인트:</h5><h5 id="point_value"></h5>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="pwdFind_Btn" >포인트충전하기</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
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
				<c:if test="${oneMemList.om_leader eq '10'}">
		 			작성자 닉네임${oneMemList.m_nickname} <img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img"><br>
				</c:if>
		</c:forEach>
		 좌표  ${andoneDetail.one_locate_Lat} <br>
		 좌표  ${andoneDetail.one_locate_Lng} <br>
		 주소  <div class="addr">${andoneDetail.one_addr}</div> <br>
		 <div id="map" style="width:500px; height:400px"></div> 
		 <c:forEach var ="oneMemList" items="${oneMemList}" > 
			<c:set var="mem_img" value="${oneMemList.resultUserImg}"/>
				<c:if test="${oneMemList.om_leader eq '20' and oneMemList.om_state eq '30'}">
		 			 참가자 닉네임${oneMemList.m_nickname} <img src="data:image/jpg;base64, ${oneMemList.resultUserImg}" class="m_img">
				</c:if>
		</c:forEach><br>
		 금액<span class="price">${andoneDetail.one_price}</span>원<br>
		 	test!!!!!! ${omLeaderCheck}
		 	<c:choose>
		 		<c:when test="${omLeaderCheck eq '10'}"> <!-- 작성자 -->
				 	<br><button id="edit">수정하기</button>	 	 
				 	<br><button id="delete">삭제하기</button>	 	
	 			</c:when>
	 			<c:when test="${omLeaderCheck eq '20'}"> <!-- 참가자 -->
				 	<button id="cancle">취소하기</button>
				</c:when>
				<c:otherwise>
			 		<button id="submit">신청하기</button>
				</c:otherwise>
			</c:choose>
		 <span class="type invisible">${andoneDetail.one_type}</span>
		 <span class="one_id invisible">${andoneDetail.one_id}</span>
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
        //금액
       	var inputprice = document.querySelector("span.price");
        var price = inputprice.innerHTML;
        //글번호
       	var inputType = document.querySelector("span.type");
        var one_type = inputType.innerHTML;
        //타입
       	var inputOneid = document.querySelector("span.one_id");
        var one_id = inputOneid.innerHTML;
        
       //onetype one_id보내고 m_id는 세션에서 받아서 쓰기 
        $(document).ready(function(){
        	$('#submit').click(function(){
		        console.log(price);
		        console.log(one_type);
		        console.log(one_id);
        		$.ajax({
        			type : "post",
        			dataType: "text",
        			async: "true",
        			url:"${contextPath}/and/addOneMember.do",
        			data:{
        				"one_price" : price,
        				"one_type" : one_type,
        				"one_id" : one_id
        			},
        			success:function(data,textSataus){
        				console.log("결과 :"+data);
        				if(data == "true"){
        					console.log("결제가능");
        				}else{
        					console.log("포인트부족" +data);
        					$('#pointModal').modal("show");
        					$('#point_value').text(data);
        				}
        			}
        		})
        	})
        })
	</script>
</body>
</html>