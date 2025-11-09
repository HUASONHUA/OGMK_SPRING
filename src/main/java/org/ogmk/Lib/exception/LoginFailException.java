package org.ogmk.Lib.exception;

public class LoginFailException extends OGKMException {
	public LoginFailException() {
		super("登入失敗,帳號密碼不正確");
		// TODO Auto-generated constructor stub
	}

	public LoginFailException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public LoginFailException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

}
	
