<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - text</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>

<script>
	$(function() {
		console.log('jQuery loading complete');
		
		$("#btn").click(function() {
			// ajax 요청 전송
			$.ajax({
				url : "<%= request.getContextPath() %>/text",
// 				?name=홍길동&age=30
// 				data : "name=홍길동&age=30",
				data : {
					// 이렇게 작성하면 post방식. 위는 겟방식
					name : "신사임당",
					age : 48
				},
				method : "get", // 기본값 get | post | put | delete
				dataType : "text",	// xml | json | html | text | script 안적으면 알아서 판단해줌.
				beforeSend : function() {
					// 비동기통신 요청전 호출
					console.log("beforeSend");
				},
				
				success : function(data) {
					// data 매개변수에는 응답결과가 담겨있음.
// 					alert(data);
					console.log(data);
					$("#result").html(data);
				},
				error : function(xhr, textStatus, err) {
					// 처리실패시 호출
					console.log(xhr, textStatus, err);
				},
				complete : function() {
					// 요청의 성공/실패와 상관없이 마지막에 무조건 호출
					console.log('complete');
				}
			});
		});
		
	});

</script>
<style>
	#result {
		width : 500px;
		min-height : 100px;
		background-color : lightgray;
		border : 2px solid gray;
		padding : 5px;
		margin : 5px 0;
	}

</style>
</head>
<body>
	<h1>text</h1>
	<input type="button" value="실행" id="btn" />
	<div id="result"></div>
</body>
</html>