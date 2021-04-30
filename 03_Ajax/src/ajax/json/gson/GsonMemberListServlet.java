package ajax.json.gson;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberListServlet
 */
@WebServlet("/gson/memberList")
public class GsonMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 1. 업무로직 : 전체회원
		MemberManager manager = MemberManager.getInstance();
		List<Member> list = manager.getList();
		
		// 2. json문자열로 변환 & 응답출력
		// toJson(obj) json문자열로 변환
		// fromJson(jsonStr):obj  json문자열을 자바객체로 변환
//		Gson gson = new Gson();	// jar파일 있어야 사용 가능
//		String jsonStr = gson.toJson(list);
//		System.out.println("jsonStr = " + jsonStr);
//		
//		response.setContentType("application/json; charset=utf-8");
//		response.getWriter().append(jsonStr);
	
		// gson은 이렇게 더 짧고 편리하다.
		
		response.setContentType("application/json; charset=utf-8");
//		new Gson().toJson(src, writer);
		new Gson().toJson(list, response.getWriter());
		// 심지어 이렇게 하면 입출력을 동시에 해서 더 짧게 가능하다. (그래도 셋컨텐트타입은 해줘야됨)
	}

}
