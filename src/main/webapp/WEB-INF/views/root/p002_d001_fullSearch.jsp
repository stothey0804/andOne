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
 		if(id == 'detail'){
 			var path = '${contextPath }/searchDetail.do?';
 			path += 'searchKeyword=${searchKeyword }';
 			path += '&tableName='+table;
 			window.location.href = path;
 		}else{
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
 	}
 	
</script>
<style type="text/css">
   	#content div{
   	
   	}
</style>
</head>
<body>
	<div class="container my-5 center">
		<div class="resultBox" id="and_one">
			<h3><a href="${contextPath }">&분의일 ></a></h3><br>
					<c:choose>
						<c:when test="${empty searchResult.and_oneList }">
							<h5>검색결과가 없습니다.</h5><br>
						</c:when>
						<c:otherwise>
							<table class="table table-hover">
								<tr>
									<th>제목</th>
									<th>설명</th>
									<th>모집인원</th>
									<th>위치</th>
									<th>날짜</th>
								</tr>
								<c:forEach var="i" begin="0" end="${(fn:length(searchResult.and_oneList))-1 }">
										<input type="hidden" id="${searchResult.and_oneList[i].ONE_ID }" value="${searchResult.and_oneList[i].ONE_TYPE }"/>
										<tr class="AND_ONE clickArea" id="${searchResult.and_oneList[i].ONE_ID }">
											<td>
												${searchResult.and_oneList[i].ONE_TITLE }
											</td>
											<td>
												${searchResult.and_oneList[i].ONE_CONTENT }
											</td>
											<td>
												${searchResult.and_oneList[i].ONE_MEMBERMAX }
											</td>
											<td>
												${searchResult.and_oneList[i].ONE_ADDR }
											</td>
											<td>
												${searchResult.and_oneList[i].ONE_DATE }
											</td>
										</tr>
								</c:forEach>
								<c:if test="${searchResult.and_oneCnt > 3}">
									<tr class="AND_ONE clickArea" id="detail">
										<td colspan="5" align="center">검색결과 ${(searchResult.and_oneCnt - 3) }건 더 보기</td>
									</tr>
								</c:if>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
		<div class="resultBox" id="shop">
			<h3><a href="${contextPath }/shop/localShopMain.do">지역업체 ></a></h3><br>
					<c:choose>
						<c:when test="${empty searchResult.shopList }">
							<h5>검색결과가 없습니다.</h5><br>
						</c:when>
						<c:otherwise>
							<table class="table table-hover">
								<tr>
									<th>업체명</th>
									<th>업체 소개</th>
									<th>평점</th>
									<th>대표번호</th>
								</tr>
								<c:forEach var="i" begin="0" end="${(fn:length(searchResult.shopList))-1 }">
										<tr class="SHOP clickArea" id="${searchResult.shopList[i].S_ID }">
											<td>
												${searchResult.shopList[i].S_NAME }
											</td>
											<td>
												${searchResult.shopList[i].S_CONTENT }
											</td>
											<td>
												${searchResult.shopList[i].S_SCORE }
											</td>
											<td>
												${searchResult.shopList[i].S_PHONENUMBER }
											</td>
										</tr>
								</c:forEach>
								<c:if test="${searchResult.shopCnt > 3}">
									<tr class="SHOP clickArea" id="detail">
										<td colspan="5" align="center">검색결과 ${(searchResult.shopCnt - 3) }건 더 보기</td>
									</tr>
								</c:if>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
		<div class="resultBox" id="club">
			<h3><a href="${contextPath }/club/clubMain.do">소모임 ></a></h3><br>
					<c:choose>
						<c:when test="${empty searchResult.clubList }">
							<h5>검색결과가 없습니다.</h5><br>
						</c:when>
						<c:otherwise>
							<table class="table table-hover">
								<tr>
									<th>소모임명</th>
									<th>소모임 소개</th>
									<th>멤버수</th>
									<th>개설일</th>
								</tr>
								<c:forEach var="i" begin="0" end="${(fn:length(searchResult.clubList))-1 }">
										<tr class="CLUB clickArea" id="${searchResult.clubList[i].C_ID }">
											<td>
												${searchResult.clubList[i].C_NAME }
											</td>
											<td>
												${searchResult.clubList[i].C_CONTENT }
											</td>
											<td>
												${searchResult.clubList[i].C_MEMBERCNT }
											</td>
											<td>
												${searchResult.clubList[i].C_OPENINGDATE }
											</td>
										</tr>
								</c:forEach>
								<c:if test="${searchResult.clubCnt > 3}">
									<tr class="CLUB clickArea" id="detail">
										<td colspan="5" align="center">검색결과 ${(searchResult.clubCnt - 3) }건 더 보기</td>
									</tr>
								</c:if>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
		<div class="resultBox" id="club_article">
			<h3><a href="${contextPath }/club/clubMain.do">소모임 게시글 ></a></h3><br>
					<c:choose>
						<c:when test="${empty searchResult.c_articleList }">
							<h5>검색결과가 없습니다.</h5><br>
						</c:when>
						<c:otherwise>
							<table class="table table-hover">
								<tr>
									<th>글 번호</th>
									<th>글 내용</th>
									<th>작성일</th>
								</tr>
								<c:forEach var="i" begin="0" end="${(fn:length(searchResult.c_articleList))-1 }">
										<tr class="C_ARTICLE clickArea" id="${searchResult.c_articleList[i].C_ID }">
											<td>
												${searchResult.c_articleList[i].CA_ID }
											</td>
											<td>
												${searchResult.c_articleList[i].CA_CONTENT }
											</td>
											<td>
												${searchResult.c_articleList[i].CA_DATE }
											</td>
										</tr>
								</c:forEach>
								<c:if test="${searchResult.c_articleCnt > 3}">
									<tr class="C_ARTICLE clickArea" id="detail">
										<td colspan="5" align="center">검색결과 ${(searchResult.c_articleCnt - 3) }건 더 보기</td>
									</tr>
								</c:if>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
		<div class="resultBox" id="notice">
			<h3><a href="${contextPath }/notice.do">공지사항 ></a></h3><br>
					<c:choose>
						<c:when test="${empty searchResult.noticeList }">
							<h5>검색결과가 없습니다.</h5><br>
						</c:when>
						<c:otherwise>
							<table class="table table-hover">
								<tr>
									<th>글 번호</th>
									<th>제목</th>
									<th>내용</th>
									<th>작성일자</th>
								</tr>
								<c:forEach var="i" begin="0" end="${(fn:length(searchResult.noticeList))-1 }">
										<tr class="NOTICE clickArea" id="${searchResult.noticeList[i].N_ID }">
											<td>
												${searchResult.noticeList[i].N_ID }
											</td>
											<td>
												${searchResult.noticeList[i].N_TITLE }
											</td>
											<td>
												${searchResult.noticeList[i].N_CONTENT }
											</td>
											<td>
												${searchResult.noticeList[i].N_DATE }
											</td>
										</tr>
								</c:forEach>
								<c:if test="${searchResult.noticeCnt > 3}">
									<tr class="NOTICE clickArea" id="detail">
										<td colspan="5" align="center">검색결과 ${(searchResult.noticeCnt - 3) }건 더 보기</td>
									</tr>
								</c:if>
							</table>
						</c:otherwise>
					</c:choose>
		</div>
	</div>
</body>
</html>