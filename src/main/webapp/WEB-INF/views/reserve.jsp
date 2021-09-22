<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실관리</title>
    <link href="${pageContext.request.contextPath}/resources/hotel/room.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div id="container">
        <header>
            <div id="gnav">
                <ul class="menu">
                    <li><a href="/spring/room">객실관리</a></li>
                	<li><a href="/spring/reserve">예약관리</a></li>
                	<li><a href="/spring/logout">로그아웃</a></li>
                </ul>
             </div><!--gnav-->
        </header>
    
        <main>
            <div class="space">
                <table class="space_table">
                    <tr>
                        <th>숙박기간</th>
                        <td><input type="date" id="checkin" ><br>~<br><input type="date" id="checkout" ></td>
                    </tr>
                    <tr>
                        <th class="bunlyu">객실분류</th>
                        <td>
                            <select id="possibleday" name="possible_day">
                                <option value="" selected>객실을 선택해 주세요.</option>
                                <option value="Suite Room">Suite Room</option>
                                <option value="Family Room">Family Room</option>
                                <option value="Double Room">Double Room</option>
                                <option value="Single Room">Single Room</option>
                                <option value="Domitory">Domitory</option>
                              </select>
                              <input id="search" type="button" value="찾기">
                        </td>
                    </tr>
                </table>
                <div class="possible_list">
                        <h2>예약가능</h2>
                            <select id="possible_list" size="7" name="pref">
                             </select>
                </div><!-- possible_list -->
            </div><!-- space -->


            <div class="choicesystem">
                <div class="loom_choice">
                    <table class="choices">
                        <tr>
                            <th>객실이름</th>
                            <td><input id="roomname" type="text" name="loom_name" size="20"><input type="hidden" id="roomcode"></td>
                        </tr>
                        <tr>
	                        <th class="bunlyu">객실분류</th>
		                        <td>
		                            <select size="5" name="pref" id="selType" style="width: 178px;margin-bottom:20px;">
		                             	<c:forEach items="${type}" var="roomtype">
			            					<option value="${roomtype.typecode}">
			            						${roomtype.name}
			            					</option>
				           				</c:forEach>
		                            </select>
		                        </td>
                    	</tr>
                        <tr>
                            <th class="bunlyu">숙박기간</th>
                            <td><input class="bunlyu1" id="checkin1" type="date">~<input class="bunlyu2" id="checkout1" type="date"> (N박)</td>
                        </tr>
                        <tr>
                            <th>숙박인원</th>
                            <td><input id="howmany" type="text" name="a1" size="20" min="1" > 명</td>
                        </tr>
                        <tr>
                            <th>최대인원</th>
                            <td><input id="max_howmany" type="text" name="a1" size="20" min="1" > 명</td>
                        </tr>
                        <tr>
                            <th>총 숙박비</th>
                            <td><input id="total" type="number" name="a1" size="20" min="1" > 원
                            	<input id="price" type="hidden">
                            </td>
                        </tr>
                        <tr>
                            <th>예약자명</th>
                            <td><input id="booker" type="text" name="booker" size="20"></td>
                        </tr>
                        <tr>
                            <th>예약자 모바일</th>
                            <td><input id="mobile" type="text" name="a1" size="20"></td>
                        </tr>
                    </table>
                </div><!-- loom_choice -->
                <div class="btns">
                    <input type="reset" id="btnBook" value="등록" class="btn btn-check">
                    <input type="submit" id="btnDelete" value="삭제" class="btn btn-delete">
                    <input type="submit" id="btnEmpty" value="초기화" class="btn btn-clear">
                </div><!-- btns -->
            </div><!-- choicesystem -->


            <div class="impossible_list">
                <h2>예약불가능</h2>
                    <select size="7" id="selBooked_list" name="pref"></select>
            </div><!--  impossible_list -->

        </main>

        </div><!--container -->
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#search',function(){
	if($('#checkin').val()=='' || $('#checkout').val()==''){
		alert('숙박기간을 선택해 주세요.')
	}
	console.log('checkin ['+$('#checkin').val()+']');
	console.log('checkout ['+$('#checkout').val()+']');
	$.post("http://localhost:8080/spring/getBookList",
			{checkin:$('#checkin').val(), checkout:$('#checkout').val()},function(result){
				console.log(result);
				$.each(result,function(ndx,value){
					str='<option value="'+value['bookcode']+'">'+value['roomcode']+','+value['roomname']+','+
						value['howmany']+','+value['checkin']+','+value['checkout']+','
						+value['total']+','+value['booker']+','+value['mobile']+'</option>';
						$('#selBooked_list').append(str);
				});
			},'json');	
	$.post("http://localhost:8080/spring/getAvailable",
			{checkin:$('#checkin').val(), checkout:$('#checkout').val()},function(result){
				console.log(result);
				$.each(result,function(ndx,value){
					str='<option value="'+value['roomcode']+'">'+value['roomname']+','
					+value['typename']+','+value['howmany']+','+value['howmuch']+'원'+'</option>';
						$('#possible_list').append(str);
				});
			},'json');
	
})

 .on('click','#possible_list option',function(){
	$('#roomcode').val($(this).val());
	let str=$(this).text();
	let ar=str.split(',');
	$('#roomname').val(ar[0]);
	$('#selType option:contains("'+ar[1]+'")').prop('selected',true);
	$('#max_howmany').val(ar[2]);
	$('#price').val(ar[3]);
	$('#checkin1').val($('#checkin').val());
	$('#checkout1').val($('#checkout').val());
	$('#checkin1,#checkout1').trigger('change');
	return false;
})
.on('click','#btnBook',function(){
	let roomcode=$('#roomcode').val();
	if($('#roomname').val()==''){
		alert('객실이 선택되어야 합니다.');
		return false;
	}
	if($('#howmany').val()=='' || isNaN($('#howmany').val())){
		alert('숙박예정인원이 입력되어야 합니다.');
		return false;
	}
	if($('#max_howmany').val()=='' || isNaN($('#max_howmany').val())){
		alert('총숙박(가능)인원이 입력되어야 합니다.');
		return false;
	}
	if($('#checkin1').val()=='' || $('#checkout1').val()==''){
		alert('숙박기간이 입력되어야 합니다.');
		return false;
	}
	if($('#total').val()==''){
		alert('총숙박비가 계산되지 않았습니다.');
		return false;
	}
	if($('#booker').val()==''){
		alert('예약자명이 입력되어야 합니다.');
		return false;
	}
	if($('#mobile').val()==''){
		alert('예약자의 연락처가 입력되어야 합니다.');
		return false;
	}

	$.post('http://localhost:8080/spring/addBook',
	         {roomcode:$('#roomcode').val(),howmany:$('#howmany').val(),
	         checkin:$('#checkin').val(),checkout:$('#checkout').val(),
	         total:$('#total').val(),booker:$('#booker').val(),
	         mobile:$('#mobile').val()},
	         function(result){
	            if(result=='ok'){
	               pstr='<option value="'+$('#roomcode').val()+'">'+
	               $('#roomname').val()+','+$('#selType option:selected').val()+','+
	               $('#howmany').val()+'/'+$('#checkin1').val()+'~'+$('#checkout1').val()+','+
	               $('#booker').val()+','+$('#mobile').val()+'</option>';
	               $('#selBooked_list').append(pstr);
	               $('#btnEmpty').trigger('click');
	            } else {
	               alert('예약이 완료되지 않았습니다.(DBinsert오류)');
	            }
	         },'text');
	   return false;
})
.on('click','#selBooked_list option',function(){
	let str=$(this).text();
	let ar=str.split(',');
	$('#roomname').val(ar[1]);
	$('#selType option:contains("'+ar[2]+'")').prop('selected',true);
	$('#max_howmany').val(ar[2]);
	$('#price').val(ar[5]);
	$('#checkin1').val($('#checkin').val());
	$('#checkout1').val($('#checkout').val());
	$('#booker').val(ar[6]);
	$('#mobile').val(ar[7]);
	$('#checkin1,#checkout1').trigger('change');
	return false;
})

.on('change','#checkin1,#checkout1',function(){
	let checkin=$('#checkin1').val();
	let checkout=$('#checkout1').val();
	if(checkin=='' || checkout=='') return false;
	checkin=new Date(checkin);
	checkout=new Date(checkout);
	if(checkin > checkout){
		alert('체크인날짜가 체크아웃보다 나중일 수 없습니다.');
		return false;
	}
	let ms=Math.abs(checkout-checkin);
	let days=Math.ceil(ms/(1000*60*60*24));
	let total=days*parseInt($('#price').val());
	$('#total').val(total);
	return false;
})

.on('click','#btnEmpty',function(){
	$('#roomcode,#roomname,#selType,#howmany,#max_howmany,#checkin1,#checkout1,#total,#price,#booker,#mobile').val('');
	return false;
})

</script>
</html>