<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - autoComplete</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
</head>
<body>
	<h1>Auto Complete</h1>
	<div class="wrapper">
		<input type="text" id="searchName" />
	</div>
	
	<script>
	
	function ajaxSearchName(request, response){
		// 서버 비동기 통신
		$.ajax({
			url : "<%= request.getContextPath() %>/autoComplete",
			data : {
				searchName : request.term 	// 리퀘스트 객체에 담긴 속성값, 단어
			},
			method : "get",
			dataType : "text",
			success : function(data) {
				console.log(data);
				var arr = data.split(",");
				console.log(arr);
				
				/* 자바스크립트에서 권장하는 생김새
				[
					{label: '강유정', value: '강유정'},
					{label: '이효정', value: '이효정'},
					{label: '정다미', value: '정다미'},
					...
				]
				*/
				/*  맵의 예시
				var a = [1,2,3];
				var other = $.map(a, function(num){
					return num * num;
				});
				console.log(a);		// 1,2,3
				console.log(other);	// 1,4,9
				*/
				arr = $.map(arr, function(str) {
					// 배열요소 -> 변경처리 -> 요소리턴
					return {
						label : str,
						value : str
					};
				});
				// 검색어 목록 작성
				console.log(arr);
				response(arr);
			},
			error : function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	}
	
	
		$("#searchName").autocomplete({
// 			source : ['Apple', 'application', 'appear', 'abcde'],
			// 배열이 아닌 함수형태로도 처리 가능
			source : function(request, response) {
// 				console.log(request);	// 사용자 입력값을 포함하고 있는 객체
// 				console.log(response);	// 자동검색어 목록을 만들기 위한 함수
	
				// ajax가 너무 길어서 알아보기 힘드니까 위에다 따로 뻈음.
				ajaxSearchName(request, response);
			},
			minLength : 1,
			delay : 500,
			focus : function(e, focus) {
				// e: 이벤트
				// focus: 이벤트가 발생한 객체
				return false; // 포커스를 가져도 선택되지 않도록 함
			}
		});
	
		<%--
		$("#searchName").keyup(function() {
			console.log($(this).val());
			
			// 아무것도 적지 않았을 경우
			if($(this).val().length == 0) {
				return;
			}
			
			$.ajax({
				url : "<%= request.getContextPath() %>/autoComplete",
				data : {
					searchName : $(this).val()
				},
				method : "get",
				dataType : "text",
				success : function(data) {
					console.log(data);
					var arr = data.split(",");
					console.log(arr);
				},
				error : function(xhr, status, err) {
					console.log(xhr, status, err);
				}
			});
			
		});
		--%>
	</script>
</body>
</html>