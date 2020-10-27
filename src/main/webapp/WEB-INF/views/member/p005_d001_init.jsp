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
		// 읽은알림 카운트 얻기
		var oldListCnt = '${oldListCnt}';
		// 조회 인덱스
		var startIndex = 1;
		
		// 로딩시 실행 - 읽은 알림 5개 얻기 
		readOldNotify(startIndex);
		if(startIndex + 4 >= oldListCnt){
			$('#searchMoreNotify').remove();
		}
		
		// 더보기 클릭시
		$('#searchMoreNotify').click(function(){
			startIndex += 5;
			readOldNotify(startIndex);
			if(startIndex + 4 >= oldListCnt){
				$('#searchMoreNotify').remove();
			}
			
		});
		
		// 클릭 시
		$('.newElem').click(function(e){
			let _n_id = $(this).find('.notifyId').text();
			let notifyElem = $(this);
			// 읽기로 보내주기!
			readNewNotifyElem(_n_id, notifyElem);
		});
		// 읽기버튼 클릭시 
		$('.readNotifyBtn').click(function(e){
			e.stopPropagation();	// 부모 이벤트 끊기
			let _n_id = $(this).siblings('.notifyId').text();
			let notifyElem = $('.newElem').has(this);
			readNewNotifyElem(_n_id, notifyElem);
			$(e.target).remove();	// 읽기버튼 삭제
		});
		// 읽기 ajax
		function readNewNotifyElem(_n_id, notifyElem){
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
                	$(targetElem).before(notifyElem);
//                 	$(e.target).remove();
                	// 안읽은 알림 카운트 줄이기
                	let newCnt = $('#newNoticeCnt').text()-1;
                	if(newCnt!='0'){
	                	$('#newNoticeCnt').text(newCnt);
                	}
                }
			});
		}
		
		// 더보기 실행함수
		function readOldNotify(index){
			$.ajax({
				type: "post",
				async: "true",
				dataType: "json",
				data: {
					m_id: '${m_id}',
					startIndex: index
				},
				url: "${contextPath}/member/searchMoreNotify.do",
	            success: function (data, textStatus) { 
					for(i = 0; i < data.length; i++){
						let newNode = "<div class='card form-group col-sm-10 mx-auto p-0' onClick='window.open('"+data[i].n_url+"')>";
						newNode += "<div class='card-body pt-3'><div class='row px-3 mb-2'>";
						newNode += "<strong class='d-block text-gray-dark'>"+data[i].n_type+"</strong>";
						newNode += "<span class='text-muted ml-auto'>"+data[i].n_time+"</span>";
						newNode += "</div><span>"+data[i].n_content+"</span></div></div>";
		            	$(newNode).appendTo($("#oldList"));				
					}
	            }
			});
		}
		
		
	});

</script>
</head>
<body>
	<div class="container">
			<h2 class="m-5">
			새로 온 알림
			</h2>
			<div id="newList">
			<c:if test="${empty newList}">
				<div class="card form-group col-sm-10 mx-auto p-0 bg-light border-light">
					<div class="card-body pt-3 text-center">
				        새로 받은 알림이 없습니다.
				    </div>
				</div>			
			</c:if>
			<c:forEach var="list" items="${newList}">
				<div class="newElem card form-group col-sm-10 mx-auto p-0">
					<div class="card-body pt-3" onclick="window.open('${list.n_url}')">
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