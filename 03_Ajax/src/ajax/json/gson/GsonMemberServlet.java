package ajax.json.gson;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberServlet
 */
@WebServlet("/gson/member")
public class GsonMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 값 가져오기
		String memberName = request.getParameter("searchMemberName");
		System.out.println("memberName = " + memberName);
		
		// 2. 비교 후 값 담기
		MemberManager manager = MemberManager.getInstance();
		List<Member> list = manager.getList();
		
		JSONArray arr = new JSONArray();
		Member member = null;
		for(Member m : list) {
			if(m !=null && m.getName().contains(memberName)) {
				arr.add(m);
			}
		}		
		
		// 3. 
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(arr, response.getWriter());
	}	

}
