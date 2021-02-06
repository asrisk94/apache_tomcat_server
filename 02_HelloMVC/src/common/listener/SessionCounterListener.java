package common.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;


/**
 * 	서버에서 운영중인 session 객체의 수를 관리하는 리스너
 *
 */

@WebListener
public class SessionCounterListener implements HttpSessionListener {
												// 세션정보 확인. - 속성에 추가, 제거, 수정시 발생
	private static int activeSessions;
	
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		activeSessions++;
		System.out.println("[[ 세션 생성!  - 현재 세션 수 : " + activeSessions + " ]]");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		if(activeSessions > 0) {
			activeSessions--;
		}
		System.out.println("[[ 세션 반환!  - 현재 세션 수 : " + activeSessions + " ]]");
	}
	
}
