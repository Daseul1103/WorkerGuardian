<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/gas/gasDetail.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	var nowId = "${data.GAS_ID}";

        	
        	$.ajax({
	            url: "/gas/selectGas.ajax",
	            success: function(data) {
	            	console.log(data);
	            	
	            	var gasList = data.GasList;
	                var html = '';

	                if (Array.isArray(gasList) && gasList.length > 0) {
	                    gasList.forEach(function(gas) {
	                    	var highlightClass = (gas.GAS_ID === nowId) ? ' highlight' : '';
	                        html += '<div id="' + gas.GAS_ID + '" class="site-item' + highlightClass + '">' + gas.GAS_NAME + '</div>\n';
	                    });
	                } else {
	                    html = '<div class="not_site">등록된 가스 센서가 없습니다.</div>';
	                }

	                // 클래스명이 site_menu_div인 요소 안에 삽입
	                $('.site_menu_div').html(html);
	            },
	            error: function(xhr, status, error) {
	                console.log('ajax 요청에 문제가 있습니다.',error);
	            }
	        });
        	
        	

        	
        	// 현장 클릭 시 이벤트(정보 불러오기)
        	$('.site_menu_div').on('click', '.site-item', function() {
        	    var clickedId = $(this).attr('id'); // 선택된 요소 아이디 가져오기
        	    
        	    // 선택한 현장으로 이동하기
        	    window.location.href = '/gas/gasDetail.do?gasId=' + clickedId;
        	});

        	
        	
            var $div = $('.site_menu_div');
            if ($div.prop('scrollHeight') > 300) {
                $div.css('height', '540px');
            } else {
                $div.css('height', 'auto');
            }
            
            
            $('.deleteBtn').on('click', function() {
            	var chk = confirm("해당 가스 센서를 삭제하시겠습니까?");
            	
            	if(chk) {
            		var gasId = $('#gasId').val();
                	var url = '/gas/gasDelete.do?gasId='+ gasId;
                	
                	window.location.href = url;
            	} else {
            		return false;
            	}
            	
            	
            	
            	
            });
            
           $('.updateBtn').on('click', function() {
        	   var gasId = $('#gasId').val();
            	
            	window.location.href = "/gas/gasUpdate.do?gasId=" + gasId;
            }); 
            
            
            // 등록 버튼 클릭 시
            $('.site_insert_btn').on('click', function() {
            	window.location.href = "/gas/gasInsert.do";
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
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: #2e5fd7;" href='/gas/gasInventory.do'>가스 센서 관리</a></h2></div>
                    <div class="menu"><h2 style="margin: 0;"><a style="text-decoration: none; color: black;" href='/worker/workerInventory.do'>작업자 관리</a></h2></div>
                </div>
            </div>
        </div>
        <div class="bread_div">
            <div class="breadcrumb">
                <div class="home"></div>
                <div class="next"></div>
                <div class="menu1" style="color: white; font-size: 16px;">가스 센서 관리</div>
                <div class="next"></div>
                <div class="menu2" style="color: white; font-size: 16px;">가스 센서 상세 정보</div>
            </div>
        </div>
        <div class="content_div">
            <div class="site_menu">
                <div class="site_menu_title">
                    <p style="font-size: 32px; margin:0; margin-bottom: 30px; font-weight: bold;">가스 센서 관리</p>
                </div>
                <div class="site_menu_div">

                </div>
                <div class="site_insert_btn_div">
                    <div class="site_insert_btn">
                        <p>가스 센서 추가</p>
                    </div>
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">${data.GAS_NAME}</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">가스 센서 상세 정보</p>
                    </div>
                    <div class="table_div">
                    <input type="hidden" id="gasId" value="${data.GAS_ID}"></input>
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">가스 센서 ID</th>
                                    <td>${data.GAS_ID}</td>
                                    <th scope="row">가스 센서 이름</th>
                                    <td>${data.GAS_NAME}</td>
                                </tr>
                                <tr>
                                    <th scope="row">가스 센서 업체</th>
                                    <td>${data.GAS_COMPANY}</td>
                                    <th scope="row">가스 센서 종류</th>
                                    <td>${data.GAS_TYPE}</td>
                                </tr>
                                <tr>
                                    <th scope="row">할당 작업자</th>
                                    <td>
                                    	<input type="hidden" id="wokerId" value="${data.GAS_WORKER_ID}"></input>
										${data.WORKER_NAME}	
                                    </td>
                                    <th scope="row">위험 농도</th>
                                    <td>${data.DANGER_PER} ppm</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="btn_div">
                    <div class="deleteBtn">
                        <p>삭제</p>
                    </div>
                    <div class="updateBtn">
                        <p>수정</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>