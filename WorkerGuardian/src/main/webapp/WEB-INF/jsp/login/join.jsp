<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkerGuardian Main</title>
<link rel="stylesheet" href="/css/login/join.css"/>
<script src="/js/join.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script src="/js/jquery-3.7.1.min.js"></script>
<script>
	$(document).ready(function () {
		
		var dupleChk = false; // 기본 값  false
		var orgChk = false;
		
		$('#USER_ID').on('input', function () {
		    dupleChk = false;
		});
		
		
		$('#dupliBtn').on('click', function(event) {
	        event.preventDefault(); // 폼 제출 막기

	        var inputIdVal = $('#USER_ID').val();

	        if(inputIdVal == "") {
	            alert("빈 값은 확인할 수 없습니다. 올바른 아이디 값을 입력해 주세요.");
	            return false;
	        } else if (inputIdVal.length > 15 || inputIdVal.length < 8) {
	        	alert("아이디는 영문/숫자 포함하여 8~15자 이내로 입력해야 합니다.");
	        	return false;
	        } else {
	            $.ajax({
	                url: "/login/idDupleChk.ajax",
	                data: { "idVal" : inputIdVal },
	                success: function(data) {
	                    var chkMsg = data.chkMsg;
	                    
	                    if(chkMsg == "ok") { // 회원가입 가능
	                    	alert("사용 가능한 아이디입니다.");
	                    	dupleChk = true;
	                    	
	                    } else {
	                    	alert("중복되는 아이디 입니다. 다른 아이디를 입력해 주세요.");
	                    	dupleChk = false;
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.log('ajax 요청에 문제가 있습니다.', error);
	                }
	            });
	        }
	    });
		
		
		$('#orgBtn').on('click', function() {
			event.preventDefault(); // 폼 제출 막기
			
			var orgIdVal = $('#ORG_ID').val();
			if(orgIdVal == "") {
				alert("빈 값은 확인할 수 없습니다. 올바른 문자를 입력해 주세요.");
	            return false;
			} else if(orgChk == true) {
				return false;
			} else if(orgIdVal.length != 5) {
				alert("소속 회사 확인 코드의 길이가 올바르지 않습니다.");
				return false;
			} else {
				$.ajax({
	                url: "/login/orgChk.ajax",
	                data: { "orgVal" : orgIdVal },
	                success: function(data) {
	                    var chkMsg = data.chkMsg;
	                    
	                    if(chkMsg == "ok") { // 회원가입 가능
	                    	alert("소속 회사가 확인 되었습니다.");
	                    	$('#ORG_ID').val(orgIdVal).prop('readonly', true);
	                    	orgChk = true;
	                    	
	                    } else {
	                    	alert("존재하지 않는 회사입니다. 다시 확인해 주세요.");
	                    	orgChk = false;
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.log('ajax 요청에 문제가 있습니다.', error);
	                }
	            });
			}
		});
		
		
		$('.loginBtn').on('click', function(event) {
			event.preventDefault(); //우선 폼 제출 막기

			var password = $('#USER_PW').val();
			var userName = $('#USER_NAME').val();
			var phone = $('#USER_PHONE').val();
			
			if(dupleChk == false) {
				alert("아이디 중복 확인이 되지 않았습니다. 중복 확인 버튼을 눌러 중복 확인해 주세요.");
				return false;
			} else if(password == "") {
				alert("비밀번호를 입력해 주세요.");
				return false;
			} else if(password.length > 15 || password.length < 8) {
				alert("비밀번호는 영문/숫자/특수문자를 포함하여 8~15자 이내로 입력해야 합니다.");
				return false;
			} else if(userName == "") {
				alert("사용자 이름을 입력해 주세요.");
				return false;
			} else if(userName.length < 2) {
				alert("사용자 이름이 올바르지 않습니다. 다시 확인해 주세요.");
				return false;
			} else if(phone.length != 11 || phone.substring(0, 3) !== "010") {
				alert("휴대폰 번호 형식이 올바르지 않습니다. 다시 확인해 주세요.");
				return false;
			} else if(orgChk == false) {
				alert("소속 회사 확인이 되지 않았습니다. 소속 회사 코드를 입력하고 회사 확인 버튼을 눌러 확인해 주세요.");
				return false;
			} else {
				joinFrm.submit(); // 회원가입 submit
			}
		});
		
		
		
		$('#USER_ID').on('input', function () {
		    var value = $(this).val();

		    // 영어 대소문자, 숫자만 허용 (나머지 제거)
		    var cleanValue = value.replace(/[^a-zA-Z0-9]/g, '');

		    if (value !== cleanValue) {
		        $(this).val(cleanValue);
		    }
		});				
		
		$('#USER_NAME').on('input', function () {
		    var value = $(this).val();

		    // 영어, 한글만 허용 (숫자, 특수문자 제거)
		    var cleanValue = value.replace(/[^a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');

		    if (value !== cleanValue) {
		        $(this).val(cleanValue);
		    }
		});
		
		$('#USER_PHONE').on('input', function () {
		    var value = $(this).val();

		    // 숫자만 허용 (나머지 문자 제거)
		    var cleanValue = value.replace(/[^0-9]/g, '');

		    if (value !== cleanValue) {
		        $(this).val(cleanValue);
		    }
		});
		
	});
</script>
</head>
<body>
    <div class="main_div">
        <div class="menu_div"> <!-- 메뉴 div -->
            <div class="logo_div"></div> <!-- 로고 사진 첨부-->
            <div class="menuZip">
                <div class="topMenuDiv">
                    <div class="login"></div>
                    <div class="logout"></div>
                    <div class="mypage"></div>
                    <div class="help"></div>                 
                </div>
                <div class="bottomMenuDiv">
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                    <div class="menu"><h2 style="margin: 0;"></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">로그인</div>
            </div>
        </div>
        <div class="login_div">
            <div class="side_menu_div">
                <ul>
                    <li>
                        <a href='/login/login.do'>로그인</a>
                    </li>
                    <li>
                        <a href='/login/join.do'>회원가입</a>
                    </li>
                </ul>
            </div>
            <div class="login_main_div">
                <div class="title_div">
                    <p style="font-size: 42px; margin: 0;">회원가입</p>
                    <p style="margin:0; color: #444; margin-top: 2px;">WorkerGuardian 시스템을 이용하시려면 회원가입 해 주세요.</p>
                </div>
                <form id="joinFrm" name="joinFrm" action="/login/joinSave.do">
                <div class="join_div">
                    <div class="join_container">
                        <div class="idBox">
                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">아이디</p>
                        </div>
                        <div class="idDivBox" style="display:flex;">
	                        <input type="text" id="USER_ID" name="USER_ID" placeholder="아이디를 입력하세요." style="width:240px; margin-right:10px;" maxlength="15"> 
	                        <button id="dupliBtn">중복 확인</button>
                        </div>
                        <div class="pwBox">
                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">비밀번호</p>
                        </div>
                        <input type="password" id="USER_PW"  name="USER_PW"  placeholder="비밀번호를 입력하세요." maxlength="15">
                        <div class="idBox">
                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">이름</p>
                        </div>
                        <input type="text" id="USER_NAME" name="USER_NAME" placeholder="이름을 입력하세요." maxlength="8">
                        <div class="idBox">
                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">휴대폰 번호</p>
                        </div>
                        <input type="text" id="USER_PHONE" name="USER_PHONE"  placeholder="- 빼고 숫자만 입력" maxlength="11">
                        <div class="idBox">
                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">소속 회사</p>
                        </div>
                        <div class="idDivBox" style="display:flex;">
                        <input type="text" id="ORG_ID"  name="ORG_ID"  placeholder="담당자에게 받은 5자리 문자 입력" style="width:240px; margin-right:10px;" maxlength="5">
                        <button id="orgBtn">회사 확인</button>
                        </div>
                        <button class="loginBtn">
                            회원가입
                        </button>
                    </div>
                </div>
            </form>
            </div>
        </div>
    </div>
</body>
</html>