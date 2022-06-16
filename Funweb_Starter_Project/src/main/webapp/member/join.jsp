<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// submit 작업을 수행하기 전 각 작업의 완료 여부를 체크할 변수(전역변수) 선언
	var checkIdResult = false; // ID 중복확인 체크 변수
	var checkRetypePassResult = false; // 패스워드 중복확인 체크 변수
	
	function openCheckIdWindow() {
		window.open("check_id.jsp", "", "width=400,height=250");
	}
	
	// 2. 비밀번호 입력란에 키를 누를때마다 비밀번호 길이 체크하기
	// => 체크 결과를 비밀번호 입력창 우측 빈공간에 표시하기
	// => 비밀번호 길이 체크를 통해 8 ~ 16글자 사이이면 "사용 가능한 패스워드"(파란색) 표시,
    // 아니면, "사용 불가능한 패스워드"(빨간색) 표시
	function checkPass(pass) {
		// span 태그 영역(checkPasswdResult)
		var span_checkPassResult = document.getElementById("checkPassResult");
		
		// 입력된 패스워드 길이 체크
		if(pass.length >= 8 && pass.length <= 16) {
			span_checkPassResult.innerHTML = "사용 가능한 패스워드";
			span_checkPassResult.style.color = "BLUE";
		} else {
			span_checkPassResult.innerHTML = "사용 불가능한 패스워드";
			span_checkPassResult.style.color = "RED";
		}
	}
	
	// 비밀번호확인 입력란에 키를 누를때마다 비밀번호와 같은지 체크하기
	function checkConfirmPass(confirmPass) {
		// 패스워드 입력란에 입력된 패스워드를 가져와야지 비교를 할 수 있다.
		var pass = document.fr.pass.value;
		
		var span_checkConfirmPassResult = document.getElementById("checkConfirmPassResult");
		
		// 패스워드 일치 여부 판별
		if(pass == confirmPass) { // 일치할 경우
			span_checkConfirmPassResult.innerHTML = "비밀번호 일치";
			span_checkConfirmPassResult.style.color = "GREEN";
			
			// 패스워드 일치 여부 확인을 위해 checkRetypePassResult 변수값을 true 로 변경
			checkRetypePassResult = true;
		} else { // 일치하지 않을 경우
			span_checkConfirmPassResult.innerHTML = "비밀번호 불일치";
			span_checkConfirmPassResult.style.color = "RED";

			checkRetypePassResult = false;
		}
	}
	
	// 전화번호 숫자 입력할때마다 길이 체크하기
	function checkPhone1(phone1) {
		if(phone1.length == 3) {
			document.fr.phone2.focus(); // 커서 요청(포커스 요청)
		}
	}
	
	function checkPhone2(phone2) {
		if(phone2.length == 4) {
			document.fr.phone3.focus(); // 커서 제거(포커스 해제)
		}
	}
	
	function checkPhone3(phone3) {
		if(phone2.length == 4) {
			document.fr.email1.focus(); // 커서 제거(포커스 해제)
		}
	}
	
	function selectDomain(domain) {
		document.fr.email2.value = domain;
		
		// 만약, "직접입력" 항목 선택 시 도메인 입력창(email2)에 커서 이동
		if(domain == "") { // "직접입력" 선택 시 domain에 "" 값이 전달
			document.fr.email2.disabled = false; // 입력창 잠금 해제
			document.fr.email2.focus(); // 커서 요청
		} else { // 다른 도메인 선택 시
			document.fr.email2.disabled = true; // 입력창 잠금
		} 
	}
	
	// 다음 주소 검색해서 뿌리는 작업
	// 아직 밑에 안 연결을 안해놔서 연결해보면서 작업할 것
	    function kakaoPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
	
	function checkForm() {
	    if(!checkIdResult) { // 아이디 중복확인을 수행하지 않은 경우
	    	alert("아이디 중복확인 필수!");
	    	return false;
	    } else if(!checkRetypePassResult) {
	    	alert("패스워드 확인 필수!");
	    	document.fr.pass2.focus();
	    	return false;
	    } else if(document.fr.phone1.value.length != 3) {
	    	alert("전화번호 입력 필수!");
	    	document.fr.phone1.focus();
	    	return false;
	    } else if(document.fr.phone2.value.length != 4) {
	    	alert("전화번호 입력 필수!");
	    	document.fr.phone2.focus();
	    	return false;
	    } else if(document.fr.phone3.value.length != 4) {
	    	alert("전화번호 입력 필수!");
	    	document.fr.phone3.focus();
	    	return false;
	    } else if(document.fr.detailAddress.value.length == 0) {
	    	alert("상세주소 입력 필수!");
	    	document.fr.detailAddress.focus();
	    	return false;
	    }
	    
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkForm()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Nickname</label>
		  			<input type="text" name="nickname" id="nickname" required="required"><br>
		  			
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" readonly="readonly" required="required">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()">
		  			<br>
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" onkeyup="checkPass(this.value)" placeholder="8 ~ 16글자 사이 입력" required="required">
		  			<span id="checkPassResult"></span>
		  			<br> 			
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" onkeyup="checkConfirmPass(this.value)" required="required">
		  			<span id="checkConfirmPassResult"></span>
		  			<br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>Phone Number</label>
		  			<input type="text" name="phone1" class="phone" id="phone" onkeyup="checkPhone1(this.value)" required="required"> -
					<input type="text" name="phone2" class="phone" id="phone" onkeyup="checkPhone2(this.value)" required="required"> -
					<input type="text" name="phone3" class="phone" id="phone" onkeyup="checkPhone3(this.value)" required="required">
					<br>
					
					<label>Post code</label>
		  			<input type="text" name="postcode" id="postcode" placeholder="우편번호" readonly="readonly" required="required">
		  			<input type="button" class="dup" onclick="kakaoPostcode()" value="우편번호 찾기"><br>
		  			<label>Address</label>
		  			<input type="text" name="address" id="address" placeholder="주소" size="55" readonly="readonly" required="required"><br>
		  			<label>&nbsp;</label>
		  			<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" size="29" required="required">
		  			<input type="text" name="extraAddress" id="extraAddress" placeholder="참고정보" readonly="readonly" required="required">
		  			<br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Gender</label>
		  			<input type="radio" name="gender" value="남">남
					<input type="radio" name="gender" value="여">여
					<br>
		  			<label>Job</label>
		  			<select name="job" required="required">
						<option value="기타">기타</option>
						<option value="주부">주부</option>
						<option value="직장인">직장인</option>
						<option value="사업가">사업가</option>
						<option value="학생">학생</option>
					</select><br>
		  			<label>E-Mail</label>
		  			<input type="text" name="email1">@
					<input type="text" name="email2">
					<select name="emailDomain" onchange="selectDomain(this.value)">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="daum.net">daum.net</option>
					</select><br>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


