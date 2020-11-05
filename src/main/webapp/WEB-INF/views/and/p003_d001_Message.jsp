<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
<style>

::-webkit-scrollbar-track {
  width: 5px;
  background: #f5f5f5;
}

::-webkit-scrollbar-thumb {
  width: 1em;
  background-color: #ddd;
  outline: 1px solid slategrey;
  border-radius: 1rem;
}

.text-small {
  font-size: 0.9rem;
}

.messages-box {
  height: 510px;
  overflow-y: scroll;
}
.chat-box {
 height: 530px;
 overflow-y: scroll;
}

.chat-box2 {
 height: 530px;
}
.rounded-lg {
  border-radius: 0.5rem;
}

input::placeholder {
  font-size: 0.9rem;
  color: #;
}
.icon-a {
       color: #e3e3e3;
}

.centered {
    position: absolute;
    top:25%;
    left: 55%;
    transform: translate(-25%, 0);
    border:1px solid black;
    width:40%;
    height:auto;
    z-index:10;
    background-color: #ffffff;
}

div.border{
	border:1px solid black;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	
	var m_id = '${m_id }';
	var one_type = '';
	var one_id = '';
	
	$(document).ready(function(){
		$('.popUp').hide();
		getChatRoomList(m_id);
		$('.close').click(function(){
			$('.popUp').hide();
		})
	})
	
	function messageBoxClickEvent(){
		$('div.list-group').click(function(){
			one_id = this.id;
			one_type = $('input#'+this.id).val();
			getChatContent(one_id);
		})
	}
	
	//상세 신고기능 아직 미구현
	function userListClickEvent(){
		$('button.report').click(function(){
			var id = this.id;
			alert(id + ' 녀석을 신고해버리겠어');
		});
		$('td.userProfile').click(function(){
			openMemberPopup2(this.id);
		})
		
	}
	
	function openMemberPopup2(param){
		let m_id = param+'';
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	function getChatRoomList(m_id){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/message/getChatRoomList.do",
			dataType: "text",
			data: 'm_id='+m_id,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var chatRoom = "";
				var unoccupied = "";
				for(let i=0; i<Object.keys(jsonInfo).length; i++){
					if(jsonInfo[i].msg_date != 0){
						chatRoom += '<input type="hidden" id="'+jsonInfo[i].one_id+'" value="'+jsonInfo[i].one_type+'">';
						chatRoom += '<div class="list-group rounded-0" id="'+jsonInfo[i].one_id+'">';
						chatRoom += 	'<a class="list-group-item list-group-item-action list-group-item-light rounded-0">';
						chatRoom += 		'<div class="media">';
						chatRoom += 			'<i class="fas fa-users fa-2x fa-border"></i>';
						chatRoom += 			'<div class="media-body ml-4">';
						chatRoom += 				'<div class="d-flex align-items-center justify-content-between mb-1">';
						chatRoom += 					'<h6 class="mb-0">'+jsonInfo[i].one_title+'</h6>';
						chatRoom += 					'<small class="small font-weight-bold">'+jsonInfo[i].msg_date+'</small>';
						chatRoom += 				'</div>';
						chatRoom += 				'<p class="font-italic mb-0 text-small">'+jsonInfo[i].latestMessage+'</p>';
						chatRoom += 			'</div>';
						chatRoom += 		'</div>';
						chatRoom += 	'</a>';
						chatRoom += '</div>';
					}else{
						unoccupied += '<input type="hidden" id="'+jsonInfo[i].one_id+'" value="'+jsonInfo[i].one_type+'">';
						unoccupied += '<div class="list-group rounded-0" id="'+jsonInfo[i].one_id+'">';
						unoccupied += 	'<a class="list-group-item list-group-item-action list-group-item-light rounded-0">';
						unoccupied += 		'<div class="media">';
						unoccupied += 			'<i class="fas fa-users fa-2x fa-border"></i>';
						unoccupied += 			'<div class="media-body ml-4">';
						unoccupied += 				'<div class="d-flex align-items-center justify-content-between mb-1">';
						unoccupied += 					'<h6 class="mb-0">'+jsonInfo[i].one_title+'</h6>';
						unoccupied += 					'<small class="small font-weight-bold"></small>';
						unoccupied += 				'</div>';
						unoccupied += 				'<p class="font-italic mb-0 text-small">'+jsonInfo[i].latestMessage+'</p>';
						unoccupied += 			'</div>';
						unoccupied += 		'</div>';
						unoccupied += 	'</a>';
						unoccupied += '</div>';
					}
					
				}
				$('#messageBox').html(chatRoom);
				$('#messageBox').append(unoccupied);
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				messageBoxClickEvent();
			}
		})
	}
	
	function getChatContent(one_id){
		$.ajax({
			type: "post",
			async: true,
			url: "http://localhost:8090/andOne/message/getChatContentList.do",
			dataType: "text",
			data: 'one_id='+one_id,
			success: function (data, textStatus) {
				var jsonStr = data;
				var jsonInfo = JSON.parse(jsonStr);
				var chatContent = "";
				for(let i=0; i<Object.keys(jsonInfo).length; i++){
					if(jsonInfo[i].m_id == m_id){
						chatContent += "<div style='text-align:right;'>";
					}else{
						chatContent += "<div>";
					}
					chatContent += '['+jsonInfo[i].m_nickname+']';
					chatContent += '<br>';
					chatContent += jsonInfo[i].msg_content;
					chatContent += "</div>";
				}
				$('#messageArea').html(chatContent);
				autoScroll();
			},
			error: function (data, textStatus) {
				alert("에러가 발생했습니다.");
			},
			complete: function (data, textStatus) {
				
			}
		})
	}
	
	function getChatUserList(){
		if(one_id == null || one_id == '' || one_type == null || one_type == ''){
			alert('채팅목록을 먼저 선택해주세요');
		}else{
			$.ajax({
				type: "post",
				async: true,
				url: "http://localhost:8090/andOne/message/getChatUserList.do",
				dataType: "text",
				data: 'one_id='+one_id,
				success: function (data, textStatus) {
					var jsonStr = data;
					var jsonInfo = JSON.parse(jsonStr);
					var userList = "";
					userList += "<table class='table table-hover'>";
					for(let i=0; i<Object.keys(jsonInfo).length; i++){
						userList += "<tr>";
						userList += "<td class='userProfile' id='"+jsonInfo[i].m_id+"'>";
						if(jsonInfo[i].m_encodedImg == null || jsonInfo[i].m_encodedImg == ''){
							userList += "<img src='${contextPath }/resources/image/user.png' width='50px' alt='....' class='img-circle'>";
						}else{
							userList += "<img src='data:image/jpg;base64,"+jsonInfo[i].m_encodedImg+"' width='50px' alt='....' class='img-circle'>";
						}
						userList += "</td>";
						userList += "<td>";
						userList += "<h5>";
						userList += jsonInfo[i].m_nickname;
						userList += "</h5>";
						userList += "</td>";
						userList += "<td>";
						userList += "<button type='button' id='"+jsonInfo[i].m_id+"' class='btn btn-danger btn-sm report'>신고";
						userList += "</button>";
						userList += "</td>";
						userList += "</tr>";
					}
					userList += "</table>";
					$('.popContent').html(userList); //toDo 레이어 만들고 거기에 넣기
					userListClickEvent();
					$('.popUp').show();
				},
				error: function (data, textStatus) {
					alert("에러가 발생했습니다.");
				},
				complete: function (data, textStatus) {
					
				}
			})
		}
	}
	
	function sendMessage(){
		var messageText = $('input#message').val();
		if(messageText == null || messageText == ''){
			alert('내용을 입력해주세요');
		}else{
			if(one_id == null || one_id == '' || one_type == null || one_type == ''){
				alert('채팅목록을 먼저 선택해주세요');
			}else{
				$.ajax({
					type: "post",
					async: true,
					url: "http://localhost:8090/andOne/message/insertChatContent.do",
					dataType: "text",
					data: 'one_id='+one_id+'&one_type='+one_type+'&m_id='+m_id+'&msg_content='+messageText,
					success: function (data, textStatus) {
						m_sock.send(data);
					},
					error: function (data, textStatus) {
						alert("에러가 발생했습니다.");
					},
					complete: function (data, textStatus) {
						$('input#message').val('');
					}
				})
			}
		}
	}
	//요소 추가시 스크롤 아래로 고정
	function autoScroll(){
		var objDiv = document.getElementById("messageArea"); 
		objDiv.scrollTop = objDiv.scrollHeight;
	}
	//엔터키 입력 체크 함수
	function enterkey() {
        if (window.event.keyCode == 13) {
        	sendMessage();
        }
	}


	// 웹소켓 파트
	var m_sock = new SockJS("${contextPath }/chat-ws/");
		m_sock.onmessage = m_onMessage;
		m_sock.onclose = m_onClose;
	
	//메세지 받았을 때
	function m_onMessage(msg){
		var data = msg.data;
		console.log(data);
		var jsonStr = data;
		var jsonInfo = JSON.parse(jsonStr);
		if(jsonInfo.one_id == one_id){
			console.log('보고 있는 채팅방');
			var chatContent = '';
			if(jsonInfo.m_id == m_id){
				console.log('내 채팅');
				chatContent += "<div style='text-align:right;'>";
			}else{
				console.log('남의 채팅');
				chatContent += "<div>";
			}
			chatContent += '['+jsonInfo.m_nickname+']';
			chatContent += '<br>';
			chatContent += jsonInfo.msg_content;
			chatContent += "</div>";
			$('#messageArea').append(chatContent);
			autoScroll();
		}else{
			console.log('안보고 있는 채팅방');
		}
		getChatRoomList(m_id);
		
	}
	
	//연결 종료
	function m_onClose(){
		  
	}

</script>
</head>
<body>
<div class="container py-5 px-4">
  
  <div class="row rounded-lg">
    <!-- Users box-->
    <div class="col-5 px-0" style="border:1px solid #c4c4c4">
      <div class="bg-white">

        <div class="bg-gray px-4 py-2 bg-light">
          <p class="h5 mb-0 py-1" align="center">메시지</p>
        </div>
		
		<!-- 채팅방 목록 -->
        <div class="messages-box" id="messageBox">

        </div>
      </div>
    </div>	

      <!-- 기본 채팅방 -->
<!--             <div class="col-7 px-0" style="border:1px solid #c4c4c4;"> 
       <div class="px-4 py-5 bg-white">
		<div class="regular Message" align="center">
			<i class="far fa-comments fa-9x icon-a"></i>
			<br><br> 
			<h3 style="text-align: center;">내 메시지함</h3>
 			<h6 style="text-align: center; color : #a6a6a6"> 지금 우리 동네 &분의 일에 참여해보세요.</h6>
 		</div> 
      </div> 
      
   </div> --> 
   <!-- 기본 채팅방 끝 -->

 	  <!-- 채팅방 눌렀을 때-->
 	  <!-- 채팅 -->
     <div class="col-7 px-0"style="border:1px solid #c4c4c4;">
     <div class="bg-gray px-4 py-2 bg-light">
         <p class="h5 mb-0 py-1" align="left">
          	참여자 정보
<!--            	<i class="fas fa-info-circle"></i>  -->
 <svg onclick="getChatUserList()" aria-label="대화 상세 정보 보기" class="_8-yf5 " fill="#262626" height="24" viewBox="0 0 48 48" width="24" font-size="1rem">
<path d="M24 48C10.8 48 0 37.2 0 24S10.8 0 24 0s24 10.8 24 24-10.8 24-24 24zm0-45C12.4 3 3 12.4 3 24s9.4 21 21 21 21-9.4 21-21S35.6 3 24 3z"></path><circle clip-rule="evenodd" cx="24" cy="14.8" fill-rule="evenodd" r="2.6"></circle>
<path d="M27.1 35.7h-6.2c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5h6.2c.8 0 1.5.7 1.5 1.5s-.7 1.5-1.5 1.5z"></path><path d="M24 35.7c-.8 0-1.5-.7-1.5-1.5V23.5h-1.6c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5H24c.8 0 1.5.7 1.5 1.5v12.2c0 .8-.7 1.5-1.5 1.5z"></path></svg>
           	</p>
        </div>
<!--       여기서부터 채팅방 시작-->
      <div class="px-4 py-5 chat-box bg-white"  id="messageArea">
      
      </div>
      
    <!-- 채팅방 끝 ->
      <!--타이핑 시작 -->
      <div id="messageForm" class="bg-light">
        <div class="input-group">
          <input onkeyup="enterkey()" type="text" id="message" placeholder="내용을 입력하세요.." aria-describedby="button-addon2" class="form-control rounded-0 border-0 py-4 bg-light">
          <div class="input-group-append">
            <button type="button" id="sendBtn" class="btn btn-link" onclick="sendMessage()"> 
<!--              <i class="far fa-paper-plane"></i> -->
					보내기
            </button>
          </div>
        </div>
      </div>
      </div> 
      <!-- 타이핑 끝 -->
      <!-- 채팅방 눌렀을 때 끝-->
      
      
      <!-- 채팅방 인포 눌렀을 때 -->
     <%--  <div class="col-7 px-0" style="border:1px solid #c4c4c4;">
     <div class="bg-gray px-4 py-2 bg-light">
         <p class="h5 mb-0 py-1" align="center">
         상세정보
<!--           	<i class="fas fa-info-circle"></i> -->
<svg aria-label="상세 정보" id="messageInfo" class="_8-yf5 " fill="#262626" height="24" viewBox="0 0 48 48" width="24">
<path d="M24 0a24 24 0 1024 24A23.94 23.94 0 0024 0zm0 12.3a2.58 2.58 0 012.6 2.6 2.52 2.52 0 01-2.6 2.6 2.6 2.6 0 010-5.2zm3.1 23.4H21a1.5 1.5 0 010-3h1.5v-9.2H21a1.5 1.5 0 010-3h3a1.54 1.54 0 011.5 1.5v10.7H27a1.54 1.54 0 011.5 1.5 1.34 1.34 0 01-1.4 1.5z"></path></svg>
          	</p>
        </div>
      <div class="px-4 py-5 bg-white">
      <h4>멤버</h4>
      <br>
      <h5>아이디로 표시  </h5>
       ${m_id}	<!-- 나임 ㅋㅋ --><br>
      <h5> 닉네임표시 </h5> ${m_nickname}
      </div>
      <div id="outMessage" style="border:1px solid #c4c4c4; height:40px;">
      <button id="button-addon2" type="submit" id="exitMessage" class="btn btn-link""> 채팅 나가기</button>
<!--       </div> -->
      </div>
      </div> --%>
      <!-- 채팅방 인포 누르기 끝 -->
  <div class="popUp centered">
	   <div class="bg-gray px-4 py-2 bg-light">
	  	<div class="close">닫기</div>
	  	<p class="h5 mb-0 py-1" align="center">
	  	 유저정보
	  	</p>
		</div>
	  	<div class="px-4 py-5 bg-white popContent">
	  	
	  	</div>
<!-- 	  	<div class="close">닫기</div> -->
  </div>  
  
  
  
    
  </div>
  </div>
    </body>
    </html>