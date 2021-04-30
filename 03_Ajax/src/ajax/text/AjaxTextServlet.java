package ajax.text;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AjaxTextServlet
 */
@WebServlet("/text")
public class AjaxTextServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxTextServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력 처리
		String name = request.getParameter("name");
		int age = Integer.valueOf(request.getParameter("age"));
		System.out.println("name = " + name);
		System.out.println("age = " + age);
		
		// 응답객체에 출력작성(text)
		response.setContentType("text/html; charset=utf-8");
		response.getWriter()
				.append("Served at: ")
				.append(request.getContextPath())
				.append("<br/>")
				.append("<p>이름 : " + name + "</p>")
				.append("<p>나이 : " + age + "</p>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
