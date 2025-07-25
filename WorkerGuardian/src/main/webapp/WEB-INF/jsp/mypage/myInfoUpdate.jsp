<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/mypage/mypageUpdate.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	
        
        	
        	
        	// 도움말 파일 다운로드하기
            $('.help').on('click', function() {
            	helpDownLoad();
    		});
	     	
	     	// 로그아웃 버튼
            $('.logout').on('click', function() {
            	logoutChk();
	        });
        	
	     	
         	// 마이페이지 버튼
	     	$('.mypage').on('click', function() {
	     		mypageGo();
	     	});
         	
         	
         	// 내 정보 변경   
	     	$('#myInfoUpdate').on('click', function() {
	     		myInfoUpdateGo();
	     	});
         	
	     	$('#myInfo').on('click', function() {
	     		mypageGo();
	     	});
	     
	     	
	     	
	     	
	     	$('#USER_PHONE').on('input', function () {
	     	    let value = $(this).val();
	     	    
	     	    // 숫자만 남기고 나머지는 제거
	     	    let onlyNumbers = value.replace(/[^0-9]/g, '');

	     	    if (value !== onlyNumbers) {
	     	        $(this).val(onlyNumbers);
	     	    }
	     	});
	     	
	     	
	     	//updateBtn
	     	$('.updateBtn').on('click', function() {
	     		var user_pw = $('#USER_PW').val();
	     		var user_pw_chk = $('#USER_PW_CHK').val();
				var user_phone = $('#USER_PHONE').val();
				var user_name = $('#USER_NAME').val();
				
	     		// 유효성 검사식 작성
	     		if(user_pw !== user_pw_chk) {
	     			alert("입력하신 비밀번호와 비밀번호 확인이 일치하지 않습니다. 다시 확인해 주세요");
	     			return false;
	     		} else if (
	     			    user_pw !== "" && 
	     			    (user_pw.length < 8 || /[^a-zA-Z0-9!@#$%^&*(),.?":{}|<>_\-\\[\]~`+=;'\/]/.test(user_pw))
	     			) {
	     			    alert("비밀번호는 영어/숫자/특수문자를 포함하여 8~15자 이내여야 합니다.");
	     			    return false;
	     			} else if(user_name == "") {
	     			alert("사용자 이름을 입력하세요");
	     			return false;
	     		} else if(user_name.length < 2) {
	     			alert("사용자 이름은 2~8자 이내여야 합니다.");
	     			return false;
	     		} else if(user_phone.length < 11 || user_phone.substring(0, 3) !== "010") {
	     			alert("휴대폰 번호가 올바르지 않은 형식입니다. 다시 확인해 주세요.");
	     			return false;
	     		} else if(user_phone == "") {
	     			alert("휴대폰 번호를 입력하세요");
	     			return false;
	     		} else {
	     			var check = confirm("이대로 저장합니까?");
	     			console.log(user_pw);
	     			if(check) {
	     				alert("저장되었습니다.");
		     			infoFrm.submit();
	     			} else {
	     				return false;
	     			}
	     		}
	     		
	     	});
	     	
	     	
	     	$('.beforeBtn').on('click', function() {
            	var check = confirm("입력한 정보가 사라집니다. 그래도 이전으로 돌아가시겠습니까?");
            	
            	if(check == true) {
            		// 이전 화면으로 이동
            		history.back();
            	} else {
            		return false;
            	}
            });
        	
            
        });  
            
    </script>
</head>
<body>
    <div class="main_div">  <!-- 메인 div -->
        <div class="menu_div"> <!-- 메뉴 div -->
            <div class="logo_div"></div> <!-- 로고 사진 첨부-->
            <div class="menuZip">
                <div class="topMenuDiv">
                    <div class="login"><p>${loginInfo.USER_NAME}님</p></div>
                    <div class="logout"><p>로그아웃</p></div>
                    <div class="mypage"><p>마이페이지</p></div>
                    <div class="help"><p>도움말</p></div>
                    <input type="hidden" id="userInfo" value="${loginInfo.USER_ID}"></input>
                </div>
                <div class="bottomMenuDiv">
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/first.do'>현장 모니터링</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/view/viewInventory.do'>현장 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/safeevent/safeEvent.do'>안전 이벤트</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/beacon/beaconInventory.do'>비콘 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/gas/gasInventory.do'>가스 센서 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/worker/workerInventory.do'>작업자 관리</a></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">마이페이지</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">내 정보 변경</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;">마이페이지</p>
                </div>
                <div class="site_menu_div">
					<div id="myInfo" class="site-item">
						내 정보
					</div>
					<div id="myInfoUpdate" class="site-item highlight">
						내 정보 변경
					</div>
                </div>
                <div class="site_insert_btn_div">

                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">내 정보 변경</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">사용자 상세 정보</p>
                    </div>
                    <div class="table_div">
                    <form id="infoFrm" name="infoFrm" action="/mypage/updateInfoSave.do">
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                            	<tr>
                                    <th scope="row">비밀번호 변경</th>
                                    <td style="padding : 5px 10px;">
                                    	<input type="password" id="USER_PW" name="USER_PW" placeholder="변경 시에만 입력" maxlength="15"></input>
                                    </td>
                                    <th scope="row">비밀번호 변경 확인</th>
                                    <td style="padding : 5px 10px;">
                                    	<input type="password" id="USER_PW_CHK"  placeholder="변경 시에만 입력" maxlength="15"></input>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">사용자 이름</th>
                                    <td style="padding : 5px 10px;">
                                    	<input type="text" name="USER_NAME" id="USER_NAME" value="${loginInfo.USER_NAME}" maxlength="8"></input>
                                    </td>
                                    <th scope="row">휴대폰 번호</th>
                                    <td style="padding : 5px 10px;">
                                    	<input type="text" id="USER_PHONE" name="USER_PHONE" value="${loginInfo.USER_PHONE}" placeholder="- 제외, 숫자만 입력" maxlength="11"></input>                                    	
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">소속(회사)</th>
                                    <td>${loginInfo.USER_ORG}</td>
                                    <th scope="row">가입 일자</th>
                                    <td>${loginInfo.REG_DATE}</td>
                                </tr>
                            
                            </tbody>
                        </table>                       
                        
                       </form>
                    </div>
                </div>
                <div class="btn_div">
                    <div class="beforeBtn">
                        <p>취소</p>
                    </div>
                    <div class="updateBtn">
                        <p>저장</p>
                    </div>
                </div>
                <form id="frmSite" name="frmSite" method="post">
                	<input type="hidden" id="site_id" name="SITE_ID"></input>
                </form>
            </div>
        </div>
    </div>
</body>
</html>