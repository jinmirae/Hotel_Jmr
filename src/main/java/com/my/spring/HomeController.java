package com.my.spring;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;

	private Object bookinfo;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping("/")
	public String doLogin(HttpServletRequest locale, Model m) {
			return "home";
	}
	
	@RequestMapping("/newbie")
	public String newbie() {
		return "/newbie";
	}
	@RequestMapping("/login")
	public String doLogin() {
		return "login";
	}
	
	@RequestMapping(value="/signin",method=RequestMethod.POST)//회원가입 DB
	public String doSignin(HttpServletRequest hsr) {
		String realname=hsr.getParameter("realname");
		String userid=hsr.getParameter("userid");
		String passcode=hsr.getParameter("passcode1");
		iMember member=sqlSession.getMapper(iMember.class);
		member.doSignin(realname, userid, passcode);
		return "home";
	}


	@RequestMapping(value="/check_user", method=RequestMethod.POST)
	public String reserve(HttpServletRequest hsr, Model model) {
		String id=hsr.getParameter("id");
		String pass=hsr.getParameter("pass");
		//DB에서 유저확인 : 기존유저면 reserve, 없으면 home으로.
		iMember member=sqlSession.getMapper(iMember.class);
		int n=member.doCheckUser(id,pass);
		if(n>0) {
			HttpSession session=hsr.getSession();
			session.setAttribute("loginid", id);
			return "redirect:/room";
		} else {
		return "home";
		}
	}
	
	@RequestMapping(value="/reserve",method=RequestMethod.GET)
	public String reserve2(HttpServletRequest hsr, Model model) {
		// get two days from client
		
		HttpSession session=hsr.getSession();
		String loginid=(String)session.getAttribute("loginid");
		System.out.println("loginid ["+loginid+"]");
		if(loginid==null) {
			return "home";
		} else {
			
			iRoom room = sqlSession.getMapper(iRoom.class);
			sqlSession.getMapper(iRoom.class);
			ArrayList<Roominfo2> roominfo2=room.getRoomType();
			model.addAttribute("type",roominfo2);
			return "reserve";
		}
	}

	@RequestMapping("/room")
	public String room(HttpServletRequest hsr, Model model) {
		HttpSession session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/login";
		}
		//여기서 interface호출하고 결과를 room.jsp에 전달.
		iRoom room = sqlSession.getMapper(iRoom.class);
//		ArrayList<Roominfo> roominfo=room.getRoomList();
//		model.addAttribute("list",roominfo);
		
		sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo2> roominfo2=room.getRoomType();
		model.addAttribute("type",roominfo2);
		return "room";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest hsr) {
		HttpSession session=hsr.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/getRoomList",method=RequestMethod.POST,
					produces = "application/text; charset=utf8")
	@ResponseBody
		public String getRoomList(HttpServletRequest hsr) {
		iRoom room=sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo=room.getRoomList();
		JSONArray ja = new JSONArray();
		for(int i=0; i<roominfo.size(); i++) {
			JSONObject jo=new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		System.out.println(ja.toString());
		return ja.toString();
		}
		
	@RequestMapping(value="/deleteRoom",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok";
	}
	@RequestMapping(value="/addRoom",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		String rname=hsr.getParameter("roomname");
		int rtype=Integer.parseInt(hsr.getParameter("rtype"));
		int howmany=Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch=Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room = sqlSession.getMapper(iRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
	@RequestMapping(value="/updateRoom",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String updateRoom(HttpServletRequest hsr) {
		iRoom room = sqlSession.getMapper(iRoom.class);
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		String roomname=hsr.getParameter("roomname");
		int roomtype=Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany=Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch=Integer.parseInt(hsr.getParameter("howmuch"));
		System.out.println("roomcode ["+roomcode+"]");
		System.out.println("roomtype ["+roomtype+"]");
		System.out.println("howmany ["+howmany+"]");
		System.out.println("howmuch ["+howmuch+"]");
		room.doUpdateRoom(Integer.parseInt(hsr.getParameter("roomcode")),
				hsr.getParameter("roomname"),
				Integer.parseInt(hsr.getParameter("roomtype")),
				Integer.parseInt(hsr.getParameter("howmany")),
				Integer.parseInt(hsr.getParameter("howmuch")));
				return "ok";
	}
	
	@RequestMapping(value="/addBook",method=RequestMethod.POST)
	@ResponseBody
	public String addBook(HttpServletRequest hsr) {
		System.out.println("roomcode ["+hsr.getParameter("roomcode")+"]");
		System.out.println("howmany ["+hsr.getParameter("howmany")+"]");
		System.out.println("checkin ["+hsr.getParameter("checkin")+"]");
		System.out.println("checkout ["+hsr.getParameter("checkout")+"]");
		System.out.println("total ["+hsr.getParameter("total")+"]");
		System.out.println("booker ["+hsr.getParameter("booker")+"]");
		System.out.println("mobile ["+hsr.getParameter("mobile")+"]");
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		int howmany=Integer.parseInt(hsr.getParameter("howmany"));
		String checkin=hsr.getParameter("checkin");
		String checkout=hsr.getParameter("checkout");
		int total=Integer.parseInt(hsr.getParameter("total"));
		String booker=hsr.getParameter("booker");
		String mobile=hsr.getParameter("mobile");
		iBook book = sqlSession.getMapper(iBook.class);
		book.doInsertBook(roomcode, howmany, checkin, checkout, total, booker, mobile);
		return "ok";
	}
	
	@RequestMapping(value="/getBookList",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String getBookList(HttpServletRequest hsr) {
		String day1=hsr.getParameter("checkin");
		String day2=hsr.getParameter("checkout");
		System.out.println("day1 ["+day1+"]");
		System.out.println("day2 ["+day2+"]");
		iBook book=sqlSession.getMapper(iBook.class);
		ArrayList<Bookinfo> bookinfo=book.getBookList(day1,day2);
		JSONArray ja = new JSONArray();
		System.out.println("size ["+bookinfo.size()+"]");
		for(int i=0; i<bookinfo.size(); i++) {
			JSONObject jo=new JSONObject();
			jo.put("bookcode", bookinfo.get(i).getBookcode());
			jo.put("roomcode", bookinfo.get(i).getRoomcode());
			jo.put("howmany", bookinfo.get(i).getHowmany());
			jo.put("checkin", bookinfo.get(i).getCheckin());
			jo.put("checkout", bookinfo.get(i).getCheckout());
			jo.put("total", bookinfo.get(i).getTotal());//총합
			jo.put("booker", bookinfo.get(i).getBooker());
			jo.put("mobile", bookinfo.get(i).getMobile());
			jo.put("roomname", bookinfo.get(i).getRoomname());
			jo.put("typename", bookinfo.get(i).getTypename());
			ja.add(jo);
		}
		
		System.out.println(ja.toString());
		return ja.toString();
	}
	@RequestMapping(value="/getAvailable",method=RequestMethod.POST,
			produces = "application/text; charset=utf8")
	@ResponseBody
	public String getAvailable(HttpServletRequest hsr) {
		String day1=hsr.getParameter("checkin");
		String day2=hsr.getParameter("checkout");
		System.out.println("day1 ["+day1+"]");
		System.out.println("day2 ["+day2+"]");
		iBook room=sqlSession.getMapper(iBook.class);
		ArrayList<Roominfo> roominfo=room.getAvailable(day1,day2);
		JSONArray ja = new JSONArray();
		System.out.println("size ["+roominfo.size()+"]");
		for(int i=0; i<roominfo.size(); i++) {
			JSONObject jo=new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		
		System.out.println(ja.toString());
		return ja.toString();
	}
}
