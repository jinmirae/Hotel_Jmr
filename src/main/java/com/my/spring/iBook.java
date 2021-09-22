package com.my.spring;

import java.util.ArrayList;

public interface iBook {
	ArrayList<Roominfo> getAvailable(String checkin,String checkout);
	ArrayList<Bookinfo> getBookList(String checkin,String checkout);

	void doInsertBook(int roomcode,
			/* String roomname,String typename, */int howmany,String checkin,
			String checkout, int total, String booker,
			String mobile);
}
