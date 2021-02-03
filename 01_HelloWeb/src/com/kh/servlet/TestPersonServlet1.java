package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet : 웹서비스를 위한 자바클래스로써, 반드시 HttpServlet을 상속해야 한다.
 * 
 * Servlet 인터페이스
 * 	└ GenericServlet 추상클래스
 * 		└ HttpServlet 추상클래스
 * 			└ TestPersonServlet1
 * 
 * servlet의 생명주기
 *  - 컨테이너(WAS)에 의해서 싱글톤(프로그램 내에서 단 하나의 객체만 생성/관리)으로 관리되는 객체
 *  
 *  객체생성 - init(설정) - service(매사용자요청마다 호출) - doGet | doPost
 * 
 *  (서버중지 또는 재시작)
 *  destroy - 객체반환  (이 과정은 알아서 된다)
 *  
 *  java/xml 파일 수정시 서버재시작해야한다.
 *  메소드의 몸통부분 수정시에만 eclipse에서 reload기능을 이용할 수 있다.
 */
public class TestPersonServlet1 extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestPersonServlet1() {
        super();
        System.out.println("객체생성 : " + this.hashCode());
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init");
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		System.out.println("destroy");
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * GET 방식 요청시 호출 메소드
	 * 
	 * HttpServletRequest
	 * 	사용자 요청 관련 : 사용자 입력값, 쿠키, 요청관련 헤더, 세션 등
	 * HttpServletResponse
	 * 	사용자 응답 관련 : 응답출력스트림, 응답헤더 작성, 쿠키 추가
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGET 호출 : " + this.hashCode());
		
		// 1. 사용자 입력 확인 : 자바변수에 옮겨담기
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String animal = request.getParameter("animal");
		String[] foodArr = request.getParameterValues("food");
		
		System.out.println("name = " + name);
		System.out.println("color = " + color);
		System.out.println("animal = " + animal);
		System.out.println("food= " + Arrays.toString(foodArr));
		
		// 2. 응답 작성 : html 작성
		// 응답 헤더 작성
		response.setContentType("text/html; charset=utf-8");
		
		// 응답 출력스트림
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset='utf-8'/>");
		out.println("<title>테스트 결과</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>테스트결과</h1>");
		out.println("<p>이름 : " + name + "</p>");
		out.println("<p>색깔 : " + color + "</p>");
		out.println("<p>동물 : " + animal + "</p>");
		out.println("<p>음식 : " + Arrays.toString(foodArr) + "</p>");
		out.println("</body>");
		out.println("</html>");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * POST 방식 요청시 호출 메소드
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPOST 호출 : " + this.hashCode());
		
		// 0. POST 방식은 utf-8 인코딩 처리선언이 있어야한다.
		// http message body 영역의 데이터도 utf-8 방식으로 처리
		request.setCharacterEncoding("utf-8");
		
		// 1. 사용자 입력 확인 : 자바변수에 옮겨담기
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String animal = request.getParameter("animal");
		String[] foodArr = request.getParameterValues("food");
		
		System.out.println("name = " + name);
		System.out.println("color = " + color);
		System.out.println("animal = " + animal);
		System.out.println("food= " + Arrays.toString(foodArr));
		
		// 2. 응답 작성 : html 작성
		// 응답 헤더 작성
		response.setContentType("text/html; charset=utf-8");
		
		// 응답 출력스트림
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset='utf-8'/>");
		out.println("<title>테스트 결과</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>테스트결과</h1>");
		out.println("<p>이름 : " + name + "</p>");
		out.println("<p>색깔 : " + color + "</p>");
		out.println("<p>동물 : " + animal + "</p>");
		out.println("<p>음식 : " + Arrays.toString(foodArr) + "</p>");
		out.println("</body>");
		out.println("</html>");
	}

}
