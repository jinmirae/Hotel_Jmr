<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>newbie</title>

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
  <link href="${pageContext.request.contextPath}/resources/hotel/newbie.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
<section id="hero">
    <div class="hero-container">
      <div id="wowfadeIn" class="wow fadeIn">
        <h1>Welcome to Hotel JMR</h1>
        <h2>Sing up <span class="typed" data-typed-items="beautiful graphics, functional websites, working mobile apps"></span></h2>
        <div class="actions">
	                    <form method="post" action="/spring/signin" id="frmLogin">
	                        <div class="form-group">
	                        	<label class="control-label">??????</label>
	                            <input type="text" id="realname" name=realname class="form-control" placeholder="??????"/>
	                            <label class="control-label">?????????ID</label>
	                            <input type="text" id="userid" name=userid class="form-control" placeholder="?????????"/>
	                            <label class=" control-label">????????????</label>
	                            <input type=password id="passcode1" name=passcode1 class="form-control" placeholder="????????????"/>
	                            <label class=" control-label">??????????????????</label>
	                            <input type=password name=passcode2 class="form-control" placeholder="??????????????????"/>
	                            <label class="control-label">???????????????</label>
	                            <input type="text" name=mobile class="form-control" placeholder="???????????????"/>
	                            <button type="submit" id="btnSignin" class="btn btn-default" >????????????<i class="fa fa-arrow-circle-right fa-2x"></i></button>
	                        </div>
	                        <span class="form-footer">??????????????????????????? -><a href="/spring/">????????? ????????????</a></span>
	                    </form>
        </div>
      </div>
    </div>
  </section><!-- End Hero -->
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#frmSignin',function(){
	if($('input[name=realname]').val()==''){
		alert('????????? ???????????????.');
		return false;
	}
	if($('input[name=userid]').val()==''){
		alert('????????????????????? ???????????????.');
		return false;
	}
	if($('input[name=passcode1]').val()==''){
		alert('??????????????? ???????????????.');
		return false;
	}
	if($('input[name=passcode1]').val()!==$('input[name=passcode2]').val()){
		alert('??????????????? ???????????? ????????????.');
		return false;
	}
	return false;
})
</script>

</html>
