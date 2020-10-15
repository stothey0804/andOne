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
	width: 500px;
}

.side{
	display: relative;
	position:absolute;
	margin-left:20px;
	margin-top:17px;
}

.left {
	margin-top: 0;
	position: fixed;
}

.right {
	margin-left: 300px;
	margin-top: 17px;
}

.card-title, .pin, .card-subtitle {
	display: inline-block;
	margin-left: 10px;
}

.art-title {
	width: 330px;
	position: absolute;
}

.pin {
	width: 30px;
	position: absolute;
	top: 20px;
	right: 20px;
}

.card-subtitle {
	margin-top: 10px;
}

.bi-bookmark-star-fill ,.side{
	fill: #ffcc00;
	display: inline-block;
}

.show {
	position: fixed;
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
}

.aa {
	display: none;
}

.userImg {
	position: relative;
	border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	width: 60px;
	height: 60px;
}
.bi-file-earmark-lock-fill,.c{
	margin:auto;
}

</style>
<script type="text/javascript">

	function menuTap(ca_id){
		$('.'+ca_id).slideToggle();
	};
	
	function send(ca_id){
		console.log(ca_id); 
		var ca_id_p = ca_id;
		$('.aa').html(ca_id_p);
	};
	
	function deleteArticle(c_id){
		console.log(c_id);
		var p_c_id = c_id;
		var ca_id = $('.aa').text();
		console.log(ca_id);

		$.ajax({
			type: "get",
			dataType: "text",
			async: true,
			url:"${contextPath}/deleteClubArticle.do?ca_id="+ca_id+"&c_id="+p_c_id
		});
		location.reload();
	}

</script>
</head>
<body>
<!-- 	소모임 카드 -->
<div class="row">
	<div class="container my-6 center top">
		<div class="left">
			<div class="card info" style="width: 18rem; margin-top:17px;">
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
					<h5 class="card-title">${clubInfo.c_name }</h5>
					<p class="card-text">함께하는 사람 ${clubInfo.c_membercnt }</p>
					<small class="text-muted" style="height: 14px">#${clubInfo.c_hashtag}</small>
					<c:set var="cm_rank" value="${rank}"/>
						<c:choose>
							<c:when test="${rank eq 10}">
								<a href="${contextPath}/club/writeArticleForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">글쓰기</a>
								<div class="btn-group" role="group">
								<button id="btnGroupDrop1" type="button"
									class="dropdown-toggle btn btn-success btn-block"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" style="margin-top:10px">소모임 관리</button>
								<div class="dropdown-menu btn btn-success btn-block" aria-labelledby="btnGroupDrop1">
									<a class="dropdown-item" href="#">요청승인하기</a> 
									<a class="dropdown-item" href="#">소모임 수정하기</a>
									<button data-target="#staticBackdrop2" class="dropdown-item" data-toggle="modal">소모임 삭제하기</button>
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
								<a href="${contextPath }/club/introForm.do?c_id=${clubInfo.c_id}" class="btn btn-success btn-block"
									style="margin-top: 3px;">함께하기</a>
							</c:otherwise>
						</c:choose>
				</div>
			</div>
		</div>
		<div class="right">
			<div class="card">
				<div class="card-header">${clubInfo.c_name }</div>
				<div class="card-body">
					<h5>${clubInfo.c_content }</h5>
				</div>
			</div>

			<!--소모임 게시글  -->
			<c:choose>
			<c:when test="${rank eq 10 or rank eq 20 or rank eq 30}">
			<c:forEach var="club" items="${clubInfo.articleList }">
			<c:set var="m_img" value="${club.resultUserImg }"/>
				<div class="card article" style="width: 500px; height: auto;">
					<div class="card-body" style="height: auto">
					<c:choose>
						<c:when test="${m_img ne null}">
							<img src="data:image/jpg;base64, ${club.resultUserImg}" class="userImg">
						</c:when>
						<c:otherwise>
							<img src="${contextPath}/resources/image/user.png" class="userImg">
						</c:otherwise>
					</c:choose>
						<h5 class="card-title art-title">${club.m_nickname}</h5>
						<c:set var="ca_pin" value="${club.ca_pin}" />
						<c:choose>
							<c:when test="${ca_pin eq 1}">
								<div class="pin">
									<svg width="1.5em" height="1.5em" viewBox="0 0 16 16"
										class="bi bi-bookmark-star-fill" fill="currentColor"
										xmlns="http://www.w3.org/2000/svg">
  							<path fill-rule="evenodd"
											d="M4 0a2 2 0 0 0-2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4zm4.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.178.178 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.178.178 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.178.178 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.178.178 0 0 1-.134-.098L8.16 4.1z" />
						</svg>
								</div>
							</c:when>
						</c:choose>
						<h6 class="card-subtitle mb-2 text-muted">${club.ca_date }</h6>
						<p class="card-text" style="margin-top: 10px;">${club.ca_content }</p>
						<c:set var="ca_img" value="${club.articleImgList}" />
						<c:choose>
							<c:when test="${ca_img eq ''}">
							</c:when>
							<c:otherwise>
							<c:forEach var="ca_img" items="${club.articleImgList}">
								<div class="ca_img_div">
									<img src="data:image/jpg;base64, ${ca_img.resultArticleImg}" class="ca_img">
								</div>
							</c:forEach>
							</c:otherwise>
						</c:choose>
						<!--본인이 쓴 글일 경우 수정,삭제 메뉴 -->
						<c:set var="logOnId" value="${m_id }" />
						<c:set var="writer" value="${club.m_id }" />
						<c:choose>
							<c:when test="${logOnId eq writer}">
								<svg onclick="menuTap(${club.ca_id});" width="1em" height="1em"
									viewBox="0 0 16 16" class="tap bi bi-three-dots"
									fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd"
										d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z" />
							</svg>
								<div class="sub ${club.ca_id}">
									<button type="button" class="btn btn-outline-secondary"
										onclick="location.href='editClubArticle.do?ca_id=${club.ca_id}'">수정</button>
									<button type="button" class="btn btn-outline-danger delete"
										onclick="send(${club.ca_id})" data-toggle="modal"
										data-target="#staticBackdrop">삭제</button>
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			</c:forEach>
			</c:when>
			<c:otherwise>
					<div class="card bg-light text-secondary secret" style="text-align:center; height:400px; margin-top:20px;">
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
			<!--article delete Modal -->
			<div class="modal fade" id="staticBackdrop" data-backdrop="static"
				data-keyboard="true" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="false">
				<div class="modal-dialog">
					<div class="modal-content">
					<h5 class="modal-title">소모임 게시글 삭제</h5>
						<div class="modal-body">
							<h6 style="text-align: center;">해당 게시물을 삭제하겠습니까?</h6>
							<p class="aa"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary"
								onclick="deleteArticle(${clubInfo.c_id})">삭제하기</button>
						</div>
					</div>
				</div>
			</div>
			
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
								onclick="location.href='${contextPath}/deleteClub.do?c_id=${clubInfo.c_id}'">삭제하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="side">
		<h5>리더</h5>
		<c:forEach var="leader" items="${leader}">
		<c:set var="leader" value="${leader.resultUserImg}"/>
					<c:choose>
						<c:when test="${leader eq null}">
							<img src="${contextPath}/resources/image/user.png" class="userImg">
						</c:when>
						<c:otherwise>
							<img src="data:image/jpg;base64, ${leader}" class="userImg">
						</c:otherwise>
					</c:choose>		
		</c:forEach>
		<br><br>
		<h5>멤버(${clubInfo.c_membercnt}명)</h5><a href="#">모두 보기</a><br>
		<c:forEach var="members" items="${members}">
		<c:set var="members" value="${members.resultUserImg}"/>
					<c:choose>
						<c:when test="${members eq null}">
							<img src="${contextPath}/resources/image/user.png" class="userImg">
						</c:when>
						<c:otherwise>
							<img src="data:image/jpg;base64, ${members}" class="userImg">
						</c:otherwise>
					</c:choose>		
		</c:forEach>
		</div>
	</div>
	</div>
</body>
</html>