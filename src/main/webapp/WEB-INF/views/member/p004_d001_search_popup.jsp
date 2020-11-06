<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보조회</title>

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

<script>

</script>
<style type="text/css">
	div.memberInfo{
	    padding: 1.5em;
	    width: 450px;
	    height: 500px;
	}

	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.arcticleSubject{
		cursor: pointer;
	}
	
	.text-over-cut {
	  display: block;
	  width: 150px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  margin: 0;
	}
</style>
<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="${contextPath}/resources/css/font.css">
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
<!-- font Awesome -->
<script src="https://kit.fontawesome.com/cdac256c63.js" crossorigin="anonymous"></script>
<script>
// 초기화시, 선택정보 영역 set
$(document).ready(function(){
	$(".arcticleSubject div").click(function(){
	  	let id = getArticleId(this);
	    $("#"+id + " .arcticleBody").toggle();	// id get
	});
	
	// 수정
	$(".editContent").click(function(){
		let id = getArticleId(this);	
		editReview(id);
	});
	
	// 삭제
	$(".deleteArticle").click(function(){
		let id = getArticleId(this);	
		if(confirm("삭제 하시겠습니까?")){
			let frm = document.createElement('form');
			// 동적 form 생성
			frm.action = "${contextPath}/member/deleteReview.do";
			// form에 연결
			let input = document.createElement('input');
			input.setAttribute("type","hidden");
			input.setAttribute("name","mr_id");
			input.setAttribute("value", id);
			frm.appendChild(input);	// append id
			document.body.appendChild(frm);	// append form
			frm.submit();
		}
	});
	
	function getArticleId(elem){
		let result =  $("tbody").has(elem);
		return result.attr("id");
	}
	
	function editReview(id){
		let frm = document.createElement('form');
		window.open("${contextPath}/member/editReview.do", "popupOpener", "resizable=no,top=0,left=0,width=450,height=500");
		frm.target = "popupOpener";// target설정
		// 동적 form 생성
		frm.action = "${contextPath}/member/editReview.do";
		// form에 연결
		let input = document.createElement('input');
		input.setAttribute("type","hidden");
		input.setAttribute("name","mr_id");
		input.setAttribute("value", id);
		frm.appendChild(input);	// append id
		document.body.appendChild(frm);	// append form
		frm.submit();
	}
	
});
</script>
</head>
<body class="bg-light">
<div class="m-0 memberInfo">
	<!-- 받은 평가 -->
	<div>
	<div class="row mx-1">
		<p class="h5 mb-3">받은평가 조회</p>
		<a href="${contextPath}/member/searchMemberInfoPopup.do?m_id=${target}" class="ml-auto"><i class="fas fa-arrow-left mr-1"></i>돌아가기</a>	
	</div>
					<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th width="50px">닉네임</th><th>점수</th><th style="width:200px;">제목</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${articleList}">
					<tbody id="${list.mr_id}">
						<tr class="arcticleSubject text-center">
							<td>${list.r_num}</td>
							<td class="text-truncate">
							<a href="${contextPath}/member/searchMemberInfoPopup.do?m_id=${list.m_id}" onclick="window.open(this.href,'_blank','resizable=no,top=0,left=460,width=450,height=500');return false">
								${list.m_nickname}
							</a>
							</td>
							<td class="text-center">${list.mr_score}</td>
							<td class="text-left"><div class="text-over-cut">${list.mr_content}</div></td>
						</tr>
						<!-- 내용영역 -->
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3">
								${list.mr_content}
							<p class="mt-2 text-right">작성일시: ${list.mr_date}</p>
							<c:if test="${m_id eq list.m_id}">
							<div class="form-inline">
								<div class="mt-2 ml-auto">
									<button type="button" class="editContent btn btn-primary mr-1">수정</button>
									<button type="button" class="deleteArticle btn btn-danger">삭제</button>
								</div>
							</div>
							</c:if>
							</td>
						</tr>
						<!-- 내용영역 END -->
					</tbody>
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
