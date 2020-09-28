<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<script>
		//prop 사용시 checked true/false 출력
		$(document).ready(function(){
        	//체크박스 전체선택
        	$(".check_group").on("click","#check_all", function(){
            var checked = $(this).is(":checked");

				if(checked){
					$(this).parents(".check_group").find("input").prop("checked",true);
				}else{
					$(this).parents(".check_group").find("input").prop("checked",false);
				}
        	});
			//체크박스 개별선택
			$(".check_group").on("click",".term", function(){
				var is_checked = true;

				$(".check_group .term").each(function(){
					is_checked = is_checked && $(this).is(":checked");
				});
				$("#check_all").prop("checked", is_checked);
			});
			//모두 동의후 다음단계
			$("#next").click(function(){
				if($('#check_all').prop("checked") == false ){
					alert("모든약관에 동의해야합니다");
				}else{
					//joinform.do로 보내기
					var term = document.term;
					term.action = "${contextPath}/biz/joinform.do?";
					term.method = "post";
					term.submit();
				}
			})
		});
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="term">
		<div class="check_group col-lg-8 col-sm-10 mx-auto mt-5">
			<p class="h4 mb-3"> 업체 서비스 이용약관 </p>
			<div class="form-check my-2">
				<label class="form-check-label" for="check_all">
				<input class="form-check-input" type="checkbox" id="check_all"> 모든 약관에 동의합니다
				</label>
			</div>
			<div class="form-check my-2">
				<textarea class="form-control" id="exampleFormControlTextarea1" rows="3">이용약관ㅠ</textarea><br>
				<label class="form-check-label" for="check_1">
				<input class="term form-check-input" type ="checkbox" id="check_1" >(필수) 위의 약관에 동의합니다 </label><br>
			</div>
			<div class="form-check my-2">
				<textarea class="form-control" id="exampleFormControlTextarea1" rows="3">이용약관ㅠ</textarea><br>
				<label class="form-check-label" for="check_2">
				<input class="term form-check-input" type ="checkbox" id="check_2" >(필수) 위의 약관에 동의합니다</label>
			</div>
				<input type="button" id="next" class="btn btn-primary btn-lg btn-block mt-4" value="이용약관에 동의하고 가입하기">	
		</div>
	</form>
</body>
</html>