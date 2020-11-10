<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.left, .right{
	display: inline-block;
	margin: 0;
}

.side{
/* 	display: relative; */
/* 	position:absolute; */
	margin-left:20px;
	width: 395px;
}

.left {
/* 	margin-top: 100px; */
	top: 100px;
	width:220px;
}

.right {
	margin-left: 20px;
}
.side,.left,.right{
	margin-top: 50px;
}

.card-title,.card-subtitle {
	display: inline-block;
	margin-left: 10px;
}

.art-title {
	width: 330px;
}

.pin {
	display: contents;
	width: 30px;
	position: absolute;
	top: 20px;
	right: 40px;
}

.card-subtitle {
	margin-top: 10px;
}

.bi-bookmark-star-fill ,.side{
	fill: #ffcc00;
	display: inline-block;
}

.sub {
	display: none;
}

.tap {
	cursor: pointer;
}

.ca_img {
	height: 100%;
	width: 100%;
	object-fit: contain;
}

.c_img {
	height: 100%;
	width: 100%;
	object-fit: cover;
	height: 270px 
}

.aa {
	display: none;
}
.art-title{
	cursor:pointer;
}
.userImg {
	position: relative;
	border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	width: 60px;
	height: 60px;
	cursor:pointer;
}

.card-img-top{
	height: 230px;
    object-fit: cover;
}
.r_userImg,.r_replyUserImg {
	position: relative;
	border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	width: 45px;
	height: 45px;
	cursor : pointer;
}
.r_replyUserImg{
	margin-left:58px;
}

.userListImg{
	position: relative;
	border-radius: 30px;
	-moz-border-radius: 30px;
	-khtml-border-radius: 30px;
	-webkit-border-radius: 30px;
	width: 55px;
	height: 55px;
	margin-bottom:5px;
}
.bi-file-earmark-lock-fill,.c{
	margin:auto;
}
.btn-success:hover, .set:hover {
    background-color: #00033D !important;
}
.btn-success{
	background-color:#002A87 !important;
	border-color:#002A87;
	color:white;
}
.reportTXT{
	display:none;
}

  .swiper-container {
      width: 100%;
      height:auto;
    }
    .swiper-container .swiper-slide {
      height: 300px;
      line-height: 300px;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;

      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }
    
.re_comment{
	display:none;
}
.secret,.article,.clubInfo{
	width:650px;
}
 .none{display:none}   
 
#wrapper{
	margin : 0 auto;
}
</style>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

  <!-- Link Swiper's CSS -->
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script type="text/javascript">
(function () {
	if(${rank} == 99){
		alert('강퇴된 소모임입니다.');
		history.back();
	}
})();

	function deleteArticle(c_id,ca_id){
		if (window.confirm("게시글을 삭제하시겠습니까?")) { 
			$.ajax({
				type: "get",
				dataType: "text",
				async: true,
				url:"${contextPath}/club/deleteClubArticle.do?ca_id="+ca_id+"&c_id="+c_id,
				success: function(data){
					location.reload();
				}
						
			});
			location.reload();
		}
	}
	
	// 회원가입
	function joinClub(c_id){
		var form = $(".intro")[0];
		var formData = new FormData(form);
		
		$.ajax({
			cache : false,
            url : "${contextPath}/club/joinClub.do?c_id="+c_id,
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData, 
            success : function(data) {
            	// 알림전송
            	// 소모임 이름 조회
            	let type = '40';	// 소모임
				let url = '/andOne/club/waitMemberList.do?c_id='+c_id;
				$.ajax({
					type: 'post',
					url: '/andOne/selectClubName.do',
					dataType: 'text',
					data: {	c_id: c_id	},
					success: function(data){
						// 소모임명 저장
						var content = '[' + data +'] 소모임 가입신청이 들어왔습니다.';
						// 소모임 장 조회
						$.ajax({
							type: 'post',
							url: '/andOne/selectClubManager.do',
							dataType: 'text',
							data: { c_id: c_id	},
							success: function(data){
								var target = data;	// 클럽장 아이디
								// db저장	
								$.ajax({
									type: 'post',
									url: '/andOne/member/saveNotify.do',
									dataType: 'text',
									data: {
										target: target,	content: content, type: type, url: url
									},
									success: function(){
										socket.send("소모임,"+target+","+content+","+url);	// 소켓에 전달
									}
								});
							}
						});

					}
				});
            	
                location.reload();
            },
            error:function(data){
            	alert("error");
            }
		});
	}
	let today = new Date();   

	let hours = today.getHours(); // 시
	let minutes = today.getMinutes();  // 분
	hours = hours > 10 ? hours : "0" + hours;
	minutes = minutes > 10 ? minutes : "0" + minutes;
	let sysdate = hours + ':' + minutes;
	//댓글 쓰기
	function insertReply(ca_id){
		const car_content = document.getElementById('comment'+ca_id).value;
		if(car_content == ''){
			alert('내용을 입력해주세요.');
			return;
		}
		document.getElementById('comment'+ca_id).value="";
		$.ajax({
			url:"${contextPath}/club/insertReply.do?ca_id"+ca_id,
			type : "get",
			async: true,
			data : {ca_id:ca_id,car_content:car_content},
			success : function(data,textStatus){
				var jsonInfo =JSON.parse(data);
				var output ="";
				output += "<div class='p-2 mt-3' style='padding-left:0px !important;' id='pack"+jsonInfo.car_id+"'>";
				output += "<div class='d-flex'>";
				output += "<div class=''>";
				if("${profileImg}" != ""){
					console.log("zz");
					output += "<img src='data:image/jpg;base64, ${profileImg}' class='r_userImg' onclick='openMemberPopup2('${m_id}');'>";
				} else {
					output += "<img src='${contextPath}/resources/image/user.png' class='r_userImg' onclick='openMemberPopup2('${m_id}');'>";
				}
				output += "</div>";
				output += "<div class='flex-grow-1 pl-2'>";
				output += "<a class='text-decoration-none text-capitalize h6 m-0'  href='javascript:void(0);' onclick='openMemberPopup2('${m_id}');'>${m_nickname}</a>";
				output += "<p class='small m-0 text-muted edit${ca_reply.car_id}'>"+sysdate+"</p></div>";
				output += "<a href='javascript:void(0);' onclick='re_reply("+jsonInfo.car_id+","+ca_id+");' style='margin-right:5px;size:8px;'>답글</a>";
				output += "<div>";
				output += "<div class='dropdown'>";
				output += "<a class='' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
				output += "<i class='fas fa-chevron-down'></i>";
				output += "</a>";
				output += "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink'>";
				output += "<a class='dropdown-item text-primary' onclick='editReplyInput("+jsonInfo.car_id+",'"+car_content+"'');'>수정</a>";
				output += "<a class='dropdown-item text-primary' onclick='deleteReply("+jsonInfo.car_id+");'>삭제</a>";
				output += "</div></div></div><br></div>";
				output += "<div class='card-body p-0' id='edit"+jsonInfo.car_id+"'>";
				output += "<p class='card-text h7 mb-1' id='content"+jsonInfo.car_id+"' style='margin-left:53px;'>"+car_content+"</p></div></div>";
				output += "<div><div class='input-group input-group' id='re_reply"+jsonInfo.car_id+"' style='display:none;margin-top:8px;'>";
				if("${profileImg}" != ""){
					console.log("zz");
					output += "<img src='data:image/jpg;base64, ${profileImg}' class='r_userImg' onclick='openMemberPopup2('${m_id}');'>";
				} else {
					output += "<img src='${contextPath}/resources/image/user.png' class='r_userImg' onclick='openMemberPopup2('${m_id}');'>";
				}
				output += "<input type='text' style='margin-left:10px;margin-top:5px;' id='re_comment"+jsonInfo.car_id+"' class='form-control' placeholder='Write Comment' aria-label='Recipient's username' aria-describedby='basic-addon2'>";
				output += "<div class='input-group-append'>";
				output += "<a class='text-decoration-none text-white btn btn-primary' style='height:38px;margin-top:5px;' href='javascript:void(0);' onclick='insertRe_reply("+ca_id+","+jsonInfo.car_id+");' role='button'>Comment</a>";
				output +="</div></div>";
				$('#sectionReply'+ca_id).append(output);
			},
			error:function(data,textStatus){
				alert("error");
			}
		});
	}
	
	function deleteReply(car_id){
		if (window.confirm("댓글을 삭제하시겠습니까?")) { 
			$.ajax({
				url:"${contextPath}/club/deleteReply.do",
				type : "get",
				data : {car_id : car_id},
				async: true,
				success : function(data){
					$('#pack'+car_id).remove();
				},
				error : function(data,textStatus){
					alert("error");
				}
			})
		}
	}
	// 신고하기 연결
	function openReportPopup(){
		var popupOpener;
		popupOpener = window.open("${contextPath}/member/reportInit.do?target=${clubInfo.c_id}&flag=club", "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	function re_reply(car_id,ca_id){
		$('#re_reply'+car_id).slideToggle();
	}
	
	function insertRe_reply(ca_id,car_id){
		console.log(ca_id);
		console.log(car_id);
		var re_car_content = document.getElementById('re_comment'+car_id).value;
		re_car_content = re_car_content + "";
		console.log(re_car_content);
		document.getElementById('re_comment'+car_id).value ="";
		$.ajax({
			url:"${contextPath}/club/insertReply.do?ca_id"+ca_id,
			type : "get",
			async: true,
			data : {ca_id:ca_id,car_content:re_car_content,p_car_id:car_id},
			success : function(data){
				
				var jsonInfo =JSON.parse(data);
				var output ="";
				output += "<div class='p-2' style='margin-left:50px;' id='pack"+jsonInfo.car_id+"'>";
				output += "<div class='d-flex'>";
				output += "<div class=''>";
				if("${profileImg}" != ""){
					console.log("zz");
					output += "<img src='data:image/jpg;base64, ${profileImg}' class='r_userImg' onclick='openMemberPopup2('${m_id}');'>";
				} else {
					output += "<img src='${contextPath}/resources/image/user.png' class='r_userImg'  onclick='openMemberPopup2('${m_id}');'>";
				}
				output += "</div>";
				output += "<div class='flex-grow-1 pl-2'>";
				output += "<a class='text-decoration-none text-capitalize h6 m-0'  href='javascript:void(0);' onclick='openMemberPopup2(${m_id});'>${m_nickname}</a>";
				output += "<p class='small m-0 text-muted edit${ca_reply.car_id}'>"+sysdate+"</p></div>";
// 				output += "<a href='javascript:void(0);' onclick='re_reply("+jsonInfo.car_id+","+ca_id+");' style='margin-right:5px;size:8px;'>답글</a>";
				output += "<div>";
				output += "<div class='dropdown'>";
				output += "<a class='' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
				output += "<i class='fas fa-chevron-down'></i>";
				output += "</a>";
				output += "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink'>";
				output += "<a class='dropdown-item text-primary' onclick='editReplyInput("+jsonInfo.car_id+",'"+re_car_content+"');'>Edit</a>";
				output += "<a class='dropdown-item text-primary' onclick='deleteReply("+jsonInfo.car_id+");'>삭제</a>";
				output += "</div></div></div><br></div>";
				output += "<div class='card-body p-0' id='edit"+jsonInfo.car_id+"'>";
				output += "<p class='card-text h7 mb-1' id='content"+jsonInfo.car_id+"' style='margin-left:53px;'>"+re_car_content+"</p></div></div>";
				output += "<div><div class='input-group input-group' id='re_reply"+jsonInfo.car_id+"' style='display:none;margin-top:8px;'>";
				if("${profileImg}" != ""){
					console.log("zz");
					output += "<img src='data:image/jpg;base64, ${profileImg}' class='r_userImg' onclick='openMemberPopup2(${m_id});'>";
				} else {
					output += "<img src='${contextPath}/resources/image/user.png' class='r_userImg' onclick='openMemberPopup2(${m_id});'>";
				}
				output += "<input type='text' style='margin-left:10px;margin-top:5px;' id='re_comment"+jsonInfo.car_id+"' class='form-control' placeholder='Write Comment' aria-label='Recipient's username' aria-describedby='basic-addon2'>";
				output += "<div class='input-group-append'>";
// 				output += "<a class='text-decoration-none text-white btn btn-primary' style='height:38px;margin-top:5px;' href='javascript:void(0);' onclick='insertRe_reply("+ca_id+","+jsonInfo.car_id+");' role='button'>Comment</a>";
				output +="</div></div>";
				$('#collapseExample'+car_id).append(output);
				
				
				
// 				location.reload();
			},
			error:function(data,textStatus){
				alert("error");
			}
		})
	}
	
	function editReplyInput(car_id,car_content){
		var content = document.getElementById("content"+car_id);
		content.style.display = "none";
		var date = document.getElementsByClassName("edit"+car_id)[0];
		date.style.display = "none";
		console.log(car_content);
		let output = "<div class='input-group input-group editInput' style='margin-left:50px;width:95%;'>"
		+"<input type='text' id='editComment"+car_id+"' class='form-control' aria-label='Recipient's username' aria-describedby='basic-addon2'>"
		+"<div class='input-group-append'>"
		+"<a class='text-decoration-none text-white btn btn-primary' href='javascript:void(0);' onclick='editReply("+car_id+");' role='button'>수정</a>"
		+"</div></div>";
		$('#edit'+car_id).append(output);
		$('#editComment'+car_id).val(car_content);
	}
	
	function editReply(car_id){
		console.log(car_id);
		const edit_content = document.getElementById('editComment'+car_id).value;
		console.log(edit_content);
		$.ajax({
			url:"${contextPath}/club/editReply.do",
			type : "get",
			async : true,
			data : {car_id : car_id , car_content:edit_content},
			success: function(data){
				var date = document.getElementsByClassName("edit"+car_id)[0];
				date.style.display = "block";
				const content = document.getElementById('content'+car_id);
				content.style.display = "block";
				$('.editInput').remove();
				$('#content'+car_id).html(edit_content);
			},
			error:function(data){
				alert("error");
			}
		})
		
	}
	
	function editPin(ca_id,ca_pin){
		$.ajax({
			url:"${contextPath}/club/editPin.do",
			type:"post",
			async:true,
			data : {ca_id:ca_id,ca_pin:ca_pin},
			success:function(data){
				location.reload();
			},
			error:function(data){
				alert("error");
			}
		})
	}
	
	function openMemberPopup2(m_id){
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
	
	function moreAndOnd(){
		$('.none').slideToggle();
// 		$('.none').removeClass('none');
	}
</script>
</head>
<body>
<!-- 	소모임 카드 -->
	<div class="mx-auto" style="width:fit-content;">
		<div class="left align-top position-sticky">
			<div class="card info">
			<c:set var="c_img" value="${clubImg}"/>
				<c:choose>
					<c:when test="${c_img eq ''}">
						<img src="https://cdn.pixabay.com/photo/2014/07/08/10/47/team-386673_1280.jpg" class="card-img-top" alt="...">
					</c:when>
					<c:otherwise>
						<img src="data:image/jpg;base64, ${c_img}" class="c_img">
					</c:otherwise>
				</c:choose>
				<div class="card-body">
					<h5 class="card-title" style="margin-left:0px;">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt}</p>
					<c:if test="${clubInfo.c_hashtag ne null}">
						<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
					</c:if>
					<br>
					<span class="text-muted m-0 text-muted"><small>시작한 날 ${clubInfo.c_openingdate}</small></span>
					<c:set var="cm_rank" value="${rank}"/>
						<c:choose>
							<c:when test="${rank eq 10}">
								<a href="${contextPath}/club/writeArticleForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">글쓰기</a>
								<div class="btn-group btn-block" role="group">
								<button id="btnGroupDrop1" type="button"
									class="dropdown-toggle btn btn-success"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">소모임 관리</button>
								<div class="dropdown-menu btn btn-success btn-block set" aria-labelledby="btnGroupDrop1">
									<a class="dropdown-item set" href="${contextPath}/club/waitMemberList.do?c_id=${clubInfo.c_id}" style="color:white;">요청승인하기</a> 
									<a class="dropdown-item set" href="${contextPath}/club/updateClubForm.do?c_id=${clubInfo.c_id}" style="color:white;">소모임 수정하기</a>
									<button data-target="#staticBackdrop2" class="dropdown-item set" data-toggle="modal" style="color:white;">소모임 삭제하기</button>
								</div>
							</div>
							</c:when>
							<c:when test="${rank eq 20 or rank eq 30}">
								<a href="${contextPath}/club/writeArticleForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">글쓰기</a>
							</c:when>
							<c:when test="${rank eq 40}">
								<a href="#" class="btn btn-success btn-block"
									style="margin-top: 3px;">가입승인 대기중</a>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-success btn-block"
									style="margin-top: 3px;" data-toggle="modal" data-target="#introModal">함께하기</button>
							</c:otherwise>
						</c:choose>
				</div>
			</div>
		</div>
		<div class="right align-top">
			<div class="card clubInfo">
				<div class="card-header">${clubInfo.c_name }</div>
				<div class="card-body">
					<h5>${clubInfo.c_content }</h5>
				</div>
			</div>

			<!--소모임 게시글  -->
			<c:choose>
			<c:when test="${rank eq 10 or rank eq 20 or rank eq 30 or m_id eq '00000001'}">
			<c:forEach var="club" items="${clubInfo.articleList}">
				<div class="card article" style="height: auto;margin-top:20px;">
					<div class="card-body" style="height: auto">
					<c:set var="ca_pin" value="${club.ca_pin}" />
						<c:choose>
							<c:when test="${ca_pin eq 1}">
								<div class="pin">
									<svg width="3em" height="2.2em" viewBox="0 0 16 16"
										class="bi bi-bookmark-star-fill" fill="currentColor"
										xmlns="http://www.w3.org/2000/svg">
  										<path fill-rule="evenodd"
											d="M4 0a2 2 0 0 0-2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4zm4.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098L8.16 4.1z" />
									</svg>
									공지사항
								</div>
								<br><br>
							</c:when>
						</c:choose>
						<c:set var="logOnId" value="${m_id}" />
						<c:set var="writer" value="${club.m_id}" />
<!-- 						게시글 작성자 수정 / 삭제 -->
						<c:if test="${logOnId eq writer}">
						<div class="dropdown" style="float:right">
							<a class="" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-chevron-down"></i>
							</a>

							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item text-primary" href="${contextPath}/club/editClubArticleForm.do?ca_id=${club.ca_id}&&c_id=${clubInfo.c_id}">수정</a>
								<a class="dropdown-item text-primary" href="javascript:void(0);" onclick="deleteArticle(${clubInfo.c_id},${club.ca_id})">삭제</a>
								<c:if test="${club.ca_pin eq 1 and rank eq 10}">
									<a class="dropdown-item text-primary" onclick="editPin(${club.ca_id},0)">공지사항 내리기</a>
								</c:if>
								<c:if test="${club.ca_pin eq 0 and rank eq 10}">
									<a class="dropdown-item text-primary" onclick="editPin(${club.ca_id},1)">공지사항 올리기</a>
								</c:if>
							</div>
						</div>
						</c:if>
				<c:set var="m_img" value="${club.resultUserImg}"/>
				<div class="row mx-2">
					<c:choose>
						<c:when test="${m_img ne null}">
							<img src="data:image/jpg;base64, ${club.resultUserImg}" class="userImg" onclick="openMemberPopup2('${club.m_id}');">
						</c:when>
						<c:otherwise>
								<img src="${contextPath}/resources/image/user.png" class="userImg" onclick="openMemberPopup2('${club.m_id}');">
						</c:otherwise>
					</c:choose>
					<div class="ml-2">
						<h5 class="art-title mb-1" onclick="openMemberPopup2('${club.m_id}');">${club.m_nickname}</h5>
						<h6 class="mb-2 text-muted">${club.ca_date}</h6>
					</div>
				</div>
						<div class="card-text m-3">${club.ca_content}</div>
						<div class="swiper-container" style="margin-bottom:20px;">
						<div class="swiper-wrapper">
						<c:set var="ca_img" value="${club.articleImgList}" />
							<c:forEach var="ca_img" items="${club.articleImgList}">
								<c:if test="${ca_img.resultArticleImg ne null}">
									<div class="swiper-slide">
										<img src="data:image/jpg;base64, ${ca_img.resultArticleImg}" class="ca_img">
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- Add Pagination -->
					    <div class="swiper-pagination"></div>
					    <!-- Add Arrows -->
					    <div class="swiper-button-next"></div>
					    <div class="swiper-button-prev"></div>
					    </div>
					    
						<!--댓글 -->
					    <a class="small text-decoration-none" data-toggle="collapse" href="#collapseExample${club.ca_id}" role="button" aria-expanded="false" aria-controls="collapseExample">
							<svg width="1.6em" height="1.6em" viewBox="0 0 16 16" class="bi bi-chat-left-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
							  <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
							  <path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
							</svg>
						<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
						<c:choose>
							<c:when test="${fn:length(club.articleReplyList) ne 0 or fn:length(ca_reply.articleRe_replyList) ne 0}"> 
							댓글 ${fn:length(club.articleReplyList)+fn:length(ca_reply.articleRe_replyList)}개
							</c:when>
							<c:otherwise>
								댓글 0개
							</c:otherwise>
						</c:choose>
						</a>
						<br>
						<div class="collapse" id="collapseExample${club.ca_id}">
								<div class="card border border-right-0 border-left-0 border-bottom-0" style="margin-top:10px;">
									<!-- new comment form -->
									<section class="mt-3">
										<form action="">
											<div class="input-group input-group">
											<c:set var="profileImg" value="${profileImg}"/>	
												<c:if test="${profileImg ne ''}">
													<img src="data:image/jpg;base64, ${profileImg}" class="r_userImg" onclick="openMemberPopup2('${m_id}');">
												</c:if>
												<c:if test="${profileImg eq ''}">
													<img src="${contextPath}/resources/image/user.png" class="r_userImg" onclick="openMemberPopup2('${m_id}');">
												</c:if>
												<input type="text" id="comment${club.ca_id}" class="form-control" placeholder="댓글쓰기" aria-label="Recipient's username" aria-describedby="basic-addon2" style="margin-left:10px;margin-top:5px;">
												<div class="input-group-append">
													<a class="text-decoration-none text-white btn btn-primary" href='javascript:void(0);' style="margin-top:5px;height:38px;"onclick="insertReply(${club.ca_id});" role="button">쓰기</a>
												</div>
											</div>
										</form>
									</section>
									<!-- comment card -->
									<div id="sectionReply${club.ca_id}">
								<c:if test="${ca.reply eq null}">
									<c:forEach var="ca_reply" items="${club.articleReplyList}">
										<div class="p-2 mt-3" style="padding-left:0px !important;" id="pack${ca_reply.car_id}">
											<!-- comment header -->
											<div class="d-flex">
												<div class="">
													<c:set var="m_img" value="${ca_reply.e_m_img}"/>
														<c:if test="${m_img ne null}">
															<img src="data:image/jpg;base64, ${ca_reply.e_m_img}" class="r_userImg" onclick="openMemberPopup2('${ca_reply.m_id}');">
														</c:if>
														<c:if test="${m_img eq null}">
															<img src="${contextPath}/resources/image/user.png" class="r_userImg" onclick="openMemberPopup2('${ca_reply.m_id}');">
														</c:if>
												</div>
												<div class="flex-grow-1 pl-2">
													<a class="text-decoration-none text-capitalize h6 m-0"  href="javascript:void(0);" onclick="openMemberPopup2('${ca_reply.m_id}');">${ca_reply.m_nickname}</a>
													<p class="small m-0 text-muted edit${ca_reply.car_id}">${ca_reply.car_date}</p>
												</div>
												<a href='javascript:void(0);' onclick="re_reply(${ca_reply.car_id},${club.ca_id});" style="margin-right:5px;size:8px;">답글</a>
												<!--댓글작성자 수정/삭제 -->
												<c:set var="logOnId" value="${m_id}" />
												<c:set var="reply_writer" value="${ca_reply.m_id}" />
												<c:if test="${logOnId eq reply_writer}">
													<div>
														<div class="dropdown">
															<a class="" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
															<i class="fas fa-chevron-down"></i>
															</a>
	
															<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
																<a class="dropdown-item text-primary" onclick="editReplyInput(${ca_reply.car_id},'${ca_reply.car_content}');">수정</a>
															 	<a class="dropdown-item text-primary" onclick="deleteReply(${ca_reply.car_id});">삭제</a>
															</div>
														</div>
													</div>
													<br>
												</c:if>
											</div>
											<!-- comment header -->
											<!-- comment body -->
											<div class="card-body p-0" id="edit${ca_reply.car_id}">
												<p class="card-text h7 mb-1" id="content${ca_reply.car_id}" style="margin-left:53px;">${ca_reply.car_content}</p>
											</div>
										</div>
										<div>
										<div class="input-group input-group" id="re_reply${ca_reply.car_id}" style="display:none;margin-top:8px;">
											<c:set var="profileImg" value="${profileImg}"/>	
											<c:if test="${profileImg ne ''}">
												<img src="data:image/jpg;base64, ${profileImg}" class="r_replyUserImg" onclick="openMemberPopup2('${m_id}');">
											</c:if>
											<c:if test="${profileImg eq ''}">
												<img src="${contextPath}/resources/image/user.png" class="r_replyUserImg" onclick="openMemberPopup2('${m_id}');">
											</c:if>
											<input type="text" style="margin-left:10px;margin-top:5px;" id="re_comment${ca_reply.car_id}" class="form-control" placeholder="대댓글쓰기" aria-label="Recipient's username" aria-describedby="basic-addon2">
											<div class="input-group-append">
												<a class="text-decoration-none text-white btn btn-primary" style="height:38px;margin-top:5px;"href='javascript:void(0);' onclick="insertRe_reply(${club.ca_id},${ca_reply.car_id});" role="button">쓰기</a>
											</div>
										</div>
										<c:if test="${fn:length(ca_reply.articleRe_replyList) ne 0}">
										<a class="small text-decoration-none" style="margin-left:54px;" data-toggle="collapse" href="#collapseExample${ca_reply.car_id}" role="button" aria-expanded="false" aria-controls="collapseExample">
										대댓글 ${fn:length(ca_reply.articleRe_replyList)}개
										</a>
										</c:if>
										<!--대댓글 -->
										<!--대댓글 input -->
										<div class="collapse" id="collapseExample${ca_reply.car_id}">
										<c:forEach var="re_ca_reply" items="${ca_reply.articleRe_replyList}">
										<div class="p-2" style="margin-left:50px;" id="pack${re_ca_reply.car_id}">
											<!-- comment header -->
											<div class="d-flex">
												<div class="">
													<c:set var="m_img" value="${re_ca_reply.e_m_img}"/>
														<c:choose>
															<c:when test="${m_img ne null}">
																<img src="data:image/jpg;base64, ${re_ca_reply.e_m_img}" class="r_userImg" onclick="openMemberPopup2('${re_ca_reply.m_id}');">
															</c:when>
															<c:otherwise>
																<img src="${contextPath}/resources/image/user.png" class="r_userImg" onclick="openMemberPopup2('${re_ca_reply.m_id}');">
															</c:otherwise>
														</c:choose>
												</div>
												<div class="flex-grow-1 pl-2">
													<a class="text-decoration-none text-capitalize h6 m-0" href="javascript:void(0);" onclick="openMemberPopup2('${re_ca_reply.m_id}');">${re_ca_reply.m_nickname}</a>
													<p class="small m-0 text-muted edit${re_ca_reply.car_id}">${re_ca_reply.car_date}</p>
												</div>
												<div>
												<!--댓글 작성자 수정 / 삭제 -->
												<c:set var="logOnId" value="${m_id}" />
												<c:set var="re_reply_writer" value="${re_ca_reply.m_id}" />
												<c:if test="${logOnId eq re_reply_writer}">
														<div class="dropdown">
															<a class="" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
															<i class="fas fa-chevron-down"></i>
															</a>
															<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
																<a class="dropdown-item text-primary" onclick="editReplyInput(${re_ca_reply.car_id},'${re_ca_reply.car_content}');">수정</a>
																<a class="dropdown-item text-primary" onclick="deleteReply(${re_ca_reply.car_id});">삭제</a>
															</div>
														</div>
													</c:if>
												</div>
											</div>
											<!-- comment header -->
											<!-- comment body -->
											<div class="card-body p-0"  id="edit${re_ca_reply.car_id}">
												<p class="card-text h7 mb-1" id="content${re_ca_reply.car_id}" style="margin-left:53px;">${re_ca_reply.car_content}</p>
											</div>
										</div>
										</c:forEach>
										</div>
										</div>
										</c:forEach>
										</c:if>
									</div>
									<!-- comment card ends -->
								</div>
							</div>
						<!--본인이 쓴 글일 경우 수정,삭제 메뉴 -->
					</div>
				</div>
			</c:forEach>
			</c:when>
			<c:otherwise>
			<div class="card bg-light text-secondary secret" style="text-align:center;height:500px; margin-top:20px;">
				<div class="c">
				<svg width="4em" height="4em" viewBox="0 0 16 16" class="bi bi-file-earmark-lock-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
 						<path fill-rule="evenodd" d="M2 2a2 2 0 0 1 2-2h5.293A1 1 0 0 1 10 .293L13.707 4a1 1 0 0 1 .293.707V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2zm7.5 1.5v-2l3 3h-2a1 1 0 0 1-1-1zM7 7a1 1 0 0 1 2 0v1H7V7zm3 0v1.076c.54.166 1 .597 1 1.224v2.4c0 .816-.781 1.3-1.5 1.3h-3c-.719 0-1.5-.484-1.5-1.3V9.3c0-.627.46-1.058 1-1.224V7a2 2 0 1 1 4 0zM6 9.3c0-.042.02-.107.105-.175A.637.637 0 0 1 6.5 9h3a.64.64 0 0 1 .395.125c.085.068.105.133.105.175v2.4c0 .042-.02.107-.105.175A.637.637 0 0 1 9.5 12h-3a.637.637 0 0 1-.395-.125C6.02 11.807 6 11.742 6 11.7V9.3z"/>
				</svg>
				<h5 class="card-title">멤버만 게시글을 볼 수 있습니다.</h5>
				<p class="card-text">소모임에 가입해보세요 :O)</p>
				</div>
			</div>
			</c:otherwise>
			</c:choose>
			<!--club delete Modal -->
			<div class="modal fade" id="staticBackdrop2" data-backdrop="static"
				data-keyboard="true" tabindex
				="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<h5 class="modal-title">소모임 삭제</h5>
						<div class="modal-body">
							<h5 style="text-align: center;">해당 소모임을 삭제하겠습니까?</h5>
							<p>삭제 후에는 복구가 불가능합니다.</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
							<button type="button" class ="btn btn-primary"
								onclick="location.href='${contextPath}/club/deleteClub.do?c_id=${clubInfo.c_id}'">삭제하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
			<div class="side">
				<h5>만든 사람</h5>
				<c:forEach var="lead" items="${leader}">
					<c:set var="leaderImg" value="${lead.resultUserImg}" />
					<c:choose>
						<c:when test="${leaderImg eq null}">
							<img src="${contextPath}/resources/image/user.png"
								class="userListImg">
						</c:when>
						<c:otherwise>
							<img src="data:image/jpg;base64, ${leaderImg}" class="userListImg">
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<br>
				<br>
				<h5>함께하는 사람(${clubInfo.c_membercnt}명)</h5>
				<a href="${contextPath}/club/clubMemberList.do?c_id=${clubInfo.c_id}">모두 보기</a><br>
				<c:forEach var="member" items="${members}">
					<c:set var="membersImg" value="${member.resultUserImg}" />
					<c:choose>
						<c:when test="${membersImg eq null}">
							<img src="${contextPath}/resources/image/user.png"
								class="userListImg">
						</c:when>
						<c:otherwise>
							<img src="data:image/jpg;base64, ${membersImg}" class="userListImg">
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${rank eq 20 or rank eq 30}">
					<div style="float:bottom;">
						<button class="btn btn-link" data-toggle="modal" data-target="#leaveClub">소모임 탈퇴하기</button>
						<button class="btn btn-link" onClick='openReportPopup()'>소모임 신고하기</button>
					</div>
					</c:when>
				</c:choose>
				<c:if test="${!empty andone}">
<!-- 				&분의일 테이블 -->
				<table class="table mt-4">
				<caption style="caption-side:top;">우리 멤버가 쓴 &분의 일</caption>
				  <thead>
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col">제목</th>
				      <th scope="col">작성자</th>
				    </tr>
				  </thead>
				  <tbody id="ticker">
				  <c:forEach var="andone" items="${andone}" varStatus="status">
				  <c:choose>
				  <c:when test="${status.count eq 1 or status.count eq 2}">
				    <tr id="show${status.count}">
				      <td scope="row">
				      <c:if test="${andone.one_type eq 010}">
				      	같이먹기
				      </c:if>
				      <c:if test="${andone.one_type eq 011}">
				      	같이사기
				      </c:if>
				      <c:if test="${andone.one_type eq 012}">
				      	같이하기
				      </c:if>
				      </td>
				      <td><a href="${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}">
				      		[${andone.gc_name}]<br> <span class="d-inline-block text-truncate" style="max-width: 150px;">${andone.one_title}</span>
				      </a></td>
				      <td><a href="javascript:void(0);" onclick="openMemberPopup2('${andone.m_id}');">${andone.m_nickname}</a></td>
				    </tr>
				    </c:when>
				    <c:otherwise>
				    <tr class="none">
				      <td scope="row">
				      <c:if test="${andone.one_type eq 010}">
				      	같이먹기
				      </c:if>
				      <c:if test="${andone.one_type eq 011}">
				      	같이사기
				      </c:if>
				      <c:if test="${andone.one_type eq 012}">
				      	같이하기
				      </c:if>
				      </td>
				      <td><a href="${contextPath}/and/detailAndOne.do?one_id=${andone.one_id}&g_id=${andone.one_type}">
				      		[${andone.gc_name}]<br> <span class="d-inline-block text-truncate" style="max-width: 150px;">${andone.one_title}</span>
				      </a></td>
				      <td><a href="javascript:void(0);" onclick="openMemberPopup2('${andone.m_id}');">${andone.m_nickname}</a></td>
				    </tr>
				    </c:otherwise>
				    </c:choose>
				   </c:forEach>
				  </tbody>
				  </table>
			<button class="btn btn-light btn-block" onclick="moreAndOnd();">더보기</button>
			</c:if>
			</div>
			
			
			
			
		</div>
	<!--Intro Modal -->
	<div class="modal fade" id="introModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">소모임 가입하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form class="intro" method="post">
				<div class="modal-body">
					<h6 style="text-align:center;">${clubInfo.c_ask}</h6>
					<textarea class="form-control col-sm-55" rows="5" name="cm_intro"></textarea></div>
				<div class="modal-footer" style="margin-top:5px;">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="joinClub(${clubInfo.c_id});">가입하기</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<!--leaveClub Modal -->
<div class="modal fade" id="leaveClub" tabindex="-1" aria-labelledb y="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">소모임 탈퇴하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        	소모임을 탈퇴하시겠어요? </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="location.href='${contextPath}/club/leaveClub.do?c_id=${clubInfo.c_id}'">탈퇴하기</button>
      </div>
    </div>
  </div>
</div>
 <!-- Swiper JS -->
 <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
  var swiper = new Swiper('.swiper-container', {
      slidesPerView: 1,
      spaceBetween: 30,
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  </script>
</body>
</html>