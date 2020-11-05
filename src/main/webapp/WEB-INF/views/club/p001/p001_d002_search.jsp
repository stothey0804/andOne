<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>소모임 목록</title>
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
	    
	    .modal{
	    	z-index: 9999;
	    }
		
	</style>
	<script src = "${contextPath}/resources/js/adminSearch.js"></script>
	
<script type="text/javascript">
	function openMemberPopup2(m_id){
		window.open("${contextPath}/member/searchMemberInfoPopup.do?m_id="+m_id, "_blank", "resizable=no,top=0,left=0,width=450,height=500");
	}
</script>
</head>

<body>
<div class="container">
	<h2 class="m-5">소모임 조회</h2>
	<div class="form-group col-sm-11 mx-auto p-0">
		<!-- 검색폼 START -->
		<form action="searchClubList.do" method="post">
			<div class="input-group mb-3 col-6 ml-auto">
			<!-- 구분  -->
			 <div class="input-group-prepend">
			      <label class="input-group-text" for="inputGroupSelect01">검색조건</label>
		      </div>
   		    <select class="custom-select" name="searchCondition">
				<option value="c_name">소모임명</option>
				<option value="leaderId">리더ID</option>
		    </select>
			  <input type="text" name="searchKeyword" class="form-control searchValue" aria-describedby="button-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
			  </div>
			</div>
		</form>
		<!-- 검색폼 END -->
		<!-- 리스트영역  -->
			<table class="table result">
				<thead>
				<tr class="text-center">
					<th>No.</th>
					<th>카테고리</th>
					<th>소모임명</th>
					<th>리더ID</th>
					<th>만든일</th>
					<th>상세보기</th>
				</tr>
				</thead>
				<c:forEach items="${clubList}" var="club" varStatus="status">
				<tr>
					<td class="text-center">${status.count }</td>
					<td class="text-center">${club.gc_name}</td>
					<td class="text-center">${club.c_name}</td>
					<td class="text-center">
						<a href="javascript:void(0);" onclick="openMemberPopup2('${club.leaderId}');">
							${club.leaderId}
						</a>
					</td>
					<td class="text-center">${club.c_openingdate}</td>
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