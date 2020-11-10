<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<!-- Perfect-DateTimePicker CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/jquery.datetimepicker.css"/>
	<!-- Perfect-DateTimePicker JS -->
	<script type="text/javascript" src="${contextPath}/resources/js/jquery.datetimepicker.js"></script>
	<!-- CKEDITOR-->
	<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>
	
	<style>
	.and{
		padding : 20px;
		font-family: 'YanoljaYacheR' !important;
		font-size: 70px;
		text-align: center;  
	}
	.ctgbutton{
		font-weight :bold;
	}
	#map{
		margin: 0 auto;
	}
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="g_id" value="${g_id}" />
		<h1 class="and text-primary mt-4">
			<c:choose>
				<c:when test="${g_id == '010'}">
					<img src="${contextPath}/resources/image/main/eat.png" width="100px" height="100px"> 같이먹기 수정하기
				</c:when>
				<c:when test="${g_id == '011'}">
					<img src="${contextPath}/resources/image/main/buy.png" width="100px" height="100px"> 같이사기 수정하기
				</c:when>
				<c:when test="${g_id == '012'}">
					<img src="${contextPath}/resources/image/main/do.png" width="100px" height="100px"> 같이하기 수정하기
				</c:when>
			</c:choose>
		</h1>
      <form method="post" name="modifyAnd" action="${contextPath}/and/modifyAndOne.do" onsubmit="return false" class="container my-5 center" style="width:600px">
     	<div class="form-group">
            <label>제목</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
   				<input type="text" class="form-control" name="one_title" placeholder="제목을 입력해주세요" value="${andOneEdit.one_title}">
      	</div>
      	<!-- 카테고리 -->
      	<div class="form-group">
      	<label>카테고리</label><div style="margin-bottom:10px;"></div><br>
      	<c:set var="g_id" value="${g_id}" />
      	<c:choose>
      		<c:when test="${g_id == '010'}">
		      	<div id="category" style="width:650px; margin: 0 auto">
						<c:forEach var ="ctg" items="${ctg}" > 
							<c:if test="${andOneEdit.one_category ne ctg.gc_name}">
								<button type="button" id="category_sub" class="btn btn-outline-primary mb-3 ctgbutton" value="${ctg.gc_id}" >${ctg.gc_name}</button>
							</c:if>
							<c:if test="${andOneEdit.one_category eq ctg.gc_name}">
								<button type="button" id="category_sub" class="btn btn-outline-primary mb-3 ctgbutton active" value="${ctg.gc_id}" >${ctg.gc_name}</button>
							</c:if>
						</c:forEach>
				</div>
			</c:when>
		</c:choose>
		<c:choose>
      		<c:when test="${g_id == '011'}">
		      	<div id="category" style="width:650px; margin: 0 auto; ">
						<c:forEach var ="ctg" items="${ctg}" > 
							<button type="button" id="category_sub" class="btn btn-outline-dark mb-3" value="${ctg.gc_id}" >${ctg.gc_name}</button>
						</c:forEach>
				</div>
			</c:when>
		</c:choose>
		<c:choose>
      		<c:when test="${g_id == '012'}">
		      	<div id="category" style="width:800px; margin: 0 auto">
						<c:forEach var ="ctg" items="${ctg}" > 
							<button type="button" id="category_sub" class="btn btn-outline-dark mb-3" value="${ctg.gc_id}" >${ctg.gc_name}</button>
						</c:forEach>
				</div>
			</c:when>
		</c:choose>
		<input type="hidden" name="one_category" value=""> <!-- 카테고리값 보내기 -->
		</div>
		<div class="form-group">
        	<label>주문금액</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
				<input type="text" class="form-control" name="one_totalPrice" placeholder="주문금액을 입력해주세요" value="${andOneEdit.one_totalPrice}">
		</div>
		<!--달력 -->
		<div class="form-group">
        	<div class="form-group" id="orderDate">
        	<label>주문시간</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
			<input name="one_date" class="form-control" placeholder="주문시간을 입력해주세요" value="${andOneEdit.forEditDate}" />
			</div>		
		</div>
	   <!-- 인원설정 -->
	   <div class="form-group">
	   	<label>인원</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
		 <select id="memberCnt" class="custom-select form-group" onchange = "setValue()" >
			<option value="">인원을 선택하세요</option>
				<c:forEach var="i" begin="2" end="10">
					<c:if test="${i ne andOneEdit.one_memberMax}">
						<option value="<c:out value='${i}'/>"><c:out value="${i}"/></option>
					</c:if>
					<c:if test="${i eq andOneEdit.one_memberMax}">
						<option value="${andOneEdit.one_memberMax}" selected>${andOneEdit.one_memberMax}</option>
					</c:if>
				</c:forEach>
			 </select>
			 <input type="hidden" name="one_memberMax" value="">
	   </div>
		<!-- 지도 -->
		<div class="form-group form-inline"> 
        		<button type="button" class="btn btn-outline-primary" onclick="searchAddress()">위치선택하기</button>
        		<input type="text" id="inputAddress" name ="one_addr" class="form-control col-9" placeholder="위치를선택해주세요" value="${andOneEdit.one_addr}" readonly><br>
     	</div>
    		<div id="map" class="mb-4" style="width:500px; height:250px"></div>
    		<input type="hidden" name="one_locate_Lat" value="">
    		<input type="hidden" name="one_locate_Lng" value=""> <!-- 맵 좌표값 보내기 -->
        <!-- 내용 -->
        <div class="form-group">
       		<textarea rows="10" id="one_content" class="form-control" name="one_content">${andOneEdit.one_content}</textarea>
       		<script>CKEDITOR.replace('one_content')</script>
       	</div>
       	<!-- 해쉬태그 -->
       <div class="form-group">
       		<label>해쉬태그</label><div class="displayArea" style="margin-bottom:10px;"></div>
			     <input type="text" class="form-control" id="inputHashtag" name="inputHashtag" 
			      placeholder="키워드 입력 후 스페이스바로 해시태그를 등록해주세요" onkeyup="characterCheck()" onkeydown="characterCheck()" />
    	</div>
	        	<c:choose>
				<c:when test="${g_id == '010'}">
	        		<input type="submit" id="modifyAnd" class="btn btn-primary rounded btn-block mb-3 form-control"  value="같이먹기 수정하기" >
				</c:when>
				<c:when test="${g_id == '011'}">
	        		<input type="submit" id="modifyAnd" class="btn btn-primary rounded btn-block mb-3 form-control"  value="같이사기 수정하기" >
				</c:when>
				<c:when test="${g_id == '012'}">
	        		<input type="submit" id="modifyAnd" class="btn btn-primary rounded btn-block mb-3 form-control"  value="같이하기 수정하기" >
				</c:when>
			</c:choose>
		       	<input type="hidden" name="one_type" value="${g_id}">
		       	<input type="hidden" name="one_id" value="${andOneEdit.one_id}">
		       	<input type="hidden" name="one_hashTag" id="one_hashTag">
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
                    console.log("addr:   "+addr);
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
                            var one_locate_Lat = coords.getLat();
                            var one_locate_Lng = coords.getLng()
                            
                            console.log(coords);
                            console.log(one_locate_Lat); //37
                            console.log(one_locate_Lng); //126
							//지도에 보여준다
                            container.style.display = "block";
                            map.relayout();
                            //지도의 중심 변경
                            map.setCenter(coords);
                           	//마커를 결과값으로 받은 위치로 옮긴다
                            marker.setPosition(coords);

                            //hidden값으로 변수 one_locate에 좌표 전달
                            document.modifyAnd.one_locate_Lat.value = one_locate_Lat;
                            document.modifyAnd.one_locate_Lng.value = one_locate_Lng;
                        }
                    });
                }
            }).open();
        }
        //수정시 주소로 좌표 표시
        geocoder.addressSearch("${andOneEdit.one_addr}", function(result, status) {
    		// 정상적으로 검색이 완료됐으면 
     		if (status === kakao.maps.services.Status.OK) {
     			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
     			// 결과값으로 받은 위치를 마커로 표시합니다
     			var marker = new kakao.maps.Marker({
     				map: map,
     				position: coords
     				});
     			map.setCenter(coords);
     			
     			//해당 주소에 대한 좌표를 받아서	
                var one_locate_Lat = coords.getLat();
                var one_locate_Lng = coords.getLng()
                
                console.log(coords);
                console.log(one_locate_Lat); //37
                console.log(one_locate_Lng); //126
				//지도에 보여준다
                container.style.display = "block";
                map.relayout();
                //지도의 중심 변경
                map.setCenter(coords);
               	//마커를 결과값으로 받은 위치로 옮긴다
                marker.setPosition(coords);

                //hidden값으로 변수 one_locate에 좌표 전달
                document.modifyAnd.one_locate_Lat.value = one_locate_Lat;
                document.modifyAnd.one_locate_Lng.value = one_locate_Lng;
     		}
        });
		//<<<<<<<<<<<< MAP 끝
		var hashtagArr = new Array();
		var hashtag = '';
      $(document).ready(function() {
    	  //수정용 해쉬태그
		  hashtag = "${andOneEdit.one_hashTag}";
		  console.log(hashtag);
		  hashtagArr = hashtag.split('#');
		  for(let i=0; i<hashtagArr.length; i++){
			 console.log(hashtagArr[i]);
			 $('.displayArea').append('<div class="btn-group mr-1 btn-group-sm" role="group">'
			 +'<button class="btn btn-sm btn-light">#'+hashtagArr[i]+'</button>'
			 +'<button id="'+hashtagArr[i]+'" class="btn btn-sm btn-light" onclick="deleteValue(this.id)">&times;</button>'+'</div>')
			 }
	      //카테고리 버튼 클릭시 선택
    	  $('#category').on('click', '#category_sub' , function(e){
    		  $(this).addClass('active');
    		  $(this).siblings().removeClass('active');
    		  
    		  //var category = $(this).val();
    		  var category = $(this).val();
   			  //hidden값으로  변수 one_category에 전달
   			  console.log(category);
    		  document.modifyAnd.one_category.value = category;
    	  });
	      //카테고리 수정
    	  var category = $(".active").val();
    	  console.log(category);
		  document.modifyAnd.one_category.value = category;
    	  
	      //달력
	      var $inputDate = $('input', '#orderDate').focus(function() {
                $('.dropdown', '#orderDate').remove();
                var $dropdown = $('<div class="dropdown"/>').appendTo('#orderDate');
                    $dropdown.datetimepicker({
                        date: $inputDate.data('value') || new Date(),
                        viewMode: 'YMDHM',
                        onDateChange: function(){
                            //debugger;
                            $inputDate.val(this.getText()); //24시간기준
                            $inputDate.data('value', this.getValue());
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
		      document.modifyAnd.one_memberMax.value = cnt;//인원수 전달
	      }
      	  //인원수 수정
    	  var category =  $("#memberCnt option:selected").val();
    	  console.log(category);
		  document.modifyAnd.one_memberMax.value = category;
		  
		//해쉬태그
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
		
		  //수정하기
		  $('#modifyAnd').click(function(){
			  hashtag = '';
				for(let i=0; i<hashtagArr.length; i++){
					hashtag += hashtagArr[i] + ','
				}
				hashtag = hashtag.slice(0,-1);
				$('#one_hashTag').val(hashtag);
				$('#inputHashtag').remove();
				
	    	  var modifyAnd = document.modifyAnd;
	    	  modifyAnd.action = "${contextPath}/and/modifyAndOne.do";
	    	  modifyAnd.method= "post";
	    	  modifyAnd.submit();
	    	  
	      })
      	  
    </script>
	
</body>
</html>