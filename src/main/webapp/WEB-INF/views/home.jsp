<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<%-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/resources/hotel/home.css" rel="stylesheet" type="text/css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">


<!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${pageContext.request.contextPath}/resources/hotel/home2.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet"> --%>


</head>
<body>

<section id="hero">
    <div class="hero-container">
      <div id="wowfadeIn" class="wow fadeIn">
        <h1>Welcome to Hotel JMR</h1>
        <h2>LOGIN <span class="typed" data-typed-items="beautiful graphics, functional websites, working mobile apps"></span></h2>
        <div class="actions">
	        <form method="post" action="/spring/check_user" id="frmLogin">
	            <div class="form-group">
	                <label class="control-label">ID</label>
	                <input type="text" name="id" class="form-control" placeholder="아이디"/>
	
	                <label class=" control-label">Password</label>
	                <input type="text" name="pass" class="form-control" placeholder="비밀번호"/>
					<input type="submit" class="btn btn-default" >로그인</input>
<!-- 	                <button type="submit" class="btn btn-default" >로그인<i class="fa fa-arrow-circle-right fa-2x"></i></button> -->
	            </div>
	            <span class="form-footer">회원계정이 없습니까? <a href="/spring/newbie">회원가입</a></span>
	        </form>
        </div>
      </div>
    </div>
  </section><!-- End Hero -->

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#frmLogin',function() {
	let pstr=$.trim($('input[name=id]').val());
	$('input[name=id]').val(pstr);
	pstr=$.trim($('input[name=pass]').val());
	$('input[name=pass]').val(pstr);
	if($('input[name=id]').val()==''){
		alert('로그인아이디를 입력하시오.');
		return false;
	}
	if($('input[name=pass]').val()==''){
		alert('비밀번호를 입력하시오.');
		return false;
	}
	return false;
})
</script>
</html>