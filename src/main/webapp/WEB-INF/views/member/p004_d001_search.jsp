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
/* 	@media screen and (max-width: 1000px){ */
/* 		div.form-group{ */
/* 			width: 90%; */
/* 		} */
/* 	} */
 	.container{ 
		margin: 0 auto;
	}
	
	.arcticleSubject{
		cursor: pointer;
	}
	
	tbody{
		border-top-width: 0px !important;
	}
	.text-over-cut {
	  display: block;
	  width: 300px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  margin: 0;
	}

</style>

<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>

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
<body>
<div class="container">
			<h2 class="m-5">
			<c:if test="${flag eq 'recieve'}">내가 받은 회원평가</c:if>
			<c:if test="${flag eq 'write'}">내가 쓴 회원평가</c:if>
			</h2>
			<div class="form-group col-sm-10 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th><th>닉네임</th><th>점수</th><th style="width:400px;">제목</th><th>날짜</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${articleList}">
					<tbody id="${list.mr_id}">
						<tr class="arcticleSubject text-center">
							<td>${list.r_num}</td>
							<td>
								<c:if test="${flag eq 'recieve'}">
									<a href="${contextPath}/member/searchMemberInfoPopup.do?m_id=${list.m_id}" onclick="window.open(this.href,'_blank','resizable=no,top=0,left=0,width=450,height=500');return false">
									${list.m_nickname}
									</a>
								</c:if>
								<c:if test="${flag eq 'write'}">
									<a href="${contextPath}/member/searchMemberInfoPopup.do?m_id=${list.mr_target}" onclick="window.open(this.href,'_blank','resizable=no,top=0,left=0,width=450,height=500');return false">
									${list.target_nickname}
									</a>
								</c:if>
							</td>
							<td class="text-center">${list.mr_score}점</td>
							<td class="text-left"><div class="text-over-cut">${list.mr_content}</div></td>
							<td>${list.mr_date}</td>
						</tr>
						<!-- 내용영역 -->
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3">
								${list.mr_content}
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