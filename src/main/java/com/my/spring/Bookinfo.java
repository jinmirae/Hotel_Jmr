package com.my.spring;

public class Bookinfo {
	private int bookcode;
	private int roomcode;
	private String roomname;
	private String typename;
	private int howmany;
	private String checkin;
	private String checkout;
	private int total;
	private String booker;
	private String mobile;
	
	public Bookinfo() {
	}
	public Bookinfo(int bookcode, int roomcode, String roomname, String typename, int howmany, String checkin, String checkout, int total, String booker,
			String mobile) {
		super();
		this.bookcode = bookcode;
		this.roomcode = roomcode;
		this.roomname = roomname;
		this.typename = typename;
		this.howmany = howmany;
		this.checkin = checkin;
		this.checkout = checkout;
		this.total = total;
		this.booker = booker;
		this.mobile = mobile;
	}
	public int getBookcode() {
		return bookcode;
	}
	public int getRoomcode() {
		return roomcode;
	}
	public String getRoomname() {
		return roomname;
	}
	public String getTypename() {
		return typename;
	}
	public int getHowmany() {
		return howmany;
	}
	public String getCheckin() {
		return checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public int getTotal() {
		return total;
	}
	public String getBooker() {
		return booker;
	}
	public String getMobile() {
		return mobile;
	}
	public void setBookcode(int bookcode) {
		this.bookcode = bookcode;
	}
	public void setRoomcode(int roomcode) {
		this.roomcode = roomcode;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public void setHowmany(int howmany) {
		this.howmany = howmany;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public void setBooker(String booker) {
		this.booker = booker;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
}
