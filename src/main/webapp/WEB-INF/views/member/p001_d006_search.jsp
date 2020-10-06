<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>회원목록</title>
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<style>
/* 		* { */
/* 			margin: 0; */
/* 			padding: 0; */
/* 		} */

		body {
			scrollbar-face-color: #e8e7e3;
		}

		#layer1{
			z-index: 9999;
		}
		.pop-layer .pop-container {
			padding: 15px 25px;
		}

		.pop-layer .btn-r {
			margin: 10px 10px 10px;
			text-align: right;
			position: absolute;
			top: 10px;
			right: 0;
		}

		.pop-layer {
			display: none;
			position: relative;
			top: 50%;
			left: 50%;
			width: 600px;
			height: auto;
			z-index: 10;
		}

		a.btn-layerClose {
			float: right;
			height: 25px;
			padding: 0 14px 0;
			font-size: 13px;
		}

		.btns {
			float: right;
		}

		.btn {
			font-size: 100%;
		}
		.fixed_top {
			display:table;
  			position:absolute;
		}
	</style>
	<script>
		$(function () {
			$('.btn-example').click(function () {
				var $href = $(this).attr('name');
				layer_popup($href);
				console.log($href);
			});
			$('.detail').click(function () {
				var tdArr = new Array();
				var checkBtn = $(this);
				var tr = checkBtn.parent().parent();
				var td = tr.children();
				var userId = td.eq(1).text();
				console.log(userId);

				$.ajax({
					type: "get",
					dataType: "text",
					async: true,
					url: "http://localhost:8090/andOne/popup.do",
					data: { m_id: userId },
					success: function (data, texStatus) {
						jsoninfo = JSON.parse(data);
						$('td.id').html(jsoninfo.m_id);
						$('td.phone').html(jsoninfo.m_phonenumber);
						$('td.email').html(jsoninfo.m_email);
						$('td.gender').html(jsoninfo.m_gender);
						$('td.nickname').html(jsoninfo.m_nickname);
						$('td.age').html(jsoninfo.m_age + "대");
						$('td.m_score').html(jsoninfo.m_score);
						$('td.reportCnt').html(jsoninfo.reportCnt);
						if (jsoninfo.p_currentpoint != null) {
							$('td.p_currentpoint').html(jsoninfo.p_currentpoint);
						} else {
							$('td.p_currentpoint').html("0");
						}
						$('td.qnaCnt').html(jsoninfo.qnaCnt);
						$('td.joinClubCnt').html(jsoninfo.joinClubCnt);
						$('td.reviewCnt').html(jsoninfo.reviewCnt);
						$('.resultList').remove();
						if (jsoninfo.list != "") {
							for (var i in jsoninfo.list) {
								$('table.pointList').append("<tr class='resultList'><td>" + jsoninfo.list[i].one_date + "</td><td>" + jsoninfo.list[i].one_title + "</td><td>" + jsoninfo.list[i].p_changepoint + "</td></tr>");
							}
						} else {
							$('table.pointList').append("<p class='resultList'>포인트이력이 없습니다</p>");
						}
					}
				});
			})

			function layer_popup(el) {
				var $el = $(el);
				console.log($el);
				$el.fadeIn();
				var $elWidth = ~~($el.outerWidth()),
					$elHeight = ~~($el.outerHeight()),
					docWidth = $(document).width(),
					docHeight = $(document).height();
				if ($elHeight < docHeight || $elWidth < docWidth) {
					$el.css({
						marginTop: -$elHeight / 2,
						marginLeft: -$elWidth / 2
					})
				} else {
					$el.css({ top: 0, left: 0 });
				}
				$el.find('a.btn-layerClose').click(function () {
					$el.fadeOut();
					return false;
				});

				$(document).keyup(function (e) {
					if (e.keyCode == 27) {
						$el.fadeOut();
						return false;
					}
				})
			}
		})
	</script>
</head>

<body>
	<!-- 리스트영역  -->
	<div class="p-3 pt-5">
		<form action="getMemberList.do" method="post">
				<table border="0">
					<tr>
						<td width="500"></td>
						<td align="right"><select name="searchCondition">
								<c:forEach items="${conditionMap }" var="option">
								<option value="${option.value }">${option.key }
								</c:forEach>
						</select> <input name="searchKeyword" type="text" /> <input type="submit"
							value="검색" /></td>
				</table>
			</form>
		<br>
		<table class="table result">
			<tr>
				<th>번호</th>
				<th>회원ID</th>
				<th>이메일</th>
				<th>닉네임</th>
				<th>휴대폰번호</th>
				<th>가입일시</th>
				<th>상세정보</th>
			</tr>
			<c:forEach items="${memberList }" var="member" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${member.m_id }</td>
				<td>${member.m_email }</td>
				<td>${member.m_nickname }</td>
				<td>${member.m_phonenumber }</td>
				<td>${member.m_joinDate }</td>
				<td><button name="#layer1" class="btn-example btn btn-secondary detail">상세보기</button></td>
			</tr>
			</c:forEach>
		</table>
	</div>

	<!-- 회원정보 상세 팝업 -->
	<div id="layer1" class="pop-layer bg-light p-3">
		<div class="pop-container">
			<div class="pop-conts">
				<h1 class="product-name"></h1>
				<h1>회원정보 상세</h1>
				<br>
				<div class="btn-r">
					<a href="#" class="btn-layerClose"><img src="${contextPath}/resources/image/x.png" width="20px"
							height="20px"></a>
				</div>
				<h4>회원정보</h4>
				<table class="table">
					<tr>
						<th>회원ID</th>
						<td class="id"></td>
						<th>휴대폰번호</th>
						<td class="phone"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="email"></td>
						<th>성별</th>
						<td class="gender"></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td class="nickname"></td>
						<th>나이대</th>
						<td class="age"></td>
					</tr>
				</table>
				<br>
				<h4>이용정보</h4>
				<table class="table">
					<tr>
						<th>평점</th>
						<td class="m_score"></td>
						<th>신고받은 수</th>
						<td class="reportCnt"></td>
					</tr>
					<tr>
						<th>보유포인트</th>
						<td class="p_currentpoint"></td>
						<th>신고/문의 건수</th>
						<td class="qnaCnt"></td>
					</tr>
					<tr>
						<th>가입한 소모임 수</th>
						<td class="joinClubCnt"></td>
						<th>작성리뷰수</th>
						<td class="reviewCnt"></td>
					</tr>
				</table>
				<br>
				<h4>포인트이력</h4>
				<table class="table">
				<thead>
					<tr>
						<th style="text-align: center;">날짜</th>
						<th style="text-align: center;">내용</th>
						<th style="text-align: center;">사용포인트</th>
					</tr>
				</thead>
				</table>
				<div style="overflow:auto; width:100%; height:150px">
				<table class="table pointList">
					<tbody>
					
					</tbody>
				</table>
				</div>
				<br> <br>
				<button class="btn btn-primary">포인트 지급</button>
				<div class="btns">
					<button class="btn btn-secondary">알림전송</button>
					<button class="btn btn-danger">회원삭제</button>
				</div>
			</div>
		</div>
	</div>

</body>

</html>