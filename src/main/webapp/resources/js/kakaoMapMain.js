	//kakao api
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	 mapOption = { 
	     center: new kakao.maps.LatLng(37.570371, 126.985308), // 지도의 중심좌표
	     level: 4 // 지도의 확대 레벨 
	 }; 
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	// 마커를 생성합니다
    var marker = new kakao.maps.Marker({
		map: map	
	}); 
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	// 현재위치 좌표값
	var locPosition;
	
	// m_id가 있을 때만
	if(m_id!=null && m_id!=''){
		$.ajax({
            type: "post",
            async: "true",
            dataType: "text",
            data: {
                id: m_id
                //data로 넘겨주기
            },
            url: "/andOne/member/selectLocate.do",
            success: function (data, textStatus) {
            	if(data=='0'){	// 회원가입 초기값
            		locPosition = new kakao.maps.LatLng(37.570371, 126.985308)    // 기본위치 set
           			displayMarker(locPosition);
        			var infoDiv = document.getElementById('centerAddr');
        			document.getElementById('centerAddr').innerHTML = '저장된 위치가 없습니다.';
            	}else if(data!='' || data!=null){
            		//db에 저장된 위도,경도 값
            		let oridata = data+"";
            		// (+1 부터  ,앞까지 slice
            		let x = oridata.slice(1,oridata.indexOf(","));
            		// ,뒤부터 )-1까지 slice
            		let y = oridata.slice(oridata.indexOf(",")+1,oridata.length-1);
            		locPosition = new kakao.maps.LatLng(x, y);	// 자른 값으로 객체 생성
            		displayMarker(locPosition);
            		searchAddrFromCoords(locPosition, displayCenterInfo);
            	}
            }
		});
	}
	
	document.getElementById('selectGeoLocation').addEventListener("click", function(){
		 //HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		 if (navigator.geolocation) {
		 	// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		 	navigator.geolocation.getCurrentPosition(function(position) {
		 		var lat = position.coords.latitude, // 위도
		 			lon = position.coords.longitude; // 경도
		 		// 현재위치 좌표값
		 		locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		 		// 마커설정
		 		displayMarker(locPosition);
		 		// 행정동 주소정보 요청 및 메인 set
		 		searchAddrFromCoords(map.getCenter(), displayCenterInfo)
		 	});
		 } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		 	locPosition = new kakao.maps.LatLng(37.570371, 126.985308)    // 기본위치 set
		 	displayMarker(locPosition, message);
		 }	
	});
	
	//지도에서 위치선택 - 적용클릭
	document.getElementById('setAddr').addEventListener("click", function(){
		// 행정동 주소정보 요청 및 메인 set
		searchAddrFromCoords(locPosition, displayCenterInfo);
		map.setCenter(locPosition);
		
		// locPosition을 ajax로 저장
		var m_locate = locPosition.toString();
		$.ajax({
            type: "post",
            async: "true",
            dataType: "text",
            data: {
                id: m_id,
                locate: m_locate
                //data로 넘겨주기
            },
            url: "/andOne/member/saveLocation.do",
            success: function (data, textStatus) {
            }
		});
	});


	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition) {
	    marker.setPosition(locPosition);
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);   
	    
	}  
	
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		searchAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
				var infoDiv = document.getElementById('selectedAddr');
				for(var i = 0; i < result.length; i++) {
					// 행정동의 region_type 값은 'H' 이므로
					if (result[i].region_type === 'H') {
						infoDiv.innerHTML = result[i].address_name;
						break;
					}
				}
	            // 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	            // 클릭한 위치를 center로 등록
	            locPosition = mouseEvent.latLng;
	            
	        }   
	    });
	});
	
	function searchAddrFromCoords(coords, callback) {
		// 좌표로 행정동 주소 정보를 요청합니다
		geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
	// 메인에 주소정보 set
	function displayCenterInfo(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var infoDiv = document.getElementById('centerAddr');
			var infoDiv2 = document.getElementById('selectedAddr');
			for(var i = 0; i < result.length; i++) {
				// 행정동의 region_type 값은 'H' 이므로
				if (result[i].region_type === 'H') {
					infoDiv.innerHTML = result[i].address_name;
					infoDiv2.innerHTML = result[i].address_name;
					break;
				}
			}
		} 
	}   
	
