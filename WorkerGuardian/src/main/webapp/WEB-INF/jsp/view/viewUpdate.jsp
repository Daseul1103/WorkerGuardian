<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/view/viewUpdate.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {	
        	
        	var nowId = "${data.SITE_ID}"; // 문자열로 처리해야 오류 없음

        	$.ajax({
        	    url: "/view/selectSite.ajax",
        	    success: function(data) {
        	        console.log("진입 완료");
        	        console.log(data);

        	        var siteList = data.SiteList;
        	        var html = '';

        	        siteList.forEach(function(site) {
        	            var highlightClass = (site.site_ID === nowId) ? ' highlight' : '';
        	            html += '<div id="' + site.site_ID + '" class="site-item' + highlightClass + '">' + site.site_NAME + '</div>\n';
        	        });

        	        $('.site_menu_div').html(html);
        	    },
        	    error: function(xhr, status, error) {
        	        console.log('ajax 요청에 문제가 있습니다.', error);
        	    }
        	});
        	
            var $div = $('.site_menu_div');
            if ($div.prop('scrollHeight') > 300) {
                $div.css('height', '540px');
            } else {
                $div.css('height', 'auto');
            }
            
            $('.beforeBtn').on('click', function() {
            	var check = confirm("입력한 정보가 사라집니다. 그래도 이전으로 돌아가시겠습니까?");
            	
            	if(check == true) {
            		// 이전 화면으로 이동
            		history.back();
            	} else {
            		return false;
            	}
            });
            
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
         	
         	
	     	$('#SITE_NAME').on('keypress', function(e) {
	     	    var charCode = e.which || e.keyCode;
	     	    var charStr = String.fromCharCode(charCode);

	     	    // 한글, 영어, 숫자만 허용 (정규식을 사용하여 검사)
	     	    var regex = /^[a-zA-Z0-9가-힣]$/;

	     	    if (!regex.test(charStr)) {
	     	      e.preventDefault(); // 특수문자 입력 방지
	     	    }
	     	  });
	     	
	     	var firstCheck = false;
            $('.updateBtn').on('click', function() {
                
                checkFormValidity();
                
                if(firstCheck) {
                	var check = confirm("이대로 저장합니까?");
                	
                	if(check == true) {
                		// 등록 알리고 현장 관리 화면으로 이동
                		var files = $('input[name="multiFile"]')[0].files;

    					if (files.length === 0) {
    					    $('#fileUpType').val("N");
    					} else {
    					    $('#fileUpType').val("Y");
    					}
    					
                		
                		alert("저장 되었습니다.");
                		updateFrm.submit();
                		
                	} else {
                		return false;
                	}
                }
            });
  
            function checkFormValidity() {
            	var site_name = $('#SITE_NAME').val();
            	var files = $('#multiFile')[0].files;
            	let allowedExtensions = ['jpg', 'png'];
            	let isValid = true;

            	// 현장 이름 유효성 검사
            	if (!site_name || site_name.trim() === '') {
            	    alert('현장 이름을 입력해주세요.');
            	    isValid = false;
            	} else if (site_name.length < 2 || site_name.length > 10) {
            	    alert('현장 이름은 2~10자 이내로 입력해야 합니다.');
            	    isValid = false;
            	} else if (files.length === 1) {
            		let ext = files[0].name.split('.').pop().toLowerCase();
            	    if (!allowedExtensions.includes(ext)) {
            	        alert('jpg 또는 png 파일만 업로드할 수 있습니다.');
            	        isValid = false;
            	    }
            	} else if (files.length > 1) {
            	    alert('파일은 1개만 업로드할 수 있습니다.');
            	    isValid = false;
            	} 
            	
            	
            	if (isValid) {
            		firstCheck = true;
            	} else {
            		firstCheck = false;
            	}
            	
            }
            
            
            
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
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/view/viewInventory.do'>현장 관리</a></h2></div>
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
                <div class="menu1" style="color: white; font-size: 16px;">현장 관리</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">현장 정보 수정</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;">현장 관리</p>
                </div>
                <div class="site_menu_div">

                </div>
                <div class="site_insert_btn_div">
                    <!--<div class="site_insert_btn">
                        <p>현장 추가</p>
                    </div>-->
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">${data.SITE_NAME} 정보 수정</p>
                    </div>
                    <div class="breadcrumb">
                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">수정 정보 입력</p>
                    </div>
                    <div class="table_div">
                    <form id="updateFrm" name="updateFrm" action="/view/siteUpdate.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="site_id" name="SITE_ID"  value="${data.SITE_ID}"></input>
                        <input type="hidden" id="file_name" name="FILE_NAME"  value="${data.FILE_NAME}"></input>
                        <input type="hidden" id="fileUpType" name="fileUpType"></input>
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">현장 이름</th>
                                    <td colspan="3"><input type="text" name="SITE_NAME" id="SITE_NAME" value="${data.SITE_NAME}"></td>
                                </tr>
                                <tr>
                                    <th scope="row">현장 파일</th>
                                    <td colspan="3"><input type="file" id="multiFile" name="multiFile" multiple></td>
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
            </div>

        </div>
    </div>
</body>
</html>