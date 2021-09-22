package com.my.spring;

public interface iMember {
	void doSignin(String realname,String userid,String passcode);
	int doCheckUser(String id, String pass);
}
