<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - xml</title>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
  
  <style>
  	#result-container {
  		border : 1px solid gray;
  		padding : 5px;
  	}
  	
  	table#tbl-member{border:1px solid; border-collapse:collapse;}
    #tbl-member th, #tbl-member td{border:1px solid; padding:10px;}
    #tbl-member img{width:100px; }
  </style>
</head>
<body>
	<h1>XML</h1>
	<button id="btn">실행</button>
	<div id="result-container"></div>
	
	<script>
		$("#btn").click(function() {
			$.ajax({
				url : "<%= request.getContextPath() %>/xml",
				method : "get",
				dataType : "xml",
				success : function(data) {
					console.log(data);	// text -> xml document 파싱한 후에 데이터로 넘어온 것
// 					$("#result-container").html(data);
					var $root = $(data).find(":root");	// 루트 태그를 찾아옴. -> members
					console.log($root);
					
					// 자식태그중 member 리턴
					var $member = $root.find("member");
					console.log($member);
					
					var $table = $("<table id='tbl-member'></table>");
					
					$member.each(function(index, member) {
						var $member = $(member);
						var html = "<tr>";
						html += "<td><img src='<%= request.getContextPath() %>/images/" + $member.find("profile").text() + "' /></td>";
						html += "<td>" + $member.find("name").text() + "</td>";
						html += "<td>" + $member.find("phone").text() + "</td>";
						html += "</tr>";
						$table.append(html);
					});
					
					$("#result-container").html($table);
				},
				error : function(xhr, textStatus, err) {
					console.log(xhr, textStatus, err);
				},
				complete : function() {
					console.log("complete");
				}
			});	
		});
	</script>
	
</body>
</html>