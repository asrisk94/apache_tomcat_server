<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	window.onload = function() {
		
		var main = "<%= main %>";
		var side = "<%= side %>";
		var drink = "<%= drink %>";
		
		var sum = 0;
		
		if(main == "한우버거") {
			sum += 5000;
		}
		else if(main == "밥버거") {
			sum += 4500;
		}
		else if(main == "치즈버거") {
			sum += 4000;
		}
		
		if(side == "감자튀김") {
			sum += 1500;
		}
		else if(side == "어니언링") {
			sum += 1700;
		}
		
		if(drink == "콜라") {
			sum += 1000;
		}
		else if(drink == "사이다") {
			sum += 1000;
		}
		else if(drink == "커피") {
			sum += 1500;
		}
		else if(drink == "밀크쉐이크") {
			sum += 2500;
		}
	
		var price = document.querySelector("span#price");
		price.innerHTML = (sum + "원");
	}
</script>