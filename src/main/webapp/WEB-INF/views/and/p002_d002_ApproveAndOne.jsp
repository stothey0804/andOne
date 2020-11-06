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
	<script>
	//수락하기
	function okAndOne(m_id,one_id,idx){
		console.log("m_id>>"+m_id);
		console.log("one_id>>"+one_id);
		$.ajax({
			type : "post",
   			dataType: "text",
   			async: "true",
   			url:"${contextPath}/and/okOneMember.do",
   			data:{
   				m_id : m_id,
   				one_id :one_id
   			},
   			success:function(data,textSataus){
   				console.log("확인:"+data);
   				if(data =="fail"){
   					alert("수락인원이 초과되어 수락이 불가능합니다");
   				}else if(data == "success"){
	   				$(".check"+idx).html("&분의일 신청 수락완료:)");
	   				// ------ 알림전송
	   			 	// db저장	
	   	   		    let g_id = '${g_id}';
	   	   		    let type = '';
	   	   		    // 분류코드설정
					if(g_id=='010'){type='10';}else if(g_id=='011'){type='20'}else if(g_id=='012'){type='30';}
	   	   		 	let content = '['+ one_id +'] 참가신청이 수락됐습니다.';		// 알림메시지
	   	   		 	let url = '${contextPath}/and/detailAndOne.do?one_id='+one_id+'&g_id='+g_id;
	   	   		 	$.ajax({
	   					type: 'post',
	   					url: '${contextPath}/member/saveNotify.do',
	   					dataType: 'text',
	   					data: {
	   						target: m_id,
	   						content: content,
	   						type: type,
	   						url: url
	   					},
	   					success: function(){
	   						// 소켓전송
	   						socket.send("&분의일,"+m_id+","+content+","+url);	// 소켓에 전달
	   					}
	   				});
	   	   		 	// ------ 알림전송 END
   				}
   			}
		})
	}
	//거절하기
	function denyAndOne(m_id,one_price,one_id,idx){
		console.log("m_id>>"+m_id);
		console.log("one_id>>"+one_id);
		$.ajax({
			type : "post",
   			dataType: "text",
   			async: "true",
   			url:"${contextPath}/and/denyOneMember.do",
   			data:{
   				m_id : m_id,
   				one_id: one_id,
   				one_price : one_price
   			},
   			success:function(data,textSataus){
   				$("#"+idx).remove();
   				// ------ 알림전송
   			 	// db저장	
   	   		    let g_id = '${g_id}';
   	   		    let type = '';
   	   		    // 분류코드설정
				if(g_id=='010'){type='10';}else if(g_id=='011'){type='20'}else if(g_id=='012'){type='30';}
   	   		 	let content = '['+ one_id +'] 참가신청이 거절됐습니다.';		// 알림메시지
   	   		 	let url = '${contextPath}/and/detailAndOne.do?one_id='+one_id+'&g_id='+g_id;
   	   		 	$.ajax({
   					type: 'post',
   					url: '${contextPath}/member/saveNotify.do',
   					dataType: 'text',
   					data: {
   						target: m_id,
   						content: content,
   						type: type,
   						url: url
   					},
   					success: function(){
   						// 소켓전송
   						socket.send("&분의일,"+m_id+","+content+","+url);	// 소켓에 전달
   					}
   				});
   	   		 	// ------ 알림전송 END
   			}
		})
	}
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
			<h2 class="m-5">&분의일 참가요청</h2>
			<div class="form-group col-sm-15 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th>닉네임</th><th>신청날짜</th><th>수락/거절</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${AndOnewaitMemList}" varStatus="status">
						<c:set var="mem_img" value="${list.resultUserImg}"/>
					<tbody id="${status.count}">
						<tr class="arcticleSubject text-center">
						<td scope="row">${status.count}</td>
						<td>
						<c:choose>
							<c:when test="${mem_img eq null}">
								<img src="${contextPath}/resources/image/user.png" class="m_img">
							</c:when>
							<c:otherwise>
								<img src="data:image/jpg;base64, ${list.resultUserImg}" class="m_img">
							</c:otherwise>
						</c:choose>
						${list.m_nickname} 
						</td>
						<td>${list.om_date}</td>
						<td onclick="event.cancelBubble=true" class="check${status.count}">
							<button type="button" class="btn btn-outline-danger" onclick="okAndOne('${list.m_id}','${list.one_id}','${status.count}')">수락</button>
							<button type="button" class="btn btn-outline-dark" onclick="denyAndOne('${list.m_id}','${list.one_price}','${list.one_id}','${status.count}')">거절</button>
						</td>
					</tbody>
					</c:forEach>
				</table>
			</div>
</div>
</body>
</html>