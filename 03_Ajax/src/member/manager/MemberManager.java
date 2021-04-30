package member.manager;

import java.util.ArrayList;
import java.util.List;

import member.model.vo.Member;

/**
 * 
 * 	singleton 객체
 * 	1. 생성자를 private으로 지정해서 클래스 밖에서 객체 생성 방지
 * 	2. getInstance static 메소드를 통해서 특정조건일 때에만 객체를 생성
 *	
 *
 */

public class MemberManager {

	// 단하나의 객체를 관리하기위한 static 필드
	private static MemberManager instance;
	
	private List<Member> list;
	
	private MemberManager() {
		list = new ArrayList<>();
		list.add(new Member("박보검", "01012341234", "parkBogum.jpg"));
		list.add(new Member("줄리아로버츠", "01033334444", "juliaRoberts.jpg"));
		list.add(new Member("멧 데이먼", "01056785678", "mattDamon.jpg"));
		list.add(new Member("박 데이먼", "01056785678", "mattDamon.jpg"));
	}
	
	public List<Member> getList() {
		
		return this.list;
	}
	
	
	/**
	 * 	객체를 생성하거나, 생성된 객체를 리턴	
	 */
	public static MemberManager getInstance() {
		if(instance == null)
			instance = new MemberManager();
		return instance;
	}
	
}
