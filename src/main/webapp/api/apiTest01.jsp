<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://fx.kebhana.com/FER1101M.web"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	console.log(exView);
	var arr = exView.리스트;
	for(var i in arr){
		var object = arr[i];
		console.log('통화명:'+object.통화명);
		console.log('현찰사실때:'+object.현찰사실때);
		console.log('현찰파실때:'+object.현찰파실때);
		console.log('송금_전신환보내실때:'+object.송금_전신환보내실때);
		console.log('송금_전신환받으실때:'+object.송금_전신환받으실때);
		console.log('매매기준율:'+object.매매기준율);
		console.log('----------------------------------------');
	}
 });
</script>
</head>
<body>

</body>
</html>