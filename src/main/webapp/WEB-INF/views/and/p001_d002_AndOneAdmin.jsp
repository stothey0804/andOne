<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
	div.form-group{
	width: 100%;
	}
 	.container{ 
		margin: 0 auto;
	}
	.searchValue{
		width: 100px !important;
	}
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
			<h2 class="m-5">&분의일 게시글 조회</h2>
			<div class="form-group col-sm-11 mx-auto p-0">
			<!-- 검색폼 START -->
			<form action="" method="post">
			<div class="input-group mb-3 col-8 ml-auto">
			<!-- 구분  -->
			 <div class="input-group-prepend">
			      <label class="input-group-text" for="inputGroupSelect01">검색조건</label>
		      </div>
				  <select class="custom-select" id="inputGroupSelect01" name="searchOptionState">
				    <option value="0">구분</option>
				      <c:forEach var="sList" items="${qStateList}">
					      <option value="${sList.gc_id}">${sList.gc_name}</option>
				      </c:forEach>
				  </select>
				  <select class="custom-select" id="inputGroupSelect02" name="searchOptionType">
				    <option value="0">카테고리</option>
				      <c:forEach var="tList" items="${qTypeList}">
					      <option value="${tList.gc_id}">${tList.gc_name}</option>
				      </c:forEach>
				  </select>
			    <select class="custom-select" id="inputGroupSelect03" name="searchOptionIdOrUser">
				    <option value="1">제목</option>
				    <option value="2">작성자ID</option>
			    </select>
			  <input type="text" name="searchValue" class="form-control searchValue" placeholder="" aria-describedby="button-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			  </div>
			</div>
			</form><!-- 검색폼 END -->
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>구분</th><th>카테고리</th><th>글번호</th><th style="width:300px;">제목</th>
							<th>작성자ID</th><th>처리상태</th><th>조회</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${articleList}">
						<tr class="text-center" id="${list.q_id}">
							<td>${list.q_id}</td><td>${list.q_type}</td>
							<c:if test="${title eq '전체문의'}">
								<td>${list.q_state}</td>
							</c:if>
							<td class="text-left">${list.q_subject}</td><td>${list.m_id}</td><td>${list.q_date}</td>
							<td><a class="btn btn-sm btn-outline-secondary searchDetail">내용확인</a></td>
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