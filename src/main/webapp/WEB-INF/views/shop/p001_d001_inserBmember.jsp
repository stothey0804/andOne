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
	<style>
        h3 {
            font-weight: bold;
        }
    </style>
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script>
        $(document).ready(function(){
	        //아이디 중복검사 (1 = 중복/ 0 != 중복)
	        //blur 아이디입력후 포커스 나왔을때 함수실행
            $("#bm_id").blur(function(){
                var bm_id = $("#bm_id").val();
                if(bm_id == ""){
                	$(".id_check").text("아이디를 입력해주세요");
                   	$(".id_check").css("color","red");
                	$("#bm_id").removeClass("is-valid");
                	$("#bm_id").addClass("is-invalid");
                  /*   $("#submit").attr("disabled",true); */
                }else{
	                $.ajax({
	                    type:"post",
	                    dataType:"text",
	                    async: "true",
	                    url:"${contextPath}/biz/idCheck",
	                    data: {"bm_id":bm_id},
	                    success:function(data,textSataus){
	                        console.log("중복확인(1/0) :"+data);
	                        if(data == 1){ //아이디 중복
	                            $(".id_check").text("사용 중인 아이디입니다");
	                            $(".id_check").css("color","red");
	                            $("#bm_id").removeClass("is-valid");
	                        	$("#bm_id").addClass("is-invalid");
	                            /*$("#submit").attr("disabled",true); */
	                        }else{ //아이디가 중복이 아닐경우
	                        	$("#bm_id").removeClass("is-invalid");
	                        	$("#bm_id").addClass("is-valid");
	                        }
                    	}
                	});
                }
            })
	        //비밀번호 확인
            $("#bm_pwd_2").blur(function(){
                var pwd1 = $("#bm_pwd").val();
                var pwd2 = $("#bm_pwd_2").val();
                console.log(pwd1);

              if(pwd1 != "" && pwd2 == ""){//비밀번호 확인 입력 안했을때
                    $(".pwd_check").text("비밀번호를 재입력해주세요");
                    $(".pwd_check").css("color","red");
                    $("#bm_pwd_2").removeClass("is-valid");
                	$("#bm_pwd_2").addClass("is-invalid");
                }else if(pwd1 !="" && pwd2 != ""){ 
                    if(pwd1 == pwd2){ // 비밀번호 일치
                        $(".pwd_check").text("비밀번호가 일치합니다");
                        $("#bm_pwd_2").removeClass("is-invalid");
                    	$("#bm_pwd_2").addClass("is-valid");
                    }else if(pwd1 != pwd2) {
                        $(".pwd_check").text("비밀번호가 일치하지 않습니다");
                        $(".pwd_check").css("color","red");
                        $("#bm_pwd_2").removeClass("is-valid");
                    	$("#bm_pwd_2").addClass("is-invalid");
                    }
                }
            })
	        //이름 공백체크
	        $("#bm_name").blur(function(){
	        	var bm_name = $("#bm_name").val();
	           	if(bm_name == ""){
	            	$(".name_check").text("이름을 입력해주세요");
                    $(".name_check").css("color","red");
                    $("#bm_name").removeClass("is-valid");
                	$("#bm_name").addClass("is-invalid");;
	            }else{
	            	$("#bm_name").removeClass("is-invalid");
                	$("#bm_name").addClass("is-valid");
	            }
	        })
	        //번호 공백체크
	        $("#bm_phoneNumber").blur(function(){
	        	var bm_phoneNumber = $("#bm_phoneNumber").val();
	        	var getNum = RegExp(/^01([0|1|6|7|8|9]?)-?([0-9]{4})-?([0-9]{4})$/);
	            if(bm_phoneNumber == ""){
	            	$(".number_check").text("휴대폰 번호를 입력해주세요");
	                $(".number_check").css("color","red");
	                $("#bm_phoneNumber").removeClass("is-valid");
                	$("#bm_phoneNumber").addClass("is-invalid");
	            }else if(!getNum.test(bm_phoneNumber)){ //번호 형식 확인
                	$(".number_check").text("휴대폰 번호 형식이 맞지않습니다");
                    $(".number_check").css("color","red");
                    $("#bm_phoneNumber").removeClass("is-valid");
                	$("#bm_phoneNumber").addClass("is-invalid");
                }else{
                	$("#bm_phoneNumber").removeClass("is-invalid");
                	$("#bm_phoneNumber").addClass("is-valid");
                }
	        });
	        //이메일중복확인
            //test() 찾는 문자열이 들어있는지 확인
            $("#bm_email").blur(function(){
                var bm_email = $("#bm_email").val();
                var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); //이메일 형식검사
                //이메일 공백체크
                if(bm_email == ""){
                	$(".email_check").text("이메일을 입력해주세요");
                    $(".email_check").css("color","red");
                    $("#bm_email").removeClass("is-valid");
                	$("#bm_email").addClass("is-invalid");
                }else if(!getMail.test(bm_email)){
                	$(".email_check").text("이메일 형식이 맞지않습니다");
                    $(".email_check").css("color","red");
                    $("#bm_email").removeClass("is-valid");
                	$("#bm_email").addClass("is-invalid");
                }else {
	                $.ajax({
	                    type:"post",
	                    dataType:"text",
	                    async: "true",
	                    url:"${contextPath}/biz/emailCheck",
	                    data: {"bm_email":bm_email},
	                    success:function(data,textSataus){
	                        console.log("중복확인(1/0) :"+data);
	
	                        if(data == 1){ //이메일 중복
	                            $(".email_check").text("사용 중인 이메일입니다");
	                            $(".email_check").css("color","red");
	                            $("#bm_email").removeClass("is-valid");
	                        	$("#bm_email").addClass("is-invalid");
	                        }else{ //이메일이 중복이 아닐경우
	                        	$("#bm_email").removeClass("is-invalid");
	                        	$("#bm_email").addClass("is-valid");
	                        }
						}
					});
				}
        	});
        //가입하기 클릭
        $("#submitForm").click(function(){
        	var id = $("#bm_id").val();
        	var pwd = $("#bm_pwd_2").val();
        	var name = $("#bm_name").val();
        	var bm_phoneNumber = $("#bm_phoneNumber").val();
        	if(id == "" || id == null ||
        			pwd == "" || pwd == null ||
        			name == "" || name == null ||
        			bm_phoneNumber == "" || bm_phoneNumber == null){
        		alert("입력되지 않은 정보가 있습니다");
        	}else if($(".is-invalid").length != 0){
        		alert("입력한 정보를 확인해주세요");
        	}else {
        		var joinForm = document.joinForm;
        		joinForm.action = "${contextPath}/biz/addMember";
        		joinForm.method= "post";
        		joinForm.submit();
        	}
        })
       });
    </script>
<meta charset="UTF-8">
<title>업주 회원가입</title>
</head>
<body>
<!-- 사업자명 사업자번호 대표자명 전화번호 아이디 비밀번호  -->
    <form name="joinForm" >
        <div class="col-lg-6 col-sm-10 mx-auto mt-5 ">
            <div class></div>
            <h3>업주 회원가입 신청서</h3><br>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label class="font-weight-bold" for="bm_id">아이디</label>
                    <input type="text" class="form-control" id="bm_id" name="bm_id" placeholder="아이디를 입력하세요" required>
                    <div class="id_check invalid-feedback"></div>
                </div>
            </div>
​
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label class="font-weight-bold" for="bm_pwd">비밀번호</label>
                    <input type="password" class="form-control" id="bm_pwd" name="bm_pwd" placeholder="비밀번호를 입력하세요" required><br>
                    <input type="password" class="form-control" id="bm_pwd_2" name="bm_pwd_2" placeholder="비밀번호 확인" required>
                    <div class="pwd_check invalid-feedback"></div>
                    <div class="valid-feedback"></div>
                </div>
            </div>
​
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label class="font-weight-bold" for="bm_name">대표자이름</label>
                    <input type="text" class="form-control" id="bm_name" name="bm_name" placeholder="성명을 입력하세요" required>
                    <div class="name_check invalid-feedback"></div>
                </div>
            </div>
				 <div class="form-row">
               	 <div class="form-group col-md-6">
                    <label class="font-weight-bold" for="bm_phoneNumber">휴대폰번호</label>
                    <input type="tel" class="form-control" id="bm_phoneNumber" name="bm_phoneNumber" placeholder="010-1234-5678" required>
					<div class="number_check invalid-feedback"></div>
                </div>
    		</div>
​
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label class="font-weight-bold" for="bm_email">이메일주소</label>
                    <input type="email" class="form-control" id="bm_email"  name="bm_email" placeholder="이메일주소를 입력해주세요" required>
                    <div class="email_check invalid-feedback"></div>
                </div>
            </div>
​
            <input type="button" id="submitForm" class="btn btn-primary btn-lg btn-block col-md-6 mt-4" value="업주 회원 신청">
        </div>
    </form>
</body>
</html>