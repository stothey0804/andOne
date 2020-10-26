<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	var point = '${point}'!=''?'${point}':'0';
	
	function pointToNumFormat(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// load시 
	function changePointFormat(){
		let pointList = document.getElementsByClassName('changePoint');
		for(let key in pointList){
			if((pointList[key].innerHTML)>0){
				pointList[key].innerHTML = '+'+pointToNumFormat(pointList[key].innerHTML);
				pointList[key].classList.add('text-success');
			}else{
				pointList[key].innerHTML = pointToNumFormat(pointList[key].innerHTML);
				pointList[key].classList.add('text-danger');
			}
			
		}
	}
	
</script>
</head>
<body onload="changePointFormat()">
<div class="container mx-auto p-5">
	<h3>포인트 사용이력</h3>
	<hr>
	<!-- 회원정보 요약  -->
	<div class="card mx-5 mt-5">
		<div class="card-body">
			<h5 class="card-title">현재 포인트</h5>
			<div class="row card-text mx-3">
				<p id="detailNowPoint" class="h3"></p>
				<script>document.getElementById('detailNowPoint').innerHTML = pointToNumFormat(point)+"P";</script>
				<a href="${contextPath}/point/charge.do" class="btn btn-primary ml-auto">충전하기</a>
			</div>
		</div>
	</div>
	<!-- 포인트 내역 요약 -->
	<div class="mx-5 mt-3">
		<table class="table">
		  <thead>
		    <tr class="text-center">
		      <th scope="col">이력번호</th>
		      <th scope="col" style="width:30%">이용내역</th>
		      <th scope="col">변동포인트</th>
		      <th scope="col">누적포인트</th>
		      <th scope="col">이용일자</th>
		    </tr>
		  </thead>
		  <tbody>
		  <!-- forEach 시작 -->
		  <c:forEach var="list" items="${pointList}">
		    <tr>
		      <td scope="row" class="text-center">${list.p_id}</td>
		      <td>${list.p_detail}</td>
		      <td class="text-center changePoint">${list.p_changepoint}</td>
		      <td class="text-center">${list.p_currentpoint}</td>
		      <td class="text-center">${list.p_date}</td>
		    </tr>
		  </c:forEach><!-- forEach 끝 -->
		  </tbody>
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