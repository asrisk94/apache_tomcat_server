package ajax.json.simple;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberServlet
 */
@WebServlet("/json/member")
public class JsonMemberServlet extends HttpServlet {
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
		JSONObject obj = null;
		for(Member m : list) {
			if(m !=null && m.getName().contains(memberName)) {
				
				obj = new JSONObject();
				obj.put("name", m.getName());
				obj.put("phone", m.getPhone());
				obj.put("profile", m.getProfile());
				
				arr.add(obj);				
			}
		}		
		System.out.println("obj = " + obj);
		// 3. 
		response.setContentType("application/json; charset=utf-8");
		response.getWriter()
				.append(arr.toJSONString());
	}	

}
