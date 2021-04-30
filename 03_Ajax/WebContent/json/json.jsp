<%@page import="java.util.List"%>
<%@page import="member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - json</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
  
  <style>
  	.box {
  		margin : 10px 0;
  	}
  	table {
  		border: 1px solid #000;
  		border-collapse: collapse;
  	}
  	th, td {
  		border : 1px solid #000;
  		padding : 5px;
  	}
  	table img {
  		width : 100px;
  	}
  </style>

</head>
<body>
	<h1>JSON</h1>
	<h2>회원목록 조회</h2>
	
	<input type="button" value="실행" id="btn1" />
	<div class="box" id="result1"></div>
	
	<script>
		$("#btn1").click(function() {
			$.ajax({
				// gson 실습한다고 json 디렉토리를 전부 gson으로 바꿔놨음
				url : "<%= request.getContextPath() %>/gson/memberList",
				method : "get",
				dataType : "json",
				success : function(data) {
// 					var other = JSON.parse(data);
					// 위같은 작업을 안해줬는데도 알아서 파스되어서 출력된다. 제이쿼리가 해줬음.
					
					var $table = $("<table id='tbl-member'></table>");
					
					$.each(data, function(index, elem) {
						var html = "<tr>";
						html += "<td><img src='<%= request.getContextPath() %>/images/" + elem.profile + "'></td>";
						html += "<td>" + elem.name + "</td>";
						html += "<td>" + elem.phone + "</td>";
						html += "</tr>";
						
						$table.append(html);
					});
					$("#result1").html($table);
				},
				error : function(xhr, textStatus, err) {
					console.log(xhr, textStatus, err);
				}
			});
		});
	</script>
	
	<h2>회원아이디조회</h2>
	<input type="search" name="" id="searchMemberName" />
	<input type="button" value="검색" id="btn2" />
	<div class="box" id="result2"></div>
	
	<script>
		$("#btn2").click(function() {
			var $searchMemberName = $("#searchMemberName");
			if(/^.{1,}$/.test($searchMemberName.val()) == false) return;
			$.ajax({
				// gson 실습한다고 json 디렉토리를 전부 gson으로 바꿔놨음
				url : "<%= request.getContextPath() %>/gson/member",
				data : {
					searchMemberName : $searchMemberName.val()
				},
				dataType : "json",
				method : "get",
				success : function(data) {
					console.log(data);
					$(".box").html("");
					var $result2 = $("#result2");
					if(data == null) {
						$result2.html("조회된 회원이 없습니다.");
					} else {
					$.each(data, function(index, elem){
						var $table = $("<table></table>");
						$table.append("<tr><th>이름</th><td>" + elem.name + "</td></tr>")
								.append("<tr><th>전화번호</th><td>" + elem.phone + "</td></tr>")
								.append("<tr><th>프로필</th><td><img src='<%= request.getContextPath() %>/images/" + elem.profile + "'/></td></tr>");

		               $result2.append($table);
			        });
					}
				},
				error : function(xhr, status, err) {
					console.log(xhr, status, err);
				}
			});
		});
	</script>
	
	<h2>회원추가</h2>
	<form>
		<table>
			<tr>
				<td><label for="memberName">이름</label></td>
				<td><input type="text" id="memberName" /></td>
			</tr>
			<tr>
				<td><label for="memberPhone">전화번호</label></td>
				<td><input type="tel" id="memberPhone" /></td>
			</tr>
			<tr>
				<td><label for="memberProfile">프로필</label></td>
				<td><input type="text" id="memberProfile" /></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" value="저장" id="btn3" />
				</th>
			</tr>
		</table>
	</form>
	
	<script>
		$("#btn3").click(function() {
			
			var member = {
					name : $("#memberName").val(),
					phone : $("#memberPhone").val(),
					profile : $("#memberProfile").val()
			};
			
			var jsonStr = JSON.stringify(member);
			
			$.ajax({
				// gson 실습한다고 json 디렉토리를 전부 gson으로 바꿔놨음
				url : "<%= request.getContextPath() %>/gson/insertMember",
				method : "post",
// 				dataType : "json",
// 				data : member,
				data : {
					member : jsonStr
				},
				success : function(data) {
					console.log(data);
					console.log(typeof(data));
					if(data === "1") {
						alert("회원정보를 추가했습니다.");
						// 회원목록조회 실행
						$("#btn1").trigger('click');
					} else {
						alert("추가에 실패했습니다.");
					}
				},
				error : function(xhr, status, err) {
					console.log(xhr, status, err);
				},
				complete : function() {
					// 입력창 초기화
					$("#memberName, #memberPhone, #memberProfile").val('');
				}
				
			});
		});
		

	</script>
	
</body>
</html>