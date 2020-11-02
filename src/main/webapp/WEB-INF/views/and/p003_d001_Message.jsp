<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">

</head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

</style>
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<html>
<script>
var ws = null;
var url = null;

function connect(){
	ws = new Websocket(url);
	ws.onopen = function(){
		
	};
	ws.onmessage = function (event){
		
	};
	ws.onclose = function(event){
		
	};
}

function disconnect(){
	ws.close();
	ws = null;
}
function echo(){
	ws.send(message);
}

$(document).ready(function(){
	$("#sendBtn").click(function(){
		sendMessage();
	});
});

}
</script>
<body>
<div class="container py-5 px-4">
  
  <div class="row rounded-lg">
    <!-- Users box-->
    <div class="col-5 px-0" style="border:1px solid #c4c4c4;">
      <div class="bg-white">

        <div class="bg-gray px-4 py-2 bg-light">
          <p class="h5 mb-0 py-1" align="center">메시지</p>
        </div>

        <div class="messages-box">
          <div class="list-group rounded-0">
<!--             <a class="list-group-item list-group-item-action active text-white rounded-0"> -->
<!--               <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle"> -->
<!--                 <div class="media-body ml-4"> -->
<!--                   <div class="d-flex align-items-center justify-content-between mb-1"> -->
<!--                     <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">25 Dec</small> -->
<!--                   </div> -->
<!--                   <p class="font-italic mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </a> -->
          </div>
        </div>
      </div>
    </div>
    <c:set var="g_id" value="${g_id}" />	
    <c:set var="m_id" value="${m_id}" />
    <c:set var="one_title" value="${one_title}" />

      <!-- 기본 채팅방 -->
<!--            <div class="col-7 px-0" style="border:1px solid #c4c4c4;"> 
       <div class="px-4 py-5 bg-white">
		<div class="regular Message" align="center">
			<i class="far fa-comments fa-9x icon-a"></i>
			<br><br> 
			<h3 style="text-align: center;">내 메시지함</h3>
 			<h6 style="text-align: center; color : #a6a6a6"> 지금 우리 동네 &분의 일에 참여해보세요.</h6>
 		</div> 
      </div> 
      
   </div>  -->

 	  <!-- 채팅방 눌렀을 때-->
 	  <!-- 채팅 -->
     <div class="col-7 px-0"style="border:1px solid #c4c4c4;">
     <div class="bg-gray px-4 py-2 bg-light">
         <p class="h5 mb-0 py-1" align="left">
          	글제목(참여자 수)
<!--           	<i class="fas fa-info-circle"></i> -->
<svg aria-label="대화 상세 정보 보기" class="_8-yf5 " fill="#262626" height="24" viewBox="0 0 48 48" width="24">
<path d="M24 48C10.8 48 0 37.2 0 24S10.8 0 24 0s24 10.8 24 24-10.8 24-24 24zm0-45C12.4 3 3 12.4 3 24s9.4 21 21 21 21-9.4 21-21S35.6 3 24 3z"></path><circle clip-rule="evenodd" cx="24" cy="14.8" fill-rule="evenodd" r="2.6"></circle>
<path d="M27.1 35.7h-6.2c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5h6.2c.8 0 1.5.7 1.5 1.5s-.7 1.5-1.5 1.5z"></path><path d="M24 35.7c-.8 0-1.5-.7-1.5-1.5V23.5h-1.6c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5H24c.8 0 1.5.7 1.5 1.5v12.2c0 .8-.7 1.5-1.5 1.5z"></path></svg>
          	</p>
        </div>
      <div class="px-4 py-5 chat-box bg-white">
      </div>
      <!-- 여기서부터 채팅방 시작 -->
      
      
      <!-- 채팅방 끝  -->
      <!-- 타이핑 시작 -->
      <form action="#" class="bg-light">
        <div class="input-group">
          <input type="text" id="inputMessage" placeholder="내용을 입력하세요.." aria-describedby="button-addon2" class="form-control rounded-0 border-0 py-4 bg-light">
          <div class="input-group-append">
            <button id="button-addon2" type="submit" id="sendMessage" class="btn btn-link"> 
<!--              <i class="far fa-paper-plane"></i> -->
					보내기
            </button>
          </div>
        </div>
      </form>
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
      
  </div>
</div>
    </body>
    </html>