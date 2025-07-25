<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>WorkerGuardian</title>
	<link rel="stylesheet" href="/css/view/viewDetail.css"/>
	<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/common.js"></script>

    <script>
        $(document).ready(function() {
        	var nowId = "${data.SITE_ID}";

        	//ajax 사용하여 천 진입 시 현장 목록 불러오기
        	$.ajax({
	            url: "/view/selectSite.ajax",
	            success: function(data) {
	            	
	            	var siteList = data.SiteList;
	                var html = '';

	                
	                // 같은 아이디 인 경우 효과 추가하기
	                siteList.forEach(function(site) {
        	            var highlightClass = (site.site_ID === nowId) ? ' highlight' : '';
        	            html += '<div id="' + site.site_ID + '" class="site-item' + highlightClass + '">' + site.site_NAME + '</div>\n';
        	        });

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
				window.location.href = '/view/siteDetail.do?siteId=' + clickedId;
        	});
        	
        	
        	// 파일 다운로드 클릭 시
        	$('.site_file').on('click', function () {
        		var siteId = $('#site_id').val();
  
        			window.location.href = "/view/fileDownload.do?fileId=" + siteId;    		
        	});
        	
        	
            var $div = $('.site_menu_div');
            if ($div.prop('scrollHeight') > 300) {
                $div.css('height', '540px');
            } else {
                $div.css('height', 'auto');
            }
            
            
            $('.deleteBtn').on('click', function() {
            	console.log("클릭");
            	var chk = confirm("해당 현장을 삭제하시겠습니까?");
            	
            	if(chk) {
            		var siteId = $('#site_id').val();
                	var url = '/view/siteDelete.do?siteId='+ siteId;
                	
                	window.location.href = url;
            	} else {
            		return false;
            	}
            	
            	
            	
            	
            });
            
            $('.updateBtn').on('click', function() {
            	var siteId = $('#site_id').val();
            	
            	window.location.href = "/view/viewUpdate.do?siteId=" + siteId;
            });
            
            $('.site_insert_btn').on('click', function() {
            	window.location.href = "/view/viewInsert.do";
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
                <div class="menu2" style="color: white; font-size: 16px;">현장 상세 정보</div>
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
                    <div class="site_insert_btn">
                        <p>현장 추가</p>
                    </div>
                </div>
            </div>
            <div class="site_info">
                <div class="main_title_div">
                    <div class="site_title">
                        <p id="site_title" style="font-size: 35px; font-weight: bold; margin: 0;">(주) 하이브 시스템 - ${data.SITE_NAME}</p>
                    </div>
                    <div class="breadcrumb">

                    </div>
                </div>
                <div class="main_content_div">
                    <div class="mini_title">
                        <p style="font-size: 26px; margin: 0;">상세 정보</p>
                    </div>
                    <div class="table_div">
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
                                    <td colspan="3" id="site_name">${data.SITE_NAME}</td>
                                </tr>
                                <tr>
                                    <th scope="row">현장 파일</th>
                                    <td colspan="3"><p class="site_file">${data.FILE_NAME}</p></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mini_title">
                            <p style="font-size: 26px; margin: 0;">등록 된 제한 구역 및 비콘</p>
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
                                    <th scope="row">등록된 제한 구역</th>
                                    <td colspan="3">
									    <c:choose>		       
									        <c:when test="${empty limitList}">
									            등록 된 제한 구역 없음
									        </c:when>
									        <c:otherwise>
									            <c:forEach var="item" items="${limitList}" varStatus="status">
									                ${item.BEACON_NAME}<c:if test="${!status.last}">, </c:if>
									            </c:forEach>
									        </c:otherwise>
									    </c:choose>
									</td>
                                </tr>
                                <tr>
                                    <th scope="row">등록된 비콘 수</th>
                                    <td colspan="3">${data.BEACON_COUNT}개</td>
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