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

<!-- JQuery -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src = "${contextPath}/resources/js/ckeditor/ckeditor.js"></script>

<script>
	// 초기화시, 선택정보 영역 set
	$(document).ready(function(){
		$(".arcticleSubject").click(function(){
		  	var id = (event.target).parentNode.parentNode.getAttribute("id");
		    $("#"+id + " .arcticleBody").toggle();
		});
	});
</script>
</head>
<body>
<div class="container">
	<form enctype="multipart/form-data" method="post">
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
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3">
								${list.q_content}
							</td>
						</tr>
						<tr style="display:none;" class="arcticleBody">
							<td colspan="5" class="p-3 bg-light">
							관리자답변: <br>
								${list.q_reply}
							</td>
						</tr>					
					</tbody>
					</c:forEach>
				</table>
			</div>
		</form>
</div>
</body>