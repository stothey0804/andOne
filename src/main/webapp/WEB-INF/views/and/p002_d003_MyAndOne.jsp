<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
	//취소하기
    function cancelAndOne(one_id,one_price){
	        console.log(one_id);
			$.ajax({
	   			type : "post",
	   			dataType: "text",
	   			async: "true",
	   			url:"${contextPath}/and/cancelOneMember.do",
	   			data:{
	   				"one_id" : one_id,
	   				"one_price" : one_price
			},
			success:function(data,textSataus){
				console.log("확인: "+data);
				if(data == 'true'){
					console.log("취소성공");
					$('#cancleOkModal').modal("show");
					}else{
						console.log("취소불가");
						$('#cancleFailModal').modal("show");
					}
				}
			})
		}
    function init(){
		let prices = document.querySelectorAll("span.price");
			let priceResults = document.querySelectorAll("span.priceResult");
			
			for(let i=0; i<prices.length; i++){
				var pResult = prices[i].textContent;
				priceResults[i].innerHTML = pointToNumFormat(pResult);
  		}
	 	function pointToNumFormat(num) {
	       	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
			
	}
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="init()">
	<!-- 취소성공 Modal영역 -->
	 <div class="modal fade" id="cancleOkModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>신청하신 &의일 취소가 완료되었습니다</h6> 
                    </div>
                    <div class="modal-footer">
                    	<button type="submit" class="btn btn-primary" 
                    	onclick="location.href='${contextPath}/and?g_id=${g_id}'">확인 ${g_id}</button>
                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div>
        </div>
	 </div>
	 
	 <!-- 취소불가 Modal영역 -->
	 <div class="modal fade" id="cancleFailModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	 	<div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>수령시간 30분전까지만 취소가 가능합니다</h6> 
                    </div>
                    <div class="modal-footer">
	                    	<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
                    </div>
                </div>
                </div>
	 </div>
	 
	<div class="container">
			<h2 class="m-5">
			<c:if test="${flag eq 'participate'}">내가 참가한 &분의일</c:if>
			<c:if test="${flag eq 'write'}">내가 쓴 &분의일</c:if>
			</h2>
			<div class="form-group col-sm-12 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th>엔분의일</th><th style="width:300px;">제목</th><th>진행상태</th><th>금액</th><th>날짜</th>
							<c:if test="${flag eq 'write'}"><th>수정/삭제</th><th>신청확인</th></c:if>
							<c:if test="${flag eq 'participate'}"><th>참가자상태</th><th>작성자</th><th>취소</th></c:if>
							
						</tr>
					</thead>
					<c:forEach var="list" items="${searchAndOneList}">
						<c:if test="${flag eq 'write'}">
							<tbody>
								<tr class="arcticleSubject text-center">
									<td>${list.om_num}</td>
									<td>${list.g_name}</td> <!-- 같이먹기/하기/사기 -->
									<td><button type="button" class="btn btn-link" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${list.one_id}&g_id=${list.one_type}'">${list.one_title}</button></td>
									<td>${list.one_state}</td> <!-- 상태 -->
									<td><span class="priceResult"></span></td><span class="price invisible">${list.one_price}</span>
									<td>${list.om_date}</td>
									<td><button type="button" class="btn btn-link" onclick="location.href='${contextPath}/and/modifyAndOnePage.do?one_id=${list.one_id}&g_id=${list.one_type}'">수정</button>
									<button type="button" class="btn btn-link">삭제</button></td>
									<td><button type="button" class="btn btn-link" onclick="location.href='${contextPath}/and/waitonemem.do?one_id=${list.one_id}'">참가신청확인</button></td>
								</tr>
							</tbody>
							</c:if>
							<c:if test="${flag eq 'participate'}">
							<tbody>
								<tr class="arcticleSubject text-center">
									<td>${list.om_num}</td>
									<td>${list.g_name}</td> <!-- 같이먹기/하기/사기 -->
									<td><button type="button" class="btn btn-link" onclick="location.href='${contextPath}/and/detailAndOne.do?one_id=${list.one_id}&g_id=${list.one_type}'">${list.one_title}</button></td><!-- 제목 -->
									<td>${list.one_state}</td> <!-- 상태 -->
									<td><span class="priceResult"></span></td><span class="price invisible">${list.one_price}</span>
									<td>${list.om_date}</td>
									<td>${list.om_state}</td>							
									<td>${list.WRITER_NICKNAME}</td>
									<td><button type="button" class="btn btn-link" onclick="cancelAndOne('${andoneDetail.one_id}','${andoneDetail.one_price}')">취소하기</button></td>
								</tr>
							</tbody>
						</c:if>
					</c:forEach>
					</table>
					</div>
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
</body>
</html>