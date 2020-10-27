<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
			<h2 class="m-5">
			<c:if test="${flag eq 'participate'}">내가 참가한 &분의일</c:if>
			<c:if test="${flag eq 'write'}">내가 쓴 &분의일</c:if>
			</h2>
			<div class="form-group col-sm-10 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th>엔분의일</th><th style="width:350px;">제목</th><th>상태</th><th>금액</th><th>날짜</th>
							<c:if test="${flag eq 'write'}"><th>수정/삭제</th></c:if>
							<c:if test="${flag eq 'participate'}"><th>작성자</th></c:if>
							
						</tr>
					</thead>
					<c:forEach var="list" items="${searchAndOneList}">
					<c:if test="${flag eq 'write'}">
					<tbody>
						<tr class="arcticleSubject text-center">
							<td>${list.om_num}</td>
							<td>${list.g_name}</td> <!-- 같이먹기/하기/사기 -->
							<td>${list.one_title}</td> <!-- 제목 -->
							<td>${list.one_state}</td> <!-- 상태 -->
							<td>${list.one_price}</td>
							<td>${list.om_date}</td>
							<td>수정/삭제</td>
						</tr>
					</tbody>
					</c:if>
					<c:if test="${flag eq 'participate'}">
					<tbody>
						<tr class="arcticleSubject text-center">
							<td>${list.om_num}</td>
							<td>${list.g_name}</td> <!-- 같이먹기/하기/사기 -->
							<td>${list.one_title}</td> <!-- 제목 -->
							<td>${list.one_state}</td> <!-- 상태 -->
							<td>${list.one_price}</td>
							<td>${list.om_date}</td>
							<td>${list.WRITER_NICKNAME}</td>
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