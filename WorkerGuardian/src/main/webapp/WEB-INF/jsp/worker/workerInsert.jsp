<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/worker/workerInsert.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	
        	//ajax 사용하여 첫 진입 시 현장 목록 불러오기
        	$.ajax({
	            url: "/worker/selectWorker.ajax",
	            success: function(data) {
	            	
	            	var workerList = data.WorkerList;
	                var html = '';

	                if (Array.isArray(workerList) && workerList.length > 0) {
	                	workerList.forEach(function(worker) {
	                        html += '<div id="' + worker.worker_ID + '" class="site-item">' + worker.worker_NAME + '</div>\n';
	                    });
	                } else {
	                    html = '<div class="not_site">등록된 작업자가 없습니다.</div>';
	                }

	                // 클래스명이 site_menu_div인 요소 안에 삽입
	                $('.site_menu_div').html(html);
	            },
	            error: function(xhr, status, error) {
	                console.log('ajax 요청에 문제가 있습니다.',error);
	            }
	        });
        	
        	$.ajax({
			    url: "/beacon/selectStie.ajax",
			    success: function(data) {
			        var siteList = data.siteList;
			        var html = '';
			
			        html += '<select id="SITE_ID" name="SITE_ID">\n';
			
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

        	
        	// 현장 클릭 시 이벤트(정보 불러오기)
        	$('.site_menu_div').on('click', '.site-item', function() {
        	    var clickedId = $(this).attr('id'); // 선택된 요소 아이디 가져오기
        	    
        	    // 선택한 현장으로 이동하기
        	    window.location.href = '/worker/workerDetail.do?workerId=' + clickedId;
        	});
        	
        	
            var $div = $('.site_menu_div');
            if ($div.prop('scrollHeight') > 300) {
                $div.css('height', '540px');
            } else {
                $div.css('height', 'auto');
            }
            
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
         
         	
         	
	     	$('#WORKER_NAME').on('input', function () {
	     	    var value = $(this).val();

	     	    // 특수문자 제거 (영문, 숫자, 한글, 공백만 허용. 밑줄(_) 포함한 특수문자 제거)
	     	    var cleanValue = value.replace(/[^a-zA-Z0-9\sㄱ-ㅎㅏ-ㅣ가-힣]/g, '');

	     	    if (value !== cleanValue) {
	     	        $(this).val(cleanValue); // 특수문자 제거
	     	    }
	     	});
	     	
	     	$('#WORKER_BIRTHDAY, #WORKER_PHONE , #DANGER_DETECT_C,#DANGER_DETECT_W,#DANGER_DETECT_D,#GAS_DETECT').on('input', function () {
	     	    var value = $(this).val();

	     	    // 숫자만 남기고 모두 제거
	     	    var cleanValue = value.replace(/[^0-9]/g, '');

	     	    if (value !== cleanValue) {
	     	        $(this).val(cleanValue); // 숫자 외 문자 제거
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
            
            // 등록 기능

            $('.insertBtn').on('click', function() {
				var workerName = $('#WORKER_NAME').val();
				var siteId = $('#SITE_ID').val();
				var birth = $('#WORKER_BIRTHDAY').val();
				var phone = $('#WORKER_PHONE').val();
				var detectD = $('#DANGER_DETECT_D').val();
				var detectW = $('#DANGER_DETECT_W').val();
				var detectC = $('#DANGER_DETECT_C').val();
				var gasDetect = $('#GAS_DETECT').val();
				
				if(workerName == "") {
					alert("작업자 이름을 입력해 주세요.");
					return false;
				} else if(siteId == "none") {
					alert("연동 현장을 선택해 주세요.");
					return false;
				} else if(!$('#WORKER_GENDER_M').is(':checked') && !$('#WORKER_GENDER_F').is(':checked')) {
					alert("성별을 선택해 주세요.");
					return false;
				} else if(birth.length != 8) {
					alert("생년월일이 올바르지 않습니다. 다시 확인해 주세요.");
					return false;
				} else if(phone.length != 11 || phone.substring(0, 3) !== "010") {
					alert("전화번호 형식이 올바르지 않습니다. 다시 확인해 주세요.");
					return false;
				} else if(!$('#APPLY_FUNCTION_L').is(':checked') && !$('#APPLY_FUNCTION_G').is(':checked') && !$('#APPLY_FUNCTION_F').is(':checked')) {
					alert("적용 기능을 선택해 주세요.");
					return false;
				} else if(detectD == "" || detectW == "" || detectC == "") {
					alert("제한 구역 감지 기준을 설정해 주세요.");
					return false;
				} else if(gasDetect == "") {
					alert("유해 가스 감지 기준을 설정해 주세요.");
					return false;
				} else {
					var check = confirm("이대로 등록합니까?");
                	
                	if(check == true) {
                		alert("저장 되었습니다.");
                		frmWorker.submit();
                	} else {
                		return false;
                	}
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
                    <div class="help" style="width:110px;"><p>사용자 매뉴얼</p></div>
                    <input type="hidden" id="userInfo" value="${loginInfo.USER_ID}"></input>
                </div>
                <div class="bottomMenuDiv">
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/first.do'>현장 모니터링</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/view/viewInventory.do'>현장 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/safeevent/safeEvent.do'>안전 이벤트</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/beacon/beaconInventory.do'>비콘 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/gas/gasInventory.do'>가스 센서 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/worker/workerInventory.do'>작업자 관리</a></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">작업자 관리</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">작업자 등록</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;">작업자 관리</p>
                </div>
                <div class="site_menu_div">
                </div>
                <div class="site_insert_btn_div">
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">작업자 신규 등록</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">작업자 정보 입력</p>
                    </div>
                    <div class="table_div">
                    <form id="frmWorker" name="frmWorker" method="post" action="/worker/workerSave.do">
                        <table class="table" style="margin-bottom:20px;">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">작업자 이름</th>
                                    <td><input type="text" name="WORKER_NAME" id="WORKER_NAME"></input></td>
                                	<th scope="row">연동 현장</th>
                                    <td id="siteSelect"> </td>
                                </tr>
                                <tr>
                                    <th scope="row">소속(회사)</th>
                                    <td><input type="text" id="WORKER_ORG_NAME" value="${loginInfo.USER_ORG}" readonly></input>
                                    	<input type="hidden" name="WORKER_ORG" value="${loginInfo.ORG_ID}"></input>
                                    </td>
                                    <th scope="row">성별</th>
                                    <td style="display:flex; align-items: center;">
                                    	<input type="radio" id="WORKER_GENDER_M" name="WORKER_GENDER" value="M" style="margin:0;"></input>
                                    	<label for="WORKER_GENDER_M">
                                    		<p style="margin:0; margin-left:10px; margin-right:20px;">남성</p>
                                    	</label>
                                    	
                                    	<input type="radio" id="WORKER_GENDER_F" name="WORKER_GENDER" value="F" style="margin:0;"></input>
                                    	<label for="WORKER_GENDER_F">
                                    		<p style="margin:0; margin-left:10px;">여성</p>
                                    	</label>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td><input type="text" id="WORKER_BIRTHDAY" name="WORKER_BIRTHDAY" placeholder="YYYYMMDD" maxlength="8"></input></td>
                                    <th scope="row">전화번호</th>
                                    <td><input type="text" id="WORKER_PHONE" name="WORKER_PHONE" placeholder="- 빼고 숫자만 입력" maxlength="11"></input></td>
                                </tr>
                                <tr>
                                    <th scope="row">작업자 정보</th>
                                    <td colspan="3" ><input type="text" id="WORKER_INFO" name="WORKER_INFO"></input></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mini_title">
                            <p style="font-size: 26px; margin: 0;">제한구역 설정 정보</p>
                        </div>
                        <table class="table" style="margin-bottom:10px;">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">적용 기능</th>
                                    <td colspan="3" style="display:flex; align-items: center;">
									    <input type="checkbox" id="APPLY_FUNCTION_L" name="APPLY_FUNCTION_L" value="Y" style="margin: 0;"/>
									    <label for="APPLY_FUNCTION_L">
									        <span style="margin: 0; margin-left:10px; margin-right:20px; white-space: nowrap;">
									            제한 구역 접근 감지
									        </span>
									    </label>
									
									    <input type="checkbox" id="APPLY_FUNCTION_G" name="APPLY_FUNCTION_G" value="Y" style="margin: 0;"/>
									    <label for="APPLY_FUNCTION_G">
									        <span style=" margin: 0; margin-left:10px; margin-right:20px; white-space: nowrap;">
									            유해 가스 감지
									        </span>
									    </label>
									
									    <input type="checkbox" id="APPLY_FUNCTION_F" name="APPLY_FUNCTION_F" value="Y" style="margin: 0;"/>
									    <label for="APPLY_FUNCTION_F">
									        <span style="margin: 0; margin-left:10px; white-space: nowrap;">
									            낙상 감지
									        </span>
									    </label>
									</td>
                                </tr>
                                <tr>
                                    <th scope="row">제한 구역 감지 기준</th>
                                    <td colspan="3">
                                    	&nbsp;주의 : <input type="text" name="DANGER_DETECT_C" id="DANGER_DETECT_C" style="width:90px;"></input> m &nbsp;
                                    	&nbsp;경고 : <input type="text" name="DANGER_DETECT_W" id="DANGER_DETECT_W" style="width:90px;"></input> m &nbsp;
                                    	&nbsp;위험 : <input type="text" name="DANGER_DETECT_D" id="DANGER_DETECT_D" style="width:90px;"></input> m 
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">유해 가스 감지 기준</th>
                                    <td colspan="3"><input type="text" id="GAS_DETECT" name="GAS_DETECT" style="width:90px;"></input> ppm</td>
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