package common.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class MvcUtils {

	/**
	 *  <pre>
	 * 	단방향 암호화 : 암호화만 가능한 케이스 (복호화가 가능하다면 폐기해야한다. 해킹가능성)
	 * 		- 암호화된 값(hash)을 가지고 비교연산
	 * 		- md5(지금은 잘 안씀. 털려서) sha1  sha256  sha512 등의 알고리즘 지원 (sha256이상 권장)
	 * 		- MessageDigest
	 * 
	 * 	양방향 암호화 : 암호화/복호화가 가능한 케이스
	 * 
	 * 
	 * 	로그인, 회원가입에는 단방향 암호화 사용.
	 * 
	 * 	암호화 절차
	 * 		1. 암호화객체 생성
	 * 		2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
	 * 		3. 암호화된 byte[] -> 인코더를 통한 문자열 변환
	 * 
	 * @param parameter
	 * @return
	 */
	
	public static String getEncryptedPassword(String password) {
		String encryptedPassword = null;
		
		try {
			// 1. 암호화객체 생성
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			
			// 2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
			byte[] bytes = password.getBytes("UTF-8");
			md.update(bytes);							// 바이트화된 자료를 암호화객체에 전달
			byte[] encryptedBytes = md.digest();		// 암호화.
			System.out.println(new String(encryptedBytes));
			
			// 3. 암호화된 byte[] -> 인코더를 통한 문자열 변환
			encryptedPassword = Base64.getEncoder().encodeToString(encryptedBytes);
			System.out.println(encryptedPassword);
			
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		 return encryptedPassword;
	}
}
