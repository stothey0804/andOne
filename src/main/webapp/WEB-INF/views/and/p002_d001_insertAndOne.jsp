<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
 	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<!-- Perfect-DateTimePicker CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/jquery.datetimepicker.css"/>
	<!-- Perfect-DateTimePicker JS -->
	<script type="text/javascript" src="${contextPath}/resources/js/jquery.datetimepicker.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
      <form method="post" name="insertAndEat" action="${contextPath}/andeat/insertAndOne.do" >
      	<input type="text" name="one_title" placeholder="제목을 입력해주세요">
      	<!-- 카테고리 -->
      	<div id="category" style="width:650px; margin: 0 auto">
				<c:forEach var ="ctg" items="${ctg_eat}" > 
				<button type="button" id="category_sub" class="btn btn-outline-dark mb-3" value="${ctg.gc_id}" >${ctg.gc_name}</button>
				</c:forEach>
		</div>
		<input type="hidden" name="one_category" value=""><br><br> <!-- 카테고리값 보내기 -->
		주문금액 <br><input type="text" name="one_totalPrice"><br>
		<!--달력 -->
		주문시간 <div id="demo7">
				<input name="one_date"/>		
			   </div>
			   <br>
	   <!-- 인원설정 -->
		인원 <select id="memberCnt" class="custom-select" onChange="setValue()" >
			<option selected >인원을 선택하세요</option>
			<c:forEach var="i" begin="2" end="10">
				<option value="<c:out value='${i}'/>"><c:out value="${i}"/></option>
			</c:forEach>
			 </select>
			 <input type="hidden" name="one_memberMax" value="">
			 <br><br>	 
		<!-- 지도 -->
        <button type="button" onclick="searchAddress()">위치선택하기</button><br><br>
        <input type="text" id="inputAddress" readonly><br><br>
        <div id="map" style="width:500px; height:400px"></div>
        <input type="hidden" name="one_locate" value=""><br> <!-- 맵 좌표값 보내기 -->
        <!-- 내용 -->
        <div class="form-group">
        	<label for="one_content"></label>
        	<textarea rows="15" cols="100" id="one_content" name="one_content"></textarea>
       	</div>
       	해쉬태그<br>
       	<input type="text" name="one_hashTag"><br><br>
       	<input type="hidden" name="one_type" value="${g_id}">
        <input type="submit" id="registerAndEat" value="새로운같이먹기 등록하기" >
    </form>
    
    <!--우편번호 서비스-->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!--kakao map-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11c6cd1eb3e9a94d0b56232e854a37b8&libraries=services"></script>
    <script>
    //MAP 시작 >>>>>>>>>>>>>>
        var container = document.getElementById("map"),
        	option = {
            center: new daum.maps.LatLng(37.570371, 126.985308), // 지도의 중심좌표 (위도,경도)
            level: 3
        };
       	//지도 생성
       	var map = new daum.maps.Map(container, option); 
		//주소-좌표 변환객체 
		var geocoder = new daum.maps.services.Geocoder();
        //마커 생성
        var marker = new daum.maps.Marker({
            position : new daum.maps.LatLng(37.570371, 126.985308),
            map: map
        });
        //위치선택클릭시 실행
        function searchAddress(){
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; //최종변수주소
                    console.log("addr:   "+addr)
                    
                    //주소정보 해당필드에 넣기
                    document.getElementById("inputAddress").value = addr;
                    //주소로 상세정보검색
                    geocoder.addressSearch(data.address, function(result, status) {
                    	//정상적으로 검색이 완료
                        if(status === daum.maps.services.Status.OK) {
                            var result = result[0]; // 첫번째 결과값을 활용
                            console.log(result)
                            
							//해당 주소에 대한 좌표를 받아서	
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            var locate = coords.toString();
                            console.log(coords);
                            console.log(locate);
							//지도에 보여준다
                            container.style.display = "block";
                            map.relayout();
                            //지도의 중심 변경
                            map.setCenter(coords);
                           	//마커를 결과값으로 받은 위치로 옮긴다
                            marker.setPosition(coords);

                            //hidden값으로  변수 one_locate에 좌표 전달
                            document.insertAndEat.one_locate.value = locate;
                        }
                    });
                }
            }).open();
        }
      //<<<<<<<<<<<< MAP 끝
      
      $(document).ready(function() {
	      //카테고리 버튼 클릭시 선택
    	  $('#category').on('click', '#category_sub' , function(e){
    		  $(this).addClass('active');
    		  $(this).siblings().removeClass('active');
    		  
    		  var category = $(this).val();
   			  //hidden값으로  변수 one_category에 전달
   			  console.log(category);
    		  document.insertAndEat.one_category.value = category;
    	  });
	      //달력
	      var $d7input = $('input', '#demo7').focus(function() {
                $('.dropdown', '#demo7').remove();
                var $dropdown = $('<div class="dropdown"/>').appendTo('#demo7');
                    $dropdown.datetimepicker({
                        date: $d7input.data('value') || new Date(),
                        viewMode: 'YMDHM',
                        onDateChange: function(){
                            //debugger;
                            $d7input.val(this.getText('YYYY-MM-DD hh:mm'));
                            $d7input.data('value', this.getValue());
                        },
                        //ok button click event
	  	    			 onOk: function() {
	  	    				 $dropdown.remove();
	  	    				 }
                    })
                });
			
            });
      	  //인원수 설정
	      function setValue(){
	    	  var cnt = $("#memberCnt").val();
		      console.log(cnt); 
		      document.insertAndEat.one_memberMax.value = cnt;//인원수 전달
	      }
    </script>
	
</body>
</html>