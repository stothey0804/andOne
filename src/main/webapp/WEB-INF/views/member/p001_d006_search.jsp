<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>회원목록</title>
	<style>
		div.form-group{
			width: 100%;
		}
	 	.container{ 
			margin: 0 auto;
		}
		
		.searchValue{
			width: 100px !important;
		}
	
	    .popup-container {
	     	width: 800px;
	    	z-index: 9990;
	/*     	visibility: hidden; */
	    	position: absolute;
	    	left: 50%;
	    	top: 100px;
/* 	    	transform: translate(-50%, -50%); */
	    	transform: translateX(-50%);
	    	border: solid 2px black;
	    }
	    #popup-close{
	    	font-size: 3.5em;
	    	margin-top: -0.3em;
	    	margin-right: -0.3em;
	    	cursor: pointer;
	    }
	    .popup-display{
	    	display: none;
	    }
	    
	    .modal{
	    	z-index: 9999;
	    }
		
	</style>
	<script src = "${contextPath}/resources/js/adminSearch.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		// 버튼 클릭시 
		$('#notifyModalBtn').click(function(e) {
			  var modal = $('.modal');
			  modal.find('.modal-body #notifyId').val($('td.id').text());
		});
		$('#pointModalBtn').click(function(e) {
			  var modal = $('.modal');
			  modal.find('.modal-body #pointTargetId').val($('td.id').text());
		});
		
		// notifySend
		$('#notifySendBtn').click(function(e){
			let modal = $('.modal-content').has(e.target);
// 			let cmd = 'adminMsg';
			let type = '70';
			let target = modal.find('.modal-body input').val();
			let content = modal.find('.modal-body textarea').val();
			let url = '${contextPath}/member/notify.do';
			// db저장	
			$.ajax({
				type: 'post',
				url: '${contextPath}/member/saveNotify.do',
				dataType: 'text',
				data: {
					target: target,
					content: content,
					type: type,
					url: url
				},
				success: function(){
					socket.send("관리자,"+target+","+content+","+url);	// 소켓에 전달
				}
			});
			modal.find('.modal-body textarea').val('');	// textarea 지우기
		});

		// pointSend
		$('#pointSendBtn').click(function(e){
			let modal = $('.modal-content').has(e.target);
// 			let cmd = 'pointSendMsg';
			let type = '50';	// 분류코드
			let target = modal.find('.modal-body #pointTargetId').val();	// 받을 멤버 ID
			let amount = modal.find('.modal-body #point').val();	// 포인트량
			let content = '관리자님이 ' + amount + '포인트를 지급하였습니다.';		// 알림메시지
			console.log(content);
			let url = '${contextPath}/point/pointDetail.do';		// url
			// 포인트 insert
			$.ajax({
				type: 'post',
				url: '${contextPath}/point/insertPointFromAdmin.do',
				dataType: 'text',
				data: {
					target: target,
					amount: amount
				},
				success: function(){
					// db저장	
					$.ajax({
						type: 'post',
						url: '${contextPath}/member/saveNotify.do',
						dataType: 'text',
						data: {
							target: target,
							content: content,
							type: type,
							url: url
						},
						success: function(){
							socket.send("포인트,"+target+","+content+","+url);	// 소켓에 전달
						}
					});
				}
			});

			modal.find('.modal-body #point').val('');	// textarea 지우기
		});
	});
	</script>
</head>

<body>

<!-- Notify Modal START -->
<div class="modal fade" id="notifyModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pointModalLabel">알림전송</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <input type="hidden" class="form-control" id="notifyId">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button id="notifySendBtn" type="button" class="btn btn-primary">알림전송</button>
      </div>
    </div>
  </div>
</div>
<!-- NOtify Modal END -->
<!-- Point Modal START -->
<div class="modal fade" id="pointModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="notifyModalLabel">포인트지급</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <input type="hidden" class="form-control" id="pointTargetId">
            <label for="point" class="col-form-label">지급포인트</label>
            <input class="form-control" id="point" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button id="pointSendBtn" type="button" class="btn btn-primary">포인트지급</button>
      </div>
    </div>
  </div>
</div>
<!-- Point Modal END -->

<!-- Popup START -->
<div id="popup-container" class="popup-display">
		<div class="popup-container p-5 bg-light m-auto">
		<div class="row m-1">
			<p class="h3 mb-3">
			회원정보상세
			</p>		
			<div class="ml-auto">
				<svg width="1em" height="1em" viewBox="0 0 16 16" id="popup-close" class="bi bi-x btn-layerClose" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
				</svg>
			</div>
		</div>
				<h5 class="mb-3">회원정보</h5>
				<table class="table">
					<tr>
						<th width="25%">회원ID</th>
						<td width="25%" class="id"></td>
						<th width="25%">휴대폰번호</th>
						<td width="25%" class="phone"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="email"></td>
						<th>성별</th>
						<td class="gender"></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td class="nickname"></td>
						<th>나이대</th>
						<td class="age"></td>
					</tr>
				</table>
				<br>
				<h5 class="mb-3">이용정보</h5>
				<table class="table">
					<tr>
						<th width="25%">평점</th>
						<td width="25%" class="m_score"></td>
						<th width="25%">신고받은 수</th>
						<td width="25%" class="reportCnt"></td>
					</tr>
					<tr>
						<th>보유포인트</th>
						<td class="p_currentpoint"></td>
						<th>신고/문의 건수</th>
						<td class="qnaCnt"></td>
					</tr>
					<tr>
						<th>가입한 소모임 수</th>
						<td class="joinClubCnt"></td>
						<th>작성리뷰수</th>
						<td class="reviewCnt"></td>
					</tr>
				</table>
				<br>
				<h5 class="mb-3">포인트이력</h5>
				<table class="table" style="margin-bottom:-1px">
				<thead>
					<tr>
						<th style="text-align:center;width:20%">이력번호</th>
						<th style="text-align:center;width:30%">날짜</th>
						<th style="text-align:center;width:30%">내용</th>
						<th style="text-align:center;width:20%">이용포인트</th>
					</tr>
				</thead>
				</table>
				<div style="overflow:auto; width:100%; height:150px" class="mt-0">
				<table class="table pointList">
					<tbody>
					
					</tbody>
				</table>
				</div>
				<div class="row mt-2">
					<button id="pointModalBtn" class="btn btn-primary" data-toggle="modal" data-target="#pointModal">포인트 지급</button>
					<div class="ml-auto">
						<button id="notifyModalBtn" type="button" class="btn btn-secondary" data-toggle="modal" data-target="#notifyModal">알림전송</button>
						<button class="btn btn-danger">회원삭제</button>
					</div>
				</div>
<!-- 		</form> -->
	</div>
</div>
<!-- Popup END -->

<div class="container">
	<h2 class="m-5">일반회원 조회</h2>
	<div class="form-group col-sm-11 mx-auto p-0">
		<!-- 검색폼 START -->
		
		<form action="searchMemberList.do" method="post">
			<div class="input-group mb-3 col-6 ml-auto">
			<!-- 구분  -->
			 <div class="input-group-prepend">
			      <label class="input-group-text" for="inputGroupSelect01">검색조건</label>
		      </div>
   		    <select class="custom-select" name="searchCondition">
				<c:forEach items="${conditionMap}" var="option">
				<option value="${option.value}">${option.key }
				</c:forEach>
		    </select>
			  <input type="text" name="searchKeyword" class="form-control searchValue" aria-describedby="button-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			  </div>
			</div>
		</form><!-- 검색폼 END -->
		<!-- 리스트영역  -->
			<table class="table result">
				<thead>
				<tr class="text-center">
	<!-- 				<th>번호</th> -->
					<th>회원ID</th>
					<th>이메일</th>
					<th>닉네임</th>
					<th>휴대폰번호</th>
					<th>가입일시</th>
					<th>상세정보</th>
				</tr>
				</thead>
				<c:forEach items="${memberList }" var="member" varStatus="status">
				<tr>
	<%-- 				<td>${status.count }</td> --%>
					<td>${member.m_id }</td>
					<td>${member.m_email }</td>
					<td class="text-center">${member.m_nickname }</td>
					<td class="text-center">${member.m_phonenumber }</td>
					<td>${member.m_joinDate }</td>
					<td><button name="#layer1" class="searchCommonMemberDetail btn-sm btn btn-outline-secondary detail">상세보기</button></td>
				</tr>
				</c:forEach>
			</table>
			<!-- 페이징  -->
			<nav aria-label="Page navigation example">
			    <ul class="pagination justify-content-center">
			        <c:if test="${pagination.curRange ne 1 }">
			            <li class="page-item">
			            <a class="page-link" href="?curPage=1">처음</a> 
			            </li>
			        </c:if>
			        <c:if test="${pagination.curPage ne 1}">
			            <li class="page-item">
			                <a class="page-link" href="?curPage=${pagination.prevPage}">이전</a> 
			                </li>
			        </c:if>
			        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
			            <c:choose>
			                <c:when test="${pageNum eq  pagination.curPage}">
			                    <li class="page-item active">
			                        <a class="page-link" href="?curPage=${pageNum}">${pageNum }</a>
			                    </li>
			                </c:when>
			                <c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" href="?curPage=${pageNum}">${pageNum }</a>
			                    </li>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
			            <li class="page-item">
			                <a class="page-link" href="?curPage=${pagination.nextPage}">다음</a> 
			                </li>	                        
			        </c:if>
			        <c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
			            <li class="page-item">
			                <a class="page-link" href="#"  onClick="fn_paging('${pagination.pageCnt }')">끝</a> 
			                </li>	                    
			    </c:if>
			    </ul>
			</nav>
			<!-- 페이징 END -->
	</div>
</div>



</body>

</html>