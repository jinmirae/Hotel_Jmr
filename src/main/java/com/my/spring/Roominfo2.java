package com.my.spring;

public class Roominfo2 {
	private int typecode;
	private String name;
	public Roominfo2() {}
	public Roominfo2(int typecode, String name) {
		this.typecode = typecode;
		this.name = name;
	}
	
	public int getTypecode() {
		return typecode;
	}
	public String getName() {
		return name;
	}
	public void setTypecode(int typecode) {
		this.typecode = typecode;
	}
	public void setName(String name) {
		this.name = name;
	}

}
