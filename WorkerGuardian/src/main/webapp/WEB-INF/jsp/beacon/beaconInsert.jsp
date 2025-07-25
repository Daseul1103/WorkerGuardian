<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/beacon/beaconInsert.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	
        	//ajax 사용하여 천 진입 시 현장 목록 불러오기
        	$.ajax({
	            url: "/beacon/selectBeacon.ajax",
	            success: function(data) {
	            	var beaconList = data.BeaconList;
	                var html = '';

	                if (Array.isArray(beaconList) && beaconList.length > 0) {
	                	beaconList.forEach(function(beacon) {
	                        html += '<div id="' + beacon.uuid + '" class="site-item">' + beacon.beacon_NAME + '</div>\n';
	                    });
	                } else {
	                    html = '<div class="not_site">등록된 비콘이 없습니다.</div>';
	                }

	                // 클래스명이 site_menu_div인 요소 안에 삽입
	                $('.site_menu_div').html(html);
	            },
	            error: function(xhr, status, error) {
	                console.log('ajax 요청에 문제가 있습니다.',error);
	            }
	        });
        	
        	
        	// 현장 선택 정보 불러오기
        	$.ajax({
			    url: "/beacon/selectStie.ajax",
			    success: function(data) {
			        var siteList = data.siteList;
			        var html = '';
			
			        html += '<select id="SITE_ID" name="SITE_ID" disabled>\n';
			
			        html += '<option value="none">적용 현장 선택</option>\n';
			        
			        siteList.forEach(function(site) {
			            html += '<option value="' + site.site_ID + '">' + site.site_NAME + '</option>\n';
			        });
			
			        html += '</select>';
			
			        // #siteSelect 요소 안에 select 박스 삽입
			        $('#siteSelect').html(html);
			    },
			    error: function(xhr, status, error) {
			        console.log('ajax 요청에 문제가 있습니다.', error);
			    }
			});
        	
        	
        	// 제한 구역 적용에 따른 적용 현장 선택 막기
        	$('.limit_flag').on('click', function() {
			    var selectedValue = $('input[name="LIMIT_FLAG"]:checked').val();
			
			    if (selectedValue === 'Y') {
			        // Y인 경우 모두 활성화 (입력 가능)
			        $('#SITE_ID, #DANGER_DISTANCE, #BEACON_X, #BEACON_Y').prop('disabled', false);
			    } else {
			    	$('#SITE_ID').val('none').prop('disabled', true);

			        // input text 요소는 값 비우고 비활성화
			        $('#DANGER_DISTANCE, #BEACON_X, #BEACON_Y')
			            .val('')
			            .prop('disabled', true);
			    }
			});
        	
        	

        	
        	// 현장 클릭 시 이벤트(정보 불러오기)
        	$('.site_menu_div').on('click', '.site-item', function() {
        	    var clickedId = $(this).attr('id'); // 선택된 요소 아이디 가져오기
        	    
        	    // 선택한 현장으로 이동하기
        	    window.location.href = '/beacon/beaconDetail.do?uuid=' + clickedId;
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
            

            $('.insertBtn').on('click', function() {
            	// 유효성 검사
            	var beacon_name = $('#BEACON_NAME').val();
            	var uuid = $('#UUID').val();
            	var major = $('#MAJOR').val();
            	var minor = $('#MINOR').val();
            	
            	if(beacon_name == "") {
            		alert("비콘 이름을 입력해 주세요.");
            		return false;
            	} else if(uuid == "") {
            		alert("UUID 값을 입력해 주세요.");
            		return false;
            	} else if(major == "") {
            		alert("Major 값을 입력해 주세요.");
            		return false;
            	} else if(minor == "") {
            	 	alert("Minor 값을 입력해 주세요.");
            	 	return false;
            	} else {
            		var check = confirm("이대로 등록합니까?");
            		
            		if(check == true) {
                		frmBeacon.submit();
                	} else {
                		return false;
                	}
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
         	
         	
	     	$('#UUID').on('input', function () {
	     	    var value = $(this).val();
	     	    
	     	    // 숫자, 영문 대소문자, 하이픈(-)만 남기고 모두 제거
	     	    var cleanValue = value.replace(/[^a-zA-Z0-9-]/g, '');
	     	    
	     	    if (value !== cleanValue) {
	     	        $(this).val(cleanValue); // 잘못된 문자 제거
	     	    }
	     	});
            
	     	
	     	$('#BEACON_NAME').on('keypress', function(e) {
	     	    var charCode = e.which || e.keyCode;
	     	    var charStr = String.fromCharCode(charCode);

	     	    // 한글, 영어, 숫자만 허용 (정규식을 사용하여 검사)
	     	    var regex = /^[a-zA-Z0-9가-힣]$/;

	     	    if (!regex.test(charStr)) {
	     	      e.preventDefault(); // 특수문자 입력 방지
	     	    }
	     	  });
	     	
	     	$('#MAJOR, #MINOR, #DANGER_DISTANCE, #BEACON_X, #BEACON_Y').on('input', function () {
	     	    let value = $(this).val();
	     	    
	     	    // 숫자만 남기고 나머지는 제거
	     	    let onlyNumbers = value.replace(/[^0-9]/g, '');

	     	    if (value !== onlyNumbers) {
	     	        $(this).val(onlyNumbers);
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
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/beacon/beaconInventory.do'>비콘 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/gas/gasInventory.do'>가스 센서 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/worker/workerInventory.do'>작업자 관리</a></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">비콘 관리</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">비콘 등록</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;">비콘 관리</p>
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
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">비콘 신규 등록</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div> 
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">정보 입력</p>
                    </div>
                    <div class="table_div">
                    <form id="frmBeacon" name="frmBeacon" method="post" action="/beacon/beaconSave.do">
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">비콘 이름</th>
                                    <td><input type="text" id="BEACON_NAME" name="BEACON_NAME" maxlength="15"/></td>
                                    <th scope="row">UUID</th>
                                    <td><input type="text" id="UUID" name="UUID"/></td>
                                </tr>
                                <tr>
                                    <th scope="row">Major</th>
                                    <td><input type="text" id="MAJOR" name="MAJOR"/></td>
                                    <th scope="row">Minor</th>
                                    <td><input type="text" id="MINOR" name="MINOR"/></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mini_title">
                            <p style="font-size: 26px; margin: 0;">제한 구역 정보</p>
                        </div>
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">제한 구역 적용</th>
                                    <td colspan="3" style="display: flex; align-items: center; border-bottom:none;">
                                    <input type="radio" name="LIMIT_FLAG" value="Y" id="Yes" class="limit_flag" style="margin: 0;"/>
                                    <label for="Yes" style="margin-left: 10px; margin-right: 20px;">
                                    	 예
                                    </label>
                                    <input type="radio" name="LIMIT_FLAG" value="N" id="No" class="limit_flag" style="margin: 0;"/> 
                                    <label for="No" style="margin-left: 10px; margin-right: 20px;">
                                    	아니오
                                    </label>
                                    
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">적용 현장 선택</th>
                                    <td id="siteSelect"></td>
                                    <th scope="row" style="border-top:1px solid #eceff0;">비콘 위험 거리</th>
                                    <td><input type="text" id="DANGER_DISTANCE" name="DANGER_DISTANCE" style="margin-right:10px;" disabled/>m</td>
                                </tr>
                                <tr>
                                    <th scope="row">비콘 X축 위치</th>
                                    <td><input type="text" id="BEACON_X" name="BEACON_X" style="margin-right:10px;" disabled/>%</td>
                                    <th scope="row">비콘 Y축 위치</th>
                                    <td><input type="text" id="BEACON_Y" name="BEACON_Y" style="margin-right:10px;" disabled/>%</td>
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
                    <div class="insertBtn">
                        <p>등록</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>