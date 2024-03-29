package com.kh.menu;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MenuOrderServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		//1.전송값에 한글이 있을 경우 인코딩처리해야함.
		req.setCharacterEncoding("utf-8");
		
		//2.전송값 꺼내서 변수에 기록하기.
		String main_menu = req.getParameter("main_menu");
		String side_menu = req.getParameter("side_menu");
		String drink_menu = req.getParameter("drink_menu");
		System.out.println("main_menu="+main_menu);
		System.out.println("side_menu="+side_menu); 
		System.out.println("drink_menu="+drink_menu); 
		
		//3.비지니스 로직
		int price = 0;
		switch (main_menu) {
		case "한우버거": price+=5000;break;
		case "밥버거": price+=4500;break;
		case "치즈버거": price+=4000;break;
		}
		switch (side_menu) {
		case "감자튀김": price+=1500;break;
		case "어니언링": price+=1700;break;
		}
		switch (drink_menu) {
		case "콜라": 
		case "사이다": price+=1000;break;
		case "커피": price+=1500;break;
		case "밀크쉐이크": price+=2500;break;
		}
		
		
		//4.실행결과 처리 및 view단 처리위임
		req.setAttribute("price", price);
		
		//request객체의 RequestDispatcher에 view단 지정
		//RequestDispatcher는 인터페이스
		RequestDispatcher reqDispatcher = getServletContext().getRequestDispatcher("/menu/menuEnd.jsp");
		reqDispatcher.forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}
