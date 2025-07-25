<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/worker/workerDetail.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	var nowId = "${data.WORKER_ID}";

        	
        	$.ajax({
	            url: "/worker/selectWorker.ajax",
	            success: function(data) {
	            	
	            	var workerList = data.WorkerList;
	                var html = '';

	                if (Array.isArray(workerList) && workerList.length > 0) {
	                	workerList.forEach(function(worker) {
	                		var highlightClass = (worker.worker_ID === nowId) ? ' highlight' : '';
	                        html += '<div id="' + worker.worker_ID + '" class="site-item' + highlightClass + '">' + worker.worker_NAME + '</div>\n';
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
            
            
            $('.deleteBtn').on('click', function() {
            	var chk = confirm("해당 작업자를 삭제하시겠습니까?");
            	
            	if(chk) {
            		var workerId = $('#worker_id').val();
                	var url = '/worker/workerDelete.do?workerId='+ workerId;
                	
                	window.location.href = url;
            	} else {
            		return false;
            	}
            	
            	
            	
            	
            });
            
           $('.updateBtn').on('click', function() {
        	   var workerId = $('#worker_id').val();
            	
            	window.location.href = "/worker/workerUpdate.do?workerId=" + workerId;
            }); 
            
            
            // 등록 버튼 클릭 시
            $('.site_insert_btn').on('click', function() {
            	window.location.href = "/worker/workerInsert.do";
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
         	
         	
         	// 위치 이력 버튼 클릭 시 -> 사용자 위치 이력 모달창 띄우기
         	$('.record').on('click', function() {
         		console.log("위치 이력 버튼 클릭"); 		
         		var workerId = $('#worker_id').val();
         		
         		let childWindow = window.open(
         		        '/worker/locationList.do?workerId=' + workerId, // 열릴 URL
         		        '사용자 위치 이력 조회',     // 창 이름
         		        'width=800,height=600,scrollbars=yes,resizable=yes' // 옵션
         		 );
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
                <div class="menu2" style="color: white; font-size: 16px;">작업자 상세 정보</div>
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
                    <div class="site_insert_btn">
                        <p>작업자 추가</p>
                    </div>
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">${data.WORKER_NAME} 작업자</p>
                    </div>
                    <div class="breadcrumb">
                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">작업자 상세 정보</p>
                        <button class="record">위치 이력</button>
                    </div>
                    <div class="table_div">
                    <input type="hidden" id="worker_id" value="${data.WORKER_ID}"></input>
                        <table class="table">
                            <colgroup>
                                <col style="width: 18%;">
                                <col style="width: auto;">
                                <col style="width: 18%;">
                                <col style="width: 34%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">작업자 이름</th>
                                    <td>${data.WORKER_NAME}</td>
                                    <th scope="row">연동 현장</th>
                                    <td>
									    <c:choose>
									        <c:when test="${empty data.SITE_NAME}">
									            연동 된 현장 없음
									        </c:when>
									        <c:otherwise>
									            ${data.SITE_NAME}
									        </c:otherwise>
									    </c:choose>
									</td>
                                </tr>
                                <tr>
                                    <th scope="row">소속(회사)</th>
                                    <td>${data.WORKER_ORG_NAME}</td>
                                    <th scope="row">성별</th>
                                    <td>
	                                    <c:choose>
									        <c:when test="${data.WORKER_GENDER == 'F'}">여성</c:when>
									        <c:when test="${data.WORKER_GENDER == 'M'}">남성</c:when>
									    </c:choose>
									</td>
                                </tr>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td>${data.WORKER_BIRTHDAY}</td>
                                    <th scope="row">전화번호</th>
                                    <td>${data.WORKER_PHONE}</td>
                                </tr>
                                <tr>
                                    <th scope="row">작업자 정보</th>
                                    <td colspan="3" >${data.WORKER_INFO}</td>
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
                                    <td colspan="3">
                                    	<input type="checkbox"
									           <c:if test="${data.APPLY_FUNCTION_L == 'Y'}">checked</c:if>
									           disabled/> 제한 구역 접근 감지 &nbsp;
									
									    <input type="checkbox"
									           <c:if test="${data.APPLY_FUNCTION_G == 'Y'}">checked</c:if>
									           disabled/> 유해 가스 감지 &nbsp;
									
									    <input type="checkbox"
									           <c:if test="${data.APPLY_FUNCTION_F == 'Y'}">checked</c:if>
									           disabled/> 낙상 감지 
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">제한 구역 감지 기준</th>
                                    <td colspan="3">
                                    	주의 : ${data.DANGER_DETECT_C}m |&nbsp; 경고 : ${data.DANGER_DETECT_W}m |&nbsp; 위험 : ${data.DANGER_DETECT_D}m 
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">유해 가스 감지 기준</th>
                                    <td colspan="3">${data.GAS_DETECT} ppm</td>
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