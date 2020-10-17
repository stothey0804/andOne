<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
 	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> <!-- 위치중요함ㅠ -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
 	<script>
 		//아이디찾기 비밀번호 찾기 화면 변경
        function find_info(num){
            if(num == '1') {
                document.getElementById("findId").style.display = "none";
                document.getElementById("findPwd").style.display = "";
            }else{
                document.getElementById("findPwd").style.display = "none";
                document.getElementById("findId").style.display = "";
            }
        }
	    //아이디찾기
      	var id_value = "";
      	function sendFindId(){
	  	var name = $("#inputName").val();
	  	var phoneNum = $("#inputPhoneNumber").val();
	  	//console.log(phoneNum);
             $.ajax({
                type:"post",
                dataType:"text",
                async: "true", 
                url:"${contextPath}/biz/findId.do",
                data:{
                    "bm_name" : name,
                    "bm_phoneNumber" : phoneNum
                },
                success:function(data,textSataus){
             		$("#findIdModal").modal("show");
                    console.log("아이디 찾기:  "+data);
                    if(data == 0){
                        $("#id_value").text("회원정보를 다시 확인해주세요");
                    }else{
                        $("#id_value").text(data);
                        //아이디값 저장
                        id_value = data;
                    }
                }
             })
      	}
      	//비밀번호 찾기 추후수정
      	$("#pwdFind_Btn").click(function(){
      		console.log(id_value);
     		$("#find_2").prop("checked",true);
     		find_info(1);
     		$("#inputId").attr("value",idv);
     		$("#findIdModal").modal("hide");
      	})
      	
      	
      	
    </script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body onload= "find_info()">
    <div class="col-lg-6 col-sm-10 mx-auto mt-5 ">
        <h3>아이디/비밀번호 찾기</h3>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="findInfo" id="find_1" checked="checked" onclick="find_info(0)">
            <label class="form-check-label" for="find_1">아이디 찾기</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="findInfo" id="find_2" onclick="find_info(1)">
            <label class="form-check-label" for="find_2">비밀번호 찾기</label>
        </div>
        <!--아이디찾기-->
        <div id="findId">
            <div class="form-group col-md-6">
                <label for="inputName" class="font-weight-bold">이름</label>
                <input type="text" class="form-control" id="inputName"  name="inputName" placeholder="이름을 입력해주세요">
            </div>
            <div class="form-group col-md-6">
                <label for="inputPhoneNumber" class="font-weight-bold">휴대폰번호</label>
                <input type="text" class="form-control" id="inputPhoneNumber" name="inputPhoneNumber" placeholder="휴대폰번호를 입력해주세요">
            </div>
            <!--modal창-->
            <div class="form-group">
                <button type="button" onclick="sendFindId();"  class="btn btn-primary col-md-6">확인</button><br><br>
                <button onclick="location.href='${contextPath}/biz/loginPage.do'" class="btn btn-primary col-md-6">취소</button>
            </div>
            <!-- Modal영역 -->
            <div class="modal fade" id="findIdModal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body" id="ModalLabel">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6>고객님의 정보와 일치하는 아이디입니다</h6> 
                        <h5 id="id_value"></h5>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="pwdFind_Btn" >비밀번호 찾기</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div>
                </div>
            </div>
        </div>
        <!--비밀번호찾기-->
        <div id="findPwd" style="display: none;">
            <div class="form-group col-md-6">
                <label for="inputId" class="font-weight-bold">아이디</label>
                <input type="text" class="form-control" id="inputId"  name="inputId" placeholder="아이디를 입력해주세요">
            </div>
            <div class="form-group col-md-6">
                <label for="inputEmail" class="font-weight-bold">이메일주소</label>
                <input type="text" class="form-control" id="inputEmail"  name="inputEmail" placeholder="이메일주소를 입력해주세요">
            </div>
            <div class="form-group">
                <button id="findBtn2" onclick="sendFindPwd()" class="btn btn-primary col-md-6">확인</button><br><br>
                <button onclick="location.href='${contextPath}/biz/loginPage.do'" class="btn btn-primary col-md-6">취소</button>
            </div>
        </div>
                
    </div>
</body>
</html>