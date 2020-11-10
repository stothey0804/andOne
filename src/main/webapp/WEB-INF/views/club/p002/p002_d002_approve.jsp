<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@font-face {
	font-family: 'YanoljaYacheR';
	src:url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
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
.font { 
	font-family: 'YanoljaYacheR' !important; 
	font-size: 250%; 
} 

.userImg{
	cursor:pointer;
}
</style>
<script>
	$(document).ready(function(){
		$(".userList").click(function(){
			let id = getUserId(this);
			$("#"+id+" .intro").toggle();
		})
		
		function getUserId(elem){
			let result = $("tbody").has(elem);
			console.log(result);
			return result.attr("id");
		}
	})
	
	function permit(c_id,m_id,idx){
		$(".cnt"+idx).html("가입승인 완료");
		$.ajax({
			type:"get",
			dataType:"text",
			url:"${contextPath}/club/permitMember.do",
			data:{c_id:c_id,m_id:m_id},
			success: function (data, textStatus) {
				// 승인성공 시 알림전송
				let type = '40';	// 소모임
				let target = m_id;	// 승인 멤버 아이디
				let url = '/andOne/club/detailClub.do?c_id='+c_id;
				
				// 소모임 명 조회 ajax
				$.ajax({
					type: 'post',
					url: '/andOne/selectClubName.do',
					dataType: 'text',
					data: {	c_id: c_id	},
					success: function(data){
						// 소모임명 저장
						var content = '[' + data +'] 소모임 가입이 승인됐습니다.';
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
		})
	}
	
	function deny(c_id,m_id,idx){
		$("#"+idx).remove();
		$.ajax({
			type:"get",
			dataType:"text",
			url:"${contextPath}/club/denyMember.do",
			data:{c_id:c_id,m_id:m_id}
		})
	}
	
	function openMemberPopup2(m_id){
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}

</script>
</head>
<body>
<h3 style="margin:20px auto;width:300px;" class="font">가입 요청 멤버 목록</h3>
<table class="table table-hover" style="width:1000px;margin:0 auto;">
  <thead>
    <tr>
      <th scope="col">No.</th>
      <th scope="col">닉네임</th>
      <th scope="col">가입요청일자</th>
      <th scope="col">수락/거절</th>
    </tr>
  </thead>
		<c:forEach var="waitMember" items="${waitMember}" varStatus="status">
<tbody id="${status.count}">
		<tr class="userList">
		<th>${status.count}</th>
			<c:set var="memImg" value="${waitMember.resultUserImg}" />
			<td>
			<c:choose>
				<c:when test="${memImg eq null}">
					<img src="${contextPath}/resources/image/user.png" class="userImg" onclick="openMemberPopup2('${waitMember.m_id}');">
				</c:when>
				<c:otherwise>
					<img src="data:image/jpg;base64, ${memImg}" class="userImg" onclick="openMemberPopup2('${waitMember.m_id}');">
				</c:otherwise>
			</c:choose>
			<a href="javascript:void(0);" onclick="openMemberPopup2('${waitMember.m_id}');">
				${waitMember.m_nickname}
			</a>				
			</td>
			<td>${waitMember.cm_joindate}</td>
			<td onclick="event.cancelBubble=true" class="cnt${status.count}">
				<button type="button" class="btn btn-outline-primary"
				onclick="permit(${c_id},'${waitMember.m_id}',${status.count})">수락</button>
				<button type="button" class="btn btn-outline-dark"
				onclick="deny(${c_id},'${waitMember.m_id}',${status.count})">거절</button>
			</td>
			</tr>
		<tr style="display:none;" class="intro">
			<td></td>
			<td></td>
			<td><p style="font-weight:bold">가입인사<p><br>${waitMember.cm_intro}</td>
			<td></td>
		</tr>
</tbody>
		</c:forEach>
</table>
<div class="container center">
		<button type="button" style="margin:0 auto;" class="btn btn-info" onclick="location.href='${contextPath}/club/detailClub.do?c_id=${c_id}'">
		소모임으로 돌아가기</button></div>
</body>
</html>