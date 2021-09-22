package com.my.spring;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface iRoom {
	ArrayList<Roominfo> getRoomList();
	ArrayList<Roominfo2> getRoomType();
	void doDeleteRoom(int roomcode);
	void doAddRoom(String roomname,int roomtype,int howmany,int howmuch);
	void doUpdateRoom(int roomcode,String roomname,int roomtype,int howmany,int howmuch);
}