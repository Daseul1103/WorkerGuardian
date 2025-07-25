<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/beacon/beaconDetail.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>
    <script>
        $(document).ready(function() {
        	var nowId = "${data.UUID}";

        	$.ajax({
	            url: "/beacon/selectBeacon.ajax",
	            success: function(data) {
	            	var beaconList = data.BeaconList;
	                var html = '';

	                if (Array.isArray(beaconList) && beaconList.length > 0) {
	                	beaconList.forEach(function(beacon) {
	                		var highlightClass = (beacon.uuid === nowId) ? ' highlight' : '';
	                        html += '<div id="' + beacon.uuid + '" class="site-item' + highlightClass + '">' + beacon.beacon_NAME + '</div>\n';
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
            
            
            $('.deleteBtn').on('click', function() {
            	var chk = confirm("해당 비콘을 삭제하시겠습니까?");
            	
            	if(chk) {
            		var uuid = $('#uuid').val();
                	var url = '/beacon/beaconDelete.do?uuid='+ uuid;
                	
                	window.location.href = url;
            	} else {
            		return false;
            	}
            	
            	
            	
            	
            });
            
           $('.updateBtn').on('click', function() {
        	   var uuid = $('#uuid').val();
            	
            	window.location.href = "/beacon/beaconUpdate.do?uuid=" + uuid;
            }); 
            
            
            // 등록 버튼 클릭 시
            $('.site_insert_btn').on('click', function() {
            	window.location.href = "/beacon/beaconInsert.do";
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
                <div class="menu2" style="color: white; font-size: 16px;">비콘 상세 정보</div>
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
                    <div class="site_insert_btn">
                        <p>비콘 추가</p>
                    </div>
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">${data.BEACON_NAME}</p>
                    </div>
                    <div class="breadcrumb">
                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">상세 정보</p>
                    </div>
                    <div class="table_div">
                    <input type="hidden" id="uuid" value="${data.UUID}"></input>
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
                                    <td>${data.BEACON_NAME}</td>
                                    <th scope="row">UUID</th>
                                    <td>${data.UUID}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Major</th>
                                    <td>${data.MAJOR}</td>
                                    <th scope="row">Minor</th>
                                    <td>${data.MINOR}</td>
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
                                    <td colspan="3">
                                    	<input type="radio" id="yes" name="limitFlag" value="Y"
									        <c:if test="${data.LIMIT_FLAG == 'Y'}">checked</c:if>
									        <c:if test="${data.LIMIT_FLAG != 'Y'}">disabled</c:if> /> 예
									
									    <input type="radio" id="no" name="limitFlag" value="N"
									        <c:if test="${data.LIMIT_FLAG == 'N'}">checked</c:if>
									        <c:if test="${data.LIMIT_FLAG != 'N'}">disabled</c:if> /> 아니오
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">적용 현장 선택</th>
                                    <td>
									  <c:choose>
									    <c:when test="${data.SITE_ID == 'none'}">
									      선택된 현장 없음
									    </c:when>
									    <c:otherwise>
									      ${data.SITE_NAME}
									    </c:otherwise>
									  </c:choose>
									</td>
                                    <th scope="row">비콘 위험 거리</th>
                                    <td>${data.DANGER_DISTANCE} m</td>
                                </tr>
                                <tr>
                                    <th scope="row">비콘 X축 위치</th>
                                    <td>${data.BEACON_X} %</td>
                                    <th scope="row">비콘 Y축 위치</th>
                                    <td>${data.BEACON_Y} %</td>
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
                <form id="frmSite" name="frmSite" method="post">
                	<input type="hidden" id="site_id" name="SITE_ID" value="${data.SITE_ID}"></input>
                </form>
            </div>
        </div>
    </div>
</body>
</html>