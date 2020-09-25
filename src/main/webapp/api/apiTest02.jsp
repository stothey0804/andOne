<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    //ajax 시작
	$.ajax({
		url : 'https://earthquake.kr:23490/query/USDKRW,USDJPY',
		type: 'GET',
		success : function(data){
			//호출 성공하면 작성할 내용
            console.log(data);
            var arr1 = data.USDKRW;
            var arr2 = data.USDJPY;
            
            for(var i in arr1){
            	console.log('USDKRW:'+arr1[i]);
            }
            
            for(var i in arr2){
            	console.log('USDJPY:'+arr2[i]);
            }
		}, 
		error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
});
</script>
</head>
<body>

</body>
</html>