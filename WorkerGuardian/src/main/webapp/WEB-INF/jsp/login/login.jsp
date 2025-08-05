<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian Main</title>
	<link rel="stylesheet" href="/css/login/login.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
    <script>
	    $(document).ready(function () {
	    	
	    	
	    	// 로그인  버튼 클릭 시
	    	$('.loginBtn').on('click', function(){
	    		console.log("버튼 클릭");
	    		
	    		var idVal = $('#idVal').val();
	    		var pwVal = $('#pwVal').val();
	    		
	    		if(idVal == '') {
	    			$('#idAlram').text("아이디를 입력해 주세요.");
	    			$('#idAlram').show();
	    		} else {
	    			$('#idAlram').hide();
	    		}
	    		
	    		if(pwVal == '') {
	    			$('#pwAlram').text("비밀번호를 입력해 주세요.");
	    			$('#pwAlram').show();
	    		} else {
	    			$('#pwAlram').hide();
	    		}
	    		
	    		if(idVal != '' && pwVal != '') { // id와 pw 모두 입력 했다면
	    			
	    			// ajax로 정보 가져오기   
	    			$.ajax({
	    	            url: "/login/loginUser.ajax",
	    	            data : {"user_id" : idVal , "user_pw" : pwVal},
	    	            success: function(data) {
	    	            	var result = data.msg;
	    	            	
	    	            	if(result == "noInfo") {
								// 안내 메세지 띄우기
								alert("아이디 또는 비밀번호 정보가 일치하지 않습니다. 다시 확인해주세요.");
	    	            	} else {
	    	            		window.location.href = '/first.do';
	    	            	}
	    	            },
	    	            error: function(xhr, status, error) {
	    	                console.log('ajax 요청에 문제가 있습니다.',error,xhr, status);
	    	            }
	    	        });

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
            <div class="login_main_div">
                <div class="title_div">
                    <p style="font-size: 42px; margin: 0;">로그인</p>
                    <p style="margin:0; color: #444; margin-top: 2px;">WorkerGuardian 시스템을 이용하시려면 로그인 해 주세요.</p>
                </div>
                	<div class="join_div">
	                    <div class="join_container">
	                        <div class="idBox">
	                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">아이디</p>
	                            <p id="idAlram" style=" margin:0; font-size: 14px; color: red; margin-left: 228px; display:none;"></p>
	                        </div>
	                        <input type="text" placeholder="아이디를 입력하세요." id="idVal" />
	                        <div class="pwBox">
	                            <p style="margin: 0; font-weight: bold; margin-bottom: 5px;">비밀번호</p>
	                            <p id="pwAlram" style=" margin:0; font-size: 14px; color: red; margin-left: 206px; display:none;"></p>
	                        </div>
	                        <input type="password" placeholder="비밀번호를 입력하세요." id="pwVal" />
	                        <button class="loginBtn">
	                            	로그인
	                        </button>
	                        <p style="color: #ccc; font-size: 14px; margin-left: 28%; cursor: pointer;"><a href='/login/join.do' style="color: #ccc;">계정이 없으신가요? | 회원가입</a></p>
	                    </div>
	                </div>
            </div>
        </div>
    </div>
</body>
</html>