<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script type="text/javascript">
$(document).ready(function(){
		$('.clickArea').click(function(){
			var allClass = $(this).attr('class');
			var classArr = allClass.split(' ');
			var id = $(this).attr('id');
			var table = classArr[0];
			searchDetail(table,id);
		})
	})
	
	function searchDetail(table, id){
		var path = '';
		switch(table){
		case 'SHOP': path = '${contextPath }/shop/localShopDetail.do?s_id='+id; break;
		case 'NOTICE': path = '${contextPath }/notice.do'; break;
		case 'CLUB': path = '${contextPath }/club/detailClub.do?c_id='+id; break;
		case 'C_ARTICLE': path = '${contextPath }/club/detailClub.do?c_id='+id; break;
		case 'AND_ONE': 
			var g_id = $('input#'+id).val();
			path = '${contextPath }/and/detailAndOne.do?one_id='+id; 
			path += '&g_id=' + g_id;
			break;
		}
		window.location.href = path;
	}
</script>
<style type="text/css">
    
</style>
</head>
<body>
	<div class="container my-5 center">
		<div class="resultBox">
			<c:choose>
			<c:when test="${tableName eq 'SHOP' }">
				<table class="table table-hover">
					<tr>
						<th>업체명</th>
						<th>업체 소개</th>
						<th>평점</th>
						<th>대표번호</th>
					</tr>
					<c:forEach var="i" begin="0" end="${(fn:length(resultList))-1 }">
							<tr class="SHOP clickArea" id="${resultList[i].S_ID }">
								<td>
									${resultList[i].S_NAME }
								</td>
								<td>
									${resultList[i].S_CONTENT }
								</td>
								<td>
									${resultList[i].S_SCORE }
								</td>
								<td>
									${resultList[i].S_PHONENUMBER }
								</td>
							</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:when test="${tableName eq 'AND_ONE' }">
				<table class="table table-hover">
					<tr>
						<th>제목</th>
						<th>설명</th>
						<th>모집인원</th>
						<th>위치</th>
						<th>날짜</th>
					</tr>
					<c:forEach var="i" begin="0" end="${(fn:length(resultList))-1 }">
						<input type="hidden" id="${resultList[i].ONE_ID }" value="${resultList[i].ONE_TYPE }"/>
							<tr class="AND_ONE clickArea" id="${resultList[i].ONE_ID }">
								<td>
									${resultList[i].ONE_TITLE }
								</td>
								<td>
									${resultList[i].ONE_CONTENT }
								</td>
								<td>
									${resultList[i].ONE_MEMBERMAX }
								</td>
								<td>
									${resultList[i].ONE_ADDR }
								</td>
								<td>
									${resultList[i].ONE_DATE }
								</td>
							</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:when test="${tableName eq 'CLUB' }">
				<table class="table table-hover">
					<tr>
						<th>소모임명</th>
						<th>소모임 소개</th>
						<th>멤버수</th>
						<th>개설일</th>
					</tr>
					<c:forEach var="i" begin="0" end="${(fn:length(resultList))-1 }">
							<tr class="CLUB clickArea" id="${resultList[i].C_ID }">
								<td>
									${resultList[i].C_NAME }
								</td>
								<td>
									${resultList[i].C_CONTENT }
								</td>
								<td>
									${resultList[i].C_MEMBERCNT }
								</td>
								<td>
									${resultList[i].C_OPENINGDATE }
								</td>
							</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:when test="${tableName eq 'C_ARTICLE' }">
				<table class="table table-hover">
					<tr>
						<th>글 번호</th>
						<th>글 내용</th>
						<th>작성일</th>
					</tr>
					<c:forEach var="i" begin="0" end="${(fn:length(resultList))-1 }">
							<tr class="C_ARTICLE clickArea" id="${resultList[i].C_ID }">
								<td>
									${resultList[i].CA_ID }
								</td>
								<td>
									${resultList[i].CA_CONTENT }
								</td>
								<td>
									${resultList[i].CA_DATE }
								</td>
							</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:when test="${tableName eq 'NOTICE' }">
				<table class="table table-hover">
					<tr>
						<th>글 번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성일자</th>
					</tr>
					<c:forEach var="i" begin="0" end="${(fn:length(resultList))-1 }">
							<tr class="NOTICE clickArea" id="${resultList[i].N_ID }">
								<td>
									${resultList[i].N_ID }
								</td>
								<td>
									${resultList[i].N_TITLE }
								</td>
								<td>
									${resultList[i].N_CONTENT }
								</td>
								<td>
									${resultList[i].N_DATE }
								</td>
							</tr>
					</c:forEach>
				</table>
			</c:when>
		</c:choose>
		</div>
		<div class="paging">
		<!-- 페이징  -->
		<nav aria-label="Page navigation example">
		    <ul class="pagination justify-content-center">
		        <c:if test="${pagination.curRange ne 1 }">
		            <li class="page-item">
		            <a class="page-link" href="?curPage=1&searchKeyword=${searchKeyword }&tableName=${tableName }">처음</a> 
		            </li>
		        </c:if>
		        <c:if test="${pagination.curPage ne 1}">
		            <li class="page-item">
		                <a class="page-link" href="?curPage=${pagination.prevPage}&searchKeyword=${searchKeyword }&tableName=${tableName }">이전</a> 
		                </li>
		        </c:if>
		        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
		            <c:choose>
		                <c:when test="${pageNum eq  pagination.curPage}">
		                    <li class="page-item active">
		                        <a class="page-link" href="?curPage=${pageNum}&searchKeyword=${searchKeyword }&tableName=${tableName }">${pageNum }</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                    <li class="page-item">
		                        <a class="page-link" href="?curPage=${pageNum}&searchKeyword=${searchKeyword }&tableName=${tableName }">${pageNum }</a>
		                    </li>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
		            <li class="page-item">
		                <a class="page-link" href="?curPage=${pagination.nextPage}&searchKeyword=${searchKeyword }&tableName=${tableName }">다음</a> 
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