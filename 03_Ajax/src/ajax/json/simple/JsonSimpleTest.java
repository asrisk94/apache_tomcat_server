package ajax.json.simple;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import member.model.vo.Member;

// json-simpe 라이브러리를 WebApp Library(/WEB-INF/lib)에 추가할 것.
public class JsonSimpleTest {
	
	JSONObject sinsa = new JSONObject();
	Member m = new Member("sinsa", "01012341234", "sinsa.jpg");
	{
		sinsa.put("name", m.getName());
		sinsa.put("phone", m.getPhone());
		sinsa.put("profile", m.getProfile());		
	}
	// 이렇게 처리해줘야 키밸류값이 살아서 다 담긴다.
	
	public static void main(String[] args) {
		
		JsonSimpleTest j = new JsonSimpleTest();
		j.test1();
		j.test2();

	}
	
	// JSONObject 테스트
	private void test1() {
		
		JSONObject obj = new JSONObject();
		obj.put("abcde", 1234);
		obj.put("arirang", 3579);
		obj.put("member", sinsa);
		
		System.out.println(obj);
	}

	//JSONArray 테스트
	private void test2() {
		
		JSONArray arr = new JSONArray();
		
		arr.add(123);
		arr.add("honggd");
		arr.add(sinsa);
		arr.add(true);
		
		System.out.println(arr);
		
	}
	
}
