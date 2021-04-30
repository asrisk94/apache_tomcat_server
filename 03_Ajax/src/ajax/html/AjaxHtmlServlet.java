package ajax.html;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class AjaxHtmlServlet
 */
@WebServlet("/html")
public class AjaxHtmlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 1. 업무로직
		// Singleton 객체를 사용해서 메모리상에서 관리 (프로그램상에서 단 하나의 객체만 생성해서 관리하는 것)
		MemberManager manager = MemberManager.getInstance();
//		System.out.println(manager.hashCode());
		List<Member> list = manager.getList();
		
		// 2. view단 처리 : jsp에 포워드
		request.setAttribute("list", list);
		request.getRequestDispatcher("/html/htmlMember.jsp")
				.forward(request, response);
	}

}
