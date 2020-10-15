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

    .popup-container {
     	width: 800px;
    	z-index: 9999;
/*     	visibility: hidden; */
    	position: absolute;
    	left: 50%;
    	top: 100px;
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
</style>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<script src = "${contextPath}/resources/js/adminSearch.js"></script>
</head>
<body>
<!-- Popup START -->
<div id="popup-container" class="popup-display">
		<div class="popup-container p-5 bg-light m-auto">
		<div class="row m-1">
			<p class="h4">
			문의내역 조회
			</p>		
			<div class="ml-auto">
				<svg width="1em" height="1em" viewBox="0 0 16 16" id="popup-close" class="bi bi-x" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
				</svg>
			</div>
		</div>
		
		<table class="table table-bordered">
		<thead>
			<tr>
				<th>글 번호</th>
				<td id="detail_q_id"></td>
				<th>문의유형</th>
				<td id="detail_q_type"></td>
			</tr>
			<tr>
				<th>작성자ID</th>
				<td id="detail_m_id"></td>
				<th>처리상태</th>
				<td id="detail_q_state"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3" id="detail_q_subject"></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="4" id="detail_q_content" class="p-3"></td>
			</tr>
			<tr>
				<td>작성일시</td>
				<td colspan="3" id="detail_q_date"></td>
			</tr>
		</tbody>
		</table>
<!-- 		<form name="frmDetail"> -->
		<div class="mx-auto">
	    	<!-- 에디터 -->
			<textarea class="form-control" id="detail_q_reply" name="q_reply" rows="5">
			</textarea>
			<script>CKEDITOR.replace('detail_q_reply',{filebrowserUploadUrl:'${contextPath}/editorFileUpload.do'});</script>
		</div>	
		<div class="form-inline">
			<div class="mt-2 ml-auto">
				<select class="form-control mr-1" id="edit_q_state" name="q_state">
		  		<option value="0">처리상태</option>
			      <c:forEach var="sList" items="${qStateList}">
				      <option value="${sList.gc_id}">${sList.gc_name}</option>
			      </c:forEach>
				</select>
				<button type="button" id="editState" class="btn btn-primary mr-1">상태변경</button>
				<button type="button" id="saveReply" class="btn btn-secondary">답변작성</button>
			</div>
		</div>
<!-- 		</form> -->
	</div>
</div>
<!-- Popup END -->

<div class="container">
			<h2 class="m-5">${title}</h2>
			<div class="form-group col-sm-11 mx-auto p-0">
			<!-- 검색폼 START -->
			<form action="" method="post">
			<div class="input-group mb-3 col-8 ml-auto">
			<!-- 구분  -->
			 <div class="input-group-prepend">
			      <label class="input-group-text" for="inputGroupSelect01">검색조건</label>
		      </div>
				  <c:if test="${title eq '전체문의'}">
					  <select class="custom-select" id="inputGroupSelect01" name="searchOptionState">
					    <option value="0">처리상태</option>
					      <c:forEach var="sList" items="${qStateList}">
						      <option value="${sList.gc_id}">${sList.gc_name}</option>
					      </c:forEach>
					  </select>
				  </c:if>
				  <select class="custom-select" id="inputGroupSelect02" name="searchOptionType">
				    <option value="0">유형</option>
				      <c:forEach var="tList" items="${qTypeList}">
					      <option value="${tList.gc_id}">${tList.gc_name}</option>
				      </c:forEach>
				  </select>
			    <select class="custom-select" id="inputGroupSelect03" name="searchOptionIdOrUser">
				    <option value="1">글번호</option>
				    <option value="2">작성자</option>
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
							<th>문의번호</th><th>분류</th>
							<c:if test="${title eq '전체문의'}">
								<th>처리상태</th>
							</c:if>
							<th style="width:300px;">제목</th><th>작성자ID</th><th>날짜</th><th>내용보기</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${articleList}">
						<tr class="text-center" id="${list.q_id}">
							<td>${list.q_id}</td><td>${list.q_type}</td>
							<c:if test="${title eq '전체문의'}">
								<td>${list.q_state}</td>
							</c:if>
							<td class="text-left">${list.q_subject}</td><td>${list.m_id}</td><td>${list.q_date}</td>
							<td><a class="btn btn-sm btn-outline-secondary searchDetail">확인</a></td>
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