<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약관리</title>
    <link href="${pageContext.request.contextPath}/resources/hotel/reserve.css" rel="stylesheet" type="text/css">
</head>


<body>
    <div id="container">
    <header>
        <div id="gnav">
            <ul class="menu">
                <li><a href="/spring/room">객실관리</a></li>
                <li><a href="/spring/reserve">예약관리</a></li>
                <li><a href="/spring/">로그아웃</a></li>
            </ul>
         </div><!--gnav-->
    </header>

    <main>
        <div class="nav">
            <h2>객실목록</h2>
            <select size="13" name="pref" id="selRoom" multiple style="width: 209px;margin-bottom: 10px;margin: 5px 0px 0px 10px;">
            <!--
            <c:forEach items="${list}" var="room">
            	<option value="${room.roomcode}" style="padding: 10px 0px 10px 3px;">
            		${room.roomname}, ${room.typename}, ${room.howmany}, ${room.howmuch}
            	</option>
            </c:forEach>
            -->
            </select>
        </div><!-- nav -->
        
        <div class="choicesystem">
            <div class="loom_choice">
                <table class="choices">
                    <tr>
                        <th>객실이름</th>
                        <td><input type="text" id="txtName" name="loom_name" size="20"><input type="hidden" id="roomcode"></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실분류</th>
                        <td>
                            <select size="7" name="pref" id="selType" multiple style="width: 210px;margin-bottom: 10px;">
                             	<c:forEach items="${type}" var="roomtype">
	            					<option value="${roomtype.typecode}" style="padding: 10px 0px 10px 10px;">
	            						${roomtype.name}
	            					</option>
		           				</c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>숙박가능인원</th>
                        <td><input type="text" id="txtNum" name="a1" size="20">명</td>
                    </tr>
                    <tr>
                        <th>1박요금</th>
                        <td><input type="text" id="txtPrice" name="a1" size="20">원</td>
                    </tr>
                </table>
            </div><!-- loom_choice -->
            <div class="btns">
                <input type="reset" value="등록" class="btn btn-check" id="btnAdd">
                <input type="submit" value="삭제" class="btn btn-delete" id="btnDelete">
                <input type="submit" value="초기화" class="btn btn-clear" id="btnEmpty">
            </div><!-- btns -->
        </div><!-- choicesystem -->
    </main>
    </div><!--container -->

</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.ready(function(){
	$.post("http://localhost:8080/spring/getRoomList",{},function(result){
		console.log(result);
		$.each(result,function(ndx,value){
			str='<option value="'+value['roomcode']+'">'+value['roomname']+','+
				value['typename']+','+value['howmany']+','+value['howmuch']+'</option>';
				$('#selRoom').append(str);
		});
	},'json');
})
.on('click','#selRoom option',function(){
	let str=$(this).text();
	let ar=str.split(',');
	$('#txtName').val(ar[0]);
	$('#selType option:contains("'+ar[1]+'")').attr('selected','selected');
	$('#txtNum').val(ar[2]);
	$('#txtPrice').val(ar[3]);
	let code=$(this).val();
	$('#roomcode').val(code);
	return false;
})
.on('click','#btnEmpty',function(){
	$('#txtName,#txtNum,#txtPrice,#roomcode,#selType').val('');
	return false;
})
.on('click','#btnDelete',function(){
	$.post('http://localhost:8080/spring/deleteRoom',{roomcode:$('#roomcode').val()},
			function(result){
		console.log(result);
		if(result=="ok"){
			$('#btnEmpty').trigger('click');//입력란 비우기
			$('#selRoom option:selected').remove();//
		}
	},'text');
	return false;
})
.on('click','#btnAdd',function(){
	let roomname=String($('#txtName').val());
	let roomtype=String($('#selType').val());
	let howmany=String($('#txtNum').val());
	let howmuch=String($('#txtPrice').val());
	//valdation(유효성검사)
	if( roomname==''||roomtype==''||howmany==''||howmuch=='') {
		alert('누락된 값이 있습니다.');
		return false;
	}
	let roomcode=$('#roomcode').val();
	if(roomcode==''){//insert
		$.post('http://localhost:8080/spring/addRoom',
				{roomname:roomname,rtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=='ok'){		
						location.reload();
					}
				},'text');
	} else {//update
		$.post('http://localhost:8080/spring/updateRoom',
				{roomcode:roomcode,roomname:roomname,roomtype:roomtype,howmany:howmany,howmuch:howmuch},
				function(result){
					if(result=='ok'){
						location.reload();
					}
				},'text');
	}
})
</script>
		<!-- 
		console.log('roomcode ['+roomcode+']');
		console.log('roomname ['+roomname+']');
		console.log('roomtype ['+roomtype+']');
		console.log('howmany ['+howmany+']');
		console.log('howmuch ['+howmuch+']');
		-->
</html>
