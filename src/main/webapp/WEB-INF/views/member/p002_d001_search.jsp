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
/* 	.container{ */
		margin: 0 auto;
	}
	#cke_q_content{
		width: 95%;
		margin: 0 auto;
	}
	.arcticleSubject{
		cursor: pointer;
	}
	tbody{
		border-top-width: 0px !important;
	}

</style>


<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		$(".arcticleSubject").click(function(){
		  	let id = getArticleId(this);
		    $("#"+id + " .arcticleBody").toggle();	// q_id get
		});
		
		// 수정
		$(".editContent").click(function(){
			let id = getArticleId(this);	// q_id get
			dynamicFormInsert(id,"qna");
		});
		
		// 삭제
		$(".deleteArticle").click(function(){
			let id = getArticleId(this);	// q_id get
			if(confirm("삭제 하시겠습니까?")){
				dynamicFormInsert(id, "deleteMemberQnA");
			}
		});
		
		function getArticleId(elem){
			let result =  $("tbody").has(elem);
			return result.attr("id");
		}
		
		function dynamicFormInsert(id, dest){
			// 동적 form 생성
			let frm = document.createElement('form');
			frm.name = "frmQnA";				
			frm.action = "${contextPath}/member/"+dest+".do";
			// form에 연결
			let input = document.createElement('input');
			input.setAttribute("type","hidden");
			input.setAttribute("name","q_id");
			input.setAttribute("value",id);
			frm.appendChild(input);	// append q_id
			document.body.appendChild(frm);	// append form
			frm.submit();
		}
	});
</script>
</head>
<body>
<div class="container">
			<h2 class="m-5">문의내역</h2>
			<div class="form-group col-sm-10 mx-auto p-0">
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>문의번호</th><th>분류</th><th style="width:400px;">제목</th><th>날짜</th><th>처리상태</th>
						</tr>
					</thead>
					<c:forEach var="list" items="${articleList}">
					<tbody id="${list.q_id}">
						<tr class="arcticleSubject text-center">
							<td>${list.q_id}</td><td>${list.q_type}</td><td class="text-left">${list.q_subject}</td><td>${list.q_date}</td><td>${list.q_state}</td>
						</tr>
						<!-- 내용영역 -->
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3">
								${list.q_content}
							<div class="form-inline">
								<div class="mt-2 ml-auto">
									<button type="button" class="editContent btn btn-primary mr-1">수정</button>
									<button type="button" class="deleteArticle btn btn-danger">삭제</button>
								</div>
							</div>
							</td>
						</tr>
						<!-- 내용영역 END -->
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3 bg-light">
							관리자답변: <br>
								${list.q_reply}
							</td>
						</tr>					
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