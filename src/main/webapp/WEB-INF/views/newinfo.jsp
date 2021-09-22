<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Information</title>
</head>
<body>
<p>이름: ${information.realname}</p>
<p>로그인아이디: ${information.userid}</p>
<p>비밀번호: ${information.passcode1}</p>
<p>비밀번호확인: ${information.passcode2}</p>
<p>모바일번호: ${information.mobile}</p>
<a href=/spring/home>취소</a>
</body>
</html>