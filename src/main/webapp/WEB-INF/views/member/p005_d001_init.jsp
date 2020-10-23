<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	#newList, #oldList{
		cursor: pointer;
	}
	#newList .card{
    	background-color: #cce5ff;
    	border-color: #b8daff;
	}
	#newList .card:hover{
    	background-color: #b8daff;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 읽은 알림 수 얻기
		var oldListCnt = '${oldListCnt}';
		
		$.ajax({
			type: "post",
			async: "true",
			dataType: "json",
			data: {
				m_id: '${m_id}',
				startIndex: 1
			},
			url: "${contextPath}/member/searchMoreNotify.do",
            success: function (data, textStatus) { 
//             	let targetElem = document.getElementById('oldList').firstChild;
//             	console.log(notifyElem);
            	$("#oldList").append(notifyElem);
            	let newCnt = $('#newNoticeCnt').text()-1;
            	if(newCnt!='0'){
                	$('#newNoticeCnt').text(newCnt);
            	}
            }
			
		});
		
		// 읽기 클릭 시
		$('.readNotifyBtn').click(function(e){
			e.stopPropagation();	// 부모 이벤트 끊기
			let _n_id = $(this).next().text();
             let notifyElem = $(this).parent().parent().parent();
// 			console.log();
			// 읽기로 보내주기!
			$.ajax({
                type: "post",
                async: "true",
                dataType: "text",
                data: {
                    n_id: _n_id //data로 넘겨주기
                },
                url: "${contextPath}/member/readNotify.do",
                success: function (data, textStatus) { 
                	let targetElem = document.getElementById('oldList').firstChild;
                	console.log(notifyElem);
                	$(targetElem).before(notifyElem);
                	let newCnt = $('#newNoticeCnt').text()-1;
                	if(newCnt!='0'){
	                	$('#newNoticeCnt').text(newCnt);
                	}
                }
			});

		})
	});

</script>
</head>
<body>
	<div class="container">
			<h2 class="m-5">
			새로 온 알림
			</h2>
			<div id="newList">
			<c:forEach var="list" items="${newList}">
				<div class="card form-group col-sm-10 mx-auto p-0">
					<div class="card-body pt-3" onclick="location.href='${list.n_url}'">
						<div class="row px-3 mb-2">
					        <strong class="d-block text-gray-dark">${list.n_type}</strong>
					        <span class="text-muted ml-auto">${list.n_time}</span>
						</div>
						<div class="row px-3">
					        <span>${list.n_content}</span>
					        <button class="readNotifyBtn btn btn-sm btn-primary ml-auto">읽기</button>
					        <span class="notifyId d-none">${list.n_id}</span>
						</div>
				        
				    </div>
				</div>			
			</c:forEach>
			</div>
			<h2 class="m-5">
			읽은 알림
			</h2>
			<div id="oldList">
<%-- 			<c:forEach var="list" items="${oldList}"> --%>
<%-- 				<div class="card form-group col-sm-10 mx-auto p-0" onClick="location.href='${list.n_url}'"> --%>
<!-- 					<div class="card-body pt-3"> -->
<!-- 						<div class="row px-3 mb-2"> -->
<%-- 					        <strong class="d-block text-gray-dark">${list.n_type}</strong> --%>
<%-- 					        <span class="text-muted ml-auto">${list.n_time}</span> --%>
<!-- 						</div> -->
<%-- 				        <span>${list.n_content}</span> --%>
<!-- 				    </div> -->
<!-- 				</div>			 -->
<%-- 			</c:forEach> --%>
			</div>
			<button id="searchMoreNotify" class="btn btn-outline-primary btn-block col-sm-10 mx-auto">더 보기</button>
	</div>
</body>
</html>